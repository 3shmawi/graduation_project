import 'package:donation/app/api.dart';
import 'package:donation/app/enums.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/domain/model/user_model.dart';
import 'package:donation/presentation/_resources/component/toast.dart';
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
    if (_isFieldAtLoginEmpty()) {
      ShowToast.error("Please fill all fields");
      emit(AuthLoginErrorState());
    } else {
      _http.post(
        ApiUrl.signIn,
        data: {
          'email': emailCtrl.text.trim(),
          'password': passwordCtrl.text,
        },
      ).then((value) {
        if (value['status'] == "success") {
          _user = UserModel.fromJson(value);
          usrToken = _user!.token!;
          usrId = _user!.data!.model!.id;
          if (saveLoginProcess) {
            CacheHelper.saveData(
              key: SharedPrefKeys.userId,
              value: _user!.data!.model!.id,
            );
            CacheHelper.saveData(
              key: SharedPrefKeys.userToken,
              value: _user!.token,
            );
          }
          ShowToast.success(value['status']);
          emit(AuthLoginSuccessState());
        } else {
          ShowToast.error(value['message']);
          emit(AuthLoginErrorState());
        }
      }).catchError((e) {
        ShowToast.error("An error occurred ${e.toString()}");
        emit(AuthLoginErrorState());
      });
    }
  }

  bool _isFieldAtLoginEmpty() =>
      emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty;

  void register() {
    emit(AuthRegisterLoadingState());
    if (_isFieldAtRegisterEmpty()) {
      ShowToast.error("Please fill all the fields");
      emit(AuthRegisterErrorState());
    } else {
      _http.post(
        ApiUrl.signUp,
        data: {
          'email': emailCtrl.text.trim(),
          'password': passwordCtrl.text,
          'passwordConfirm': confirmPasswordCtrl.text,
        },
      ).then((value) {
        if (value['status'] == "success") {
          ShowToast.success(value['status']);
          emit(AuthRegisterSuccessState());
        } else {
          ShowToast.error(value['message']);
          emit(AuthRegisterErrorState());
        }
      }).catchError((e) {
        ShowToast.error("An error occurred ${e.toString()}");
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
}

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

// login
class AuthLoginLoadingState extends AuthStates {}

class AuthLoginSuccessState extends AuthStates {}

class AuthLoginErrorState extends AuthStates {}

// register
class AuthRegisterLoadingState extends AuthStates {}

class AuthRegisterSuccessState extends AuthStates {}

class AuthRegisterErrorState extends AuthStates {}

//other
class ChangeSaveLoginState extends AuthStates {}
