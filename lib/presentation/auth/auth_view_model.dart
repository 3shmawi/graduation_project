import 'package:dio/dio.dart';
import 'package:donation/app/api.dart';
import 'package:donation/app/enums.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/domain/model/user_model.dart';
import 'package:donation/presentation/_resources/component/toast.dart';
import 'package:donation/services/dio_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../services/local_database.dart';

class AuthCtrl extends Cubit<AuthStates> {
  AuthCtrl() : super(AuthInitialState());

  static String? usrToken = CacheHelper.getData(key: SharedPrefKeys.userToken);
  static String? usrId = CacheHelper.getData(key: SharedPrefKeys.userId);

  Model? get userData => _model;

  final _http = HttpUtil();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  Model? _model;

  void login() {
    CacheHelper.removeData(key: SharedPrefKeys.userToken);
    emit(AuthLoginLoadingState());
    if (_isFieldAtLoginEmpty()) {
      ShowToast.error("Please fill all fields");
      emit(AuthLoginErrorState());
    } else {
      _http.post(
        ApiUrl.signIn,
        data: {
          'email': emailCtrl.text.trim(),
          "userType": "organization",
          'password': passwordCtrl.text,
        },
      ).then((value) {
        if (value['status'] == "success") {
          _model = Model.fromJson(value["data"]["model"]);
          usrToken = value["token"];
          usrId = value["data"]["model"]["_id"];

          if (saveLoginProcess) {
            CacheHelper.saveData(
              key: SharedPrefKeys.userId,
              value: usrId,
            );
            CacheHelper.saveData(
              key: SharedPrefKeys.userToken,
              value: usrToken,
            );
          }
          ShowToast.success(value['status']);
          emit(AuthLoginSuccessState());
        } else {
          ShowToast.error(value['message']);
          emit(AuthLoginErrorState());
        }
      }).catchError((e) {
        // ShowToast.error("An error occurred ${e.toString()}");
        emit(AuthLoginErrorState());
      });
    }
  }

  bool _isFieldAtLoginEmpty() =>
      emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty;

  bool isUser = CacheHelper.getData(key: SharedPrefKeys.isUser) ?? true;

  void changeRole() {
    isUser = !isUser;
    CacheHelper.saveData(key: SharedPrefKeys.isUser, value: isUser);
    emit(ChangeUserTypeState());
  }

  void register() {
    CacheHelper.removeData(key: SharedPrefKeys.userToken);

    emit(AuthRegisterLoadingState());
    if (_isFieldAtRegisterEmpty()) {
      ShowToast.error("Please fill all the fields");
      emit(AuthRegisterErrorState());
    } else {
      _http.post(
        ApiUrl.signUp,
        data: {
          'userName': nameCtrl.text,
          'email': emailCtrl.text.trim(),
          'userType': isUser ? "user" : "organization",
          'city': locationCtrl.text,
          'password': passwordCtrl.text,
          'passwordConfirm': confirmPasswordCtrl.text,
        },
      ).then((value) {
        if (value['status'] == "success") {
          ShowToast.success(value['status']);
          emit(AuthRegisterSuccessState(isUser: isUser));
        } else {
          ShowToast.error(value['message']);
          emit(AuthRegisterErrorState());
        }
      }).catchError((e) {
        // ShowToast.error("An error occurred ${e.toString()}");
        emit(AuthRegisterErrorState());
      });
    }
  }

  bool _isFieldAtRegisterEmpty() =>
      nameCtrl.text.isEmpty ||
      emailCtrl.text.isEmpty ||
      passwordCtrl.text.isEmpty ||
      confirmPasswordCtrl.text.isEmpty;

  bool saveLoginProcess = true;

  void changeSaveLoginState() {
    saveLoginProcess = !saveLoginProcess;
    emit(ChangeSaveLoginState());
  }

  void logout() {
    emit(LogoutLoadingState());
    _http.get(ApiUrl.signOut).then((response) {
      if (response['status'] == "success") {
        ShowToast.success(response['status']);
        FirebaseMessaging.instance.unsubscribeFromTopic(usrId!);
        CacheHelper.removeData(key: SharedPrefKeys.userId);
        CacheHelper.removeData(key: SharedPrefKeys.userToken);
        _model = null;

        emit(AuthLogoutSuccessState());
      } else {
        ShowToast.error(response['message']);
        emit(AuthLogoutErrorState());
      }
    }).catchError((e) {
      ShowToast.error("An error occurred ${e.toString()}");
      emit(AuthLogoutErrorState());
    });
  }

  //profile
  void getUsrData() {
    _http.get(ApiUrl.getProfile).then((response) {
      if (response['status'] == "success") {
        _model = Model.fromJson(response["data"]["document"]);

        emit(AuthLoginSuccessState());
      } else {
        ShowToast.error(response['message']);
        emit(AuthLoginErrorState());
      }
    });
  }

  XFile? image;

  final _picker = ImagePicker();

  void pickImage() async {
    image = null;
    image = await _picker.pickImage(source: ImageSource.gallery);
    emit(SelectImageState());
  }

  void updateProfile() async {
    emit(AuthEditProfileLoadingState());
    if (nameCtrl.text.isNotEmpty) {
      final FormData formData;
      if (image == null) {
        final name = MultipartFile.fromString(
          nameCtrl.text,
        );
        formData = FormData.fromMap({
          "userName": name,
        });
      } else {
        final sImage = await MultipartFile.fromFile(
          image!.path,
          filename: path.basename(image!.path),
        );
        final name = MultipartFile.fromString(
          nameCtrl.text,
        );
        formData = FormData.fromMap({
          "photo": sImage,
          "userName": name,
        });
      }

      _http
          .patch(
        ApiUrl.updateProfile,
        data: formData,
      )
          .then((response) {
        if (response['status'] == "success") {
          ShowToast.success(response['status']);
          getUsrData();
        } else {
          ShowToast.error(response['message']);
          emit(AuthEditProfileErrorState());
        }
      }).catchError((error) {
        // ShowToast.error("An error occurred ${error.toString()}");
        emit(AuthEditProfileErrorState());
      });
    } else {
      ShowToast.error("Please Enter a username");
      emit(AuthEditProfileErrorState());
    }
  }

  void deleteProfile() {
    emit(DeleteProfileLoading());
    _http.delete(ApiUrl.deleteProfile).then((response) {
      if (response['status'] == "success") {
        ShowToast.success(response['status']);
        CacheHelper.removeData(key: SharedPrefKeys.userId);
        CacheHelper.removeData(key: SharedPrefKeys.userToken);
        emit(DeleteProfileSuccess());
      } else {
        ShowToast.error(response['message']);
        emit(AuthEditProfileErrorState());
      }
    });
  }
}

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

// login
class AuthLoginLoadingState extends AuthStates {}

class AuthLoginSuccessState extends AuthStates {}

class AuthLoginErrorState extends AuthStates {}

// register
class AuthRegisterLoadingState extends AuthStates {}

class AuthRegisterSuccessState extends AuthStates {
  final bool isUser;
  AuthRegisterSuccessState({required this.isUser});
}

class AuthRegisterErrorState extends AuthStates {}

// register
class AuthLogoutLoadingState extends AuthStates {}

class AuthLogoutSuccessState extends AuthStates {}

class AuthLogoutErrorState extends AuthStates {}

//edit profile
class AuthEditProfileLoadingState extends AuthStates {}

class AuthEditProfileSuccessState extends AuthStates {}

class AuthEditProfileErrorState extends AuthStates {}

//other
class ChangeSaveLoginState extends AuthStates {}

class ChangeUserTypeState extends AuthStates {}

class SelectImageState extends AuthStates {}

class DeleteProfileLoading extends AuthStates {}

class DeleteProfileSuccess extends AuthStates {}

class LogoutLoadingState extends AuthStates {}
