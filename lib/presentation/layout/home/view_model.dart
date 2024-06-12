import 'package:dio/dio.dart';
import 'package:donation/app/api.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/domain/model/post_model.dart';
import 'package:donation/presentation/_resources/component/toast.dart';
import 'package:donation/presentation/auth/auth_view_model.dart';
import 'package:donation/services/dio_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class HomeCtrl extends Cubit<HomeStates> {
  HomeCtrl() : super(HomeInitialState());

  final _http = HttpUtil();

  PostModel? _model;
  final List<Document> posts = [];

  void getPosts() {
    posts.clear();
    emit(GetPostsLoadingState());
    _http.get(ApiUrl.getPosts).then((response) {
      _model = PostModel.fromJson(response);
      if (_model == null) {
        ShowToast.error(response['status']);
        emit(GetPostsErrorState());
        return;
      }
      ShowToast.success(response['status']);
      posts.addAll(_model!.data!.document!);
      emit(GetPostsLoadedState(posts));
    }).catchError((error) {
      ShowToast.error(error.toString());

      emit(GetPostsErrorState());
    });
  }

  final contentCtrl = TextEditingController();

  void createPost() {
    emit(CreatePostLoadingState());
    _http.post(
      ApiUrl.createPost,
      data: {
        "content": contentCtrl.text,
        "userID": AuthCtrl.usrId,
      },
    ).then((response) {
      if (images.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          _uploadPhotos(
            response['data']['document']['_id'],
            images[i],
            i == images.length - 1,
          );
        }
      } else {
        contentCtrl.clear();
        getPosts();
        emit(CreatePostLoadedState());
      }
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  List<XFile> images = [];
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
        contentCtrl.clear();
        images.clear();
        isPostContainPhotos = false;
        getPosts();
        emit(CreatePostLoadedState());
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

  void updatePost(Document post) {
    int index = posts.indexOf(post);
    emit(GetPostsLoadingState());
    _http.delete(ApiUrl.updatePost + post.id!).then((response) {
      ShowToast.success(response['status']);
      // posts.remove(post);
      posts[index].copyWith(
        content: contentCtrl.text,
      );
      emit(GetPostsLoadedState(posts));
    }).catchError((error) {
      ShowToast.error(error.toString());
      emit(GetPostsErrorState());
    });
  }
}

abstract class HomeStates {}

final class HomeInitialState extends HomeStates {}

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
