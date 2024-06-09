import 'package:donation/app/api.dart';
import 'package:donation/app/enums.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/domain/model/user_model.dart';
import 'package:donation/services/dio_helper.dart';

import '../../services/local_database.dart';

class AuthCtrl extends Cubit<AuthStates> {
  AuthCtrl() : super(AuthInitialState());

  static String? usrToken = CacheHelper.getData(key: SharedPrefKeys.userToken);
  static String? usrId = CacheHelper.getData(key: SharedPrefKeys.userId);

  UserModel? get userData => _user;

  final _http = HttpUtil();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  UserModel? _user;

  void login() {
    emit(AuthLoginLoadingState());
    _http.post(
      ApiUrl.signIn,
      data: {
        'email': emailCtrl.text,
        'password': passwordCtrl.text,
      },
    ).then((value) {
      _user = UserModel.fromJson(value);
      if (saveLoginProcess) {
        CacheHelper.saveData(
          key: SharedPrefKeys.userId,
          value: _user!.data!.user!.id,
        );
        CacheHelper.saveData(
          key: SharedPrefKeys.userToken,
          value: _user!.token,
        );
      }
      emit(AuthLoginSuccessState());
    }).catchError((e) {
      emit(AuthLoginErrorState(e.toString()));
    });
  }

  bool isFieldAtLoginEmpty() =>
      emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty;

  void register() {
    emit(AuthRegisterLoadingState());
    _http.post(
      ApiUrl.signUp,
      data: {
        'email': emailCtrl.text,
        'password': passwordCtrl.text,
        'passwordConfirm': confirmPasswordCtrl.text,
      },
    ).then((value) {
      emit(AuthRegisterSuccessState());
    }).catchError((e) {
      emit(AuthRegisterErrorState(e.toString()));
    });
  }

  bool isFieldAtRegisterEmpty() =>
      nameCtrl.text.isEmpty ||
      emailCtrl.text.isEmpty ||
      passwordCtrl.text.isEmpty ||
      confirmPasswordCtrl.text.isEmpty;

  bool saveLoginProcess = true;

  void changeSaveLoginState() {
    saveLoginProcess = !saveLoginProcess;
    emit(ChangeSaveLoginState());
  }
}

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

// login
class AuthLoginLoadingState extends AuthStates {}

class AuthLoginSuccessState extends AuthStates {}

class AuthLoginErrorState extends AuthStates {
  final String message;

  AuthLoginErrorState(this.message);
}

// register
class AuthRegisterLoadingState extends AuthStates {}

class AuthRegisterSuccessState extends AuthStates {}

class AuthRegisterErrorState extends AuthStates {
  final String message;

  AuthRegisterErrorState(this.message);
}

//other
class ChangeSaveLoginState extends AuthStates {}
