import 'package:dio/dio.dart';
import 'package:donation/app/api.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/_resources/component/toast.dart';
import 'package:donation/presentation/auth/auth_view_model.dart';
import 'package:donation/services/dio_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../../../domain/model/messages.dart';
import '../../../../domain/model/notification.dart';
import '../../../../domain/model/post_model.dart';
import '../notifications/view_model.dart';

class CommentsCtrl extends Cubit<CommentsStates> {
  CommentsCtrl() : super(CommentsInitialState());

  final _http = HttpUtil();

  PostModel? _model;
  final List<Document> comments = [];

  void getComments([String? postId]) {
    comments.clear();
    emit(GetCommentsLoadingState());
    _http.get(ApiUrl.getComments).then((response) {
      _model = PostModel.fromJson(response);
      if (_model == null) {
        ShowToast.error(response['status']);
        emit(GetCommentsErrorState());
        return;
      }
      ShowToast.success(response['status']);
      comments.addAll(_model!.data!.document!);
      if (postId != null) {
        emit(
          GetCommentsLoadedState(
            comments.where((comments) => comments.postID == postId).toList(),
          ),
        );
      } else {
        emit(GetCommentsLoadedState(comments));
      }
    }).catchError((error) {
      ShowToast.error(error.toString());

      emit(GetCommentsErrorState());
    });
  }

  final contentCtrl = TextEditingController();

  void createComment(Document post, sender) {
    emit(CreateCommentsLoadingState());
    _http.post(
      ApiUrl.createComment,
      data: {
        "userID": AuthCtrl.usrId,
        "postID": post.id,
        "content": contentCtrl.text,
      },
    ).then((response) {
      if (images.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          _uploadPhotos(response['data']['document']['_id'], post, images[i],
              i == images.length - 1, sender);
        }
      } else {
        contentCtrl.clear();
        final comment = Document.fromJson(response['data']['document']);

        comments.insert(0, comment);

        ShowToast.success(response['status']);

        final createdAt = DateTime.now().toIso8601String();
        HandleNotification().sendNotification(
          NotificationModel(
            id: createdAt,
            type: "comment",
            title: "${sender.userName} Has commented at your post",
            createdAt: createdAt,
            from: User(
                id: sender.id!,
                name: sender.userName!,
                avatarUrl: sender.photoLink),
            to: User(
              id: post.userID!.id!,
              name: post.userID!.userName!,
              avatarUrl: post.userID!.photoLink,
            ),
            commentId: comment.id,
            isRead: false,
          ),
        );
        emit(
          GetCommentsLoadedState(
            comments.where((comments) => comments.postID == post.id).toList(),
          ),
        );
      }
    }).catchError((error) {
      emit(CreateCommentsErrorState());
    });
  }

  List<XFile> images = [];
  final ImagePicker _picker = ImagePicker();

  void pickImages() async {
    images.clear();
    images = await _picker.pickMultiImage();
    emit(SelectImagesState());
  }

  void _uploadPhotos(
      String commentId, Document post, XFile image, bool isLast, sender) async {
    final multipartImage = await MultipartFile.fromFile(
      image.path,
      filename: path.basename(image.path),
    );
    final formData = FormData.fromMap({
      "photo": multipartImage,
    });
    _http
        .patch(
      ApiUrl.updateCommentPhoto + commentId,
      data: formData,
    )
        .then((response) {
      if (isLast) {
        contentCtrl.clear();
        images.clear();
        isCommentContainPhotos = false;
        final comment = Document.fromJson(response['data']['document']);
        comments.insert(0, comment);
        ShowToast.success(response['status']);
        final createdAt = DateTime.now().toIso8601String();

        HandleNotification().sendNotification(
          NotificationModel(
            id: createdAt,
            type: "comment",
            title: "${sender.userName} Has commented at your post",
            createdAt: createdAt,
            from: User(
                id: sender.id!,
                name: sender.userName!,
                avatarUrl: sender.photoLink),
            to: User(
              id: post.userID!.id!,
              name: post.userID!.userName!,
              avatarUrl: post.userID!.photoLink,
            ),
            commentId: comment.id,
            isRead: false,
          ),
        );
        emit(
          GetCommentsLoadedState(
            comments.where((comments) => comments.postID == post.id).toList(),
          ),
        );
      }
    }).catchError((error) {
      emit(CreateCommentsErrorState());
    });
  }

  bool isCommentContainPhotos = false;

  void changeCommentContainPhotos(bool isContainPhotos) {
    if (isCommentContainPhotos) {
      images.clear();
    }
    isCommentContainPhotos = isContainPhotos;
    emit(ChangeCommentsContainPhotosState());
  }

  void deleteComments(Document comment) {
    emit(GetCommentsLoadingState());
    _http.delete(ApiUrl.deleteComment + comment.id!).then((response) {
      ShowToast.success(response['status']);
      getComments(comment.postID);
    }).catchError((error) {
      ShowToast.error(error.toString());
      emit(GetCommentsErrorState());
    });
  }

// void updateComments(Document comment,String) {
//   emit(GetCommentsLoadingState());
//   _http.patch(ApiUrl.updateComment + comment.id!).then((response) {
//     ShowToast.success(response['status']);
//    getComments();
//    getPostComments();
//   }).catchError((error) {
//     ShowToast.error(error.toString());
//     emit(GetCommentsErrorState());
//   });
// }
}

abstract class CommentsStates {}

final class CommentsInitialState extends CommentsStates {}

final class CommentsInitialTabState extends CommentsStates {}

final class GetCommentsLoadingState extends CommentsStates {}

final class GetCommentsLoadedState extends CommentsStates {
  final List<Document> comments;

  GetCommentsLoadedState(this.comments);
}

final class GetCommentsErrorState extends CommentsStates {}

final class CreateCommentsLoadingState extends CommentsStates {}

final class CreateCommentsLoadedState extends CommentsStates {}

final class CreateCommentsErrorState extends CommentsStates {}

//other
final class SelectImagesState extends CommentsStates {}

final class ChangeCommentsContainPhotosState extends CommentsStates {}
