import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:donation/app/api.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/domain/model/post_model.dart';
import 'package:donation/presentation/_resources/component/toast.dart';
import 'package:donation/presentation/auth/auth_view_model.dart';
import 'package:donation/services/dio_helper.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../../domain/model/likes.dart';
import '../bookmark/model/post.dart';

class HomeCtrl extends Cubit<HomeStates> {
  HomeCtrl() : super(HomeInitialState());

  final _http = HttpUtil();
  TabController? tabCtrl;

  void initTacCtrl(TabController tab) {
    tabCtrl = tab;
    emit(HomeInitialTabState());
  }

  void animateTo(int index) {
    tabCtrl!.animateTo(index);
    emit(GetPostsLoadedState(posts));
  }

  PostModel? _model;
  final List<Document> posts = [];

  void getPosts() {
    isEdit = false;
    posts.clear();
    emit(GetPostsLoadingState());
    _http.get(ApiUrl.getPosts).then((response) {
      _model = PostModel.fromJson(response);
      if (_model == null) {
        ShowToast.error(response['status']);
        emit(GetPostsErrorState());
        return;
      }
      posts.addAll(_model!.data!.document!);
      contentCtrl.clear();
      images.clear();
      photos.clear();
      urlImages.clear();
      isPostContainPhotos = false;
      emit(GetPostsLoadedState(posts));
    }).catchError((error) {
      ShowToast.error(error.toString());

      emit(GetPostsErrorState());
    });
  }

  void getPosts3() {
    emit(GetPostsLoadedState(posts));
  }

  final contentCtrl = TextEditingController();

  void createPost() {
    emit(CreatePostLoadingState());
    if (contentCtrl.text.length > 15) {
      _http.post(
        ApiUrl.createPost,
        data: {"content": contentCtrl.text, "userID": "${AuthCtrl.usrId}"},
      ).then((response) {
        isEdit = false;

        if (images.isNotEmpty) {
          for (int i = 0; i < images.length; i++) {
            _uploadPhotos(
              response['data']['document']['_id'],
              images[i],
              i == images.length - 1,
            );
          }
        } else {
          final post = Document.fromJson(response['data']['document']);

          posts.insert(0, post);
          animateTo(0);

          ShowToast.success(response['status']);

          emit(GetPostsLoadedState(posts));
        }
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    } else {
      ShowToast.error("Content is too short");
      emit(CreatePostErrorState());
    }
  }

  List<XFile> images = [];
  List<String> urlImages = [];
  List<String> photos = [];

  void closeImg(int index, [bool isFile = true]) {
    if (isFile) {
      images.removeAt(index);
    } else {
      urlImages.removeAt(index);
    }
    emit(SelectImagesState());
  }

  bool isEdit = false;

  Document? post;

  void edit({
    required Document post,
  }) {
    isEdit = true;
    this.post = post;
    contentCtrl.text = post.content!;
    if (post.photosLink!.isNotEmpty && post.photos!.isNotEmpty) {
      urlImages = post.photosLink!;
      photos = post.photos!;
    }
    animateTo(2);
    emit(ChangeEditState());
  }

  final ImagePicker _picker = ImagePicker();

  void pickImages() async {
    images.clear();
    images = await _picker.pickMultiImage();
    emit(SelectImagesState());
  }

  void _uploadPhotos(String postId, XFile image, bool isLast) async {
    final multipartImage = await MultipartFile.fromFile(
      image.path,
      filename: path.basename(image.path),
    );
    final formData = FormData.fromMap({
      "photo": multipartImage,
    });
    _http
        .patch(
      ApiUrl.updatePostPhoto + postId,
      data: formData,
    )
        .then((response) {
      if (isLast) {
        post = null;
        isEdit = false;

        animateTo(0);
        getPosts();
      }
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  bool isPostContainPhotos = false;

  void changePostContainPhotos(bool isContainPhotos) {
    if (isPostContainPhotos) {
      images.clear();
    }
    isPostContainPhotos = isContainPhotos;
    emit(ChangePostContainPhotosState());
  }

  void deletePost(Document post) {
    emit(GetPostsLoadingState());
    _http.delete(ApiUrl.deletePost + post.id!).then((response) {
      ShowToast.success(response['status']);
      posts.remove(post);
      emit(GetPostsLoadedState(posts));
    }).catchError((error) {
      ShowToast.error(error.toString());
      emit(GetPostsErrorState());
    });
  }

  void updatePost() {
    int index = posts.indexOf(post!);
    emit(GetPostsLoadingState());
    _http
        .patch(
      ApiUrl.updatePost + post!.id!,
      data: posts[index]
          .copyWith(
            content: contentCtrl.text,
            photosLink: urlImages,
            updatedAt: DateTime.now().toString(),
            photos: photos,
          )
          .toJson(),
    )
        .then((response) {
      if (images.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          _uploadPhotos(
            response['data']['document']['_id'],
            images[i],
            i == images.length - 1,
          );
        }
      } else {
        animateTo(0);
        getPosts();
      }
    }).catchError((error) {
      ShowToast.error(error.toString());
      emit(GetPostsErrorState());
    });
  }

  //likes
  final _fireStore = FirebaseFirestore.instance;

  Stream<List<LikesModel>> getPostLikes(String postId) {
    return _fireStore
        .collection('posts')
        .doc(postId)
        .collection("likes")
        .where("isLiked", isEqualTo: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return LikesModel.fromJson(doc.data());
      }).toList();
    });
  }

  void like(String postId, bool isLiked, String name, String img) {
    _fireStore
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(AuthCtrl.usrId)
        .set(
      {
        "id": AuthCtrl.usrId,
        "isLiked": isLiked,
        "name": name,
        "img": img,
      },
      SetOptions(merge: true),
    );
  }

  //local storage
  late Box<Post> postBox;

  Future<void> openBox() async {
    postBox = await Hive.openBox<Post>('posts');
  }

  void addPost(Post post) {
    if (postIndex(post.postId) == -1) {
      postBox.add(post);
    } else {
      postBox.deleteAt(postIndex(post.postId));
    }
    emit(AddToBookMark());
  }

  int postIndex(String id) {
    //get index
    for (int i = 0; i < postBox.values.length; i++) {
      if (postBox.values.elementAt(i).postId == id) {
        return i;
      }
    }
    return -1;
  }
}

abstract class HomeStates {}

final class HomeInitialState extends HomeStates {}

final class HomeInitialTabState extends HomeStates {}

final class GetPostsLoadingState extends HomeStates {}

final class GetPostsLoadedState extends HomeStates {
  final List<Document> posts;

  GetPostsLoadedState(this.posts);
}

final class GetPostsErrorState extends HomeStates {}

final class CreatePostLoadingState extends HomeStates {}

final class CreatePostLoadedState extends HomeStates {}

final class CreatePostErrorState extends HomeStates {}

//other
final class SelectImagesState extends HomeStates {}

final class ChangePostContainPhotosState extends HomeStates {}

final class LikeDisLikeState extends HomeStates {
  final List<Document> likes;

  LikeDisLikeState(this.likes);
}

final class LoadingState extends HomeStates {}

final class NotLoadingState extends HomeStates {}

final class ChangeEditState extends HomeStates {}

final class AddToBookMark extends HomeStates {}
