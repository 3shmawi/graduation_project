import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/api.dart';
import '../../../app/global_imports.dart';
import '../../../services/dio_helper.dart';
import '../../_resources/component/toast.dart';


class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());
  final emailCtrl = TextEditingController();
  final _http = HttpUtil();

  void requestPasswordReset(String email) async {
    emit(ForgotPasswordLoading());
    if (_isFieldEmpty()) {
      ShowToast.error("Please fill all fields");
      emit(ForgotPasswordFailure());
    } else {
      _http.post(
        ApiUrl.forgetPass,

      )
          .then((onValue) {
        if (onValue["status"] == "success") {
          ShowToast.success(onValue['status']);
          emit(ForgotPasswordSuccess());
        } else {
          ShowToast.error(onValue['message']);
          emit(ForgotPasswordFailure());
        }
      }).catchError((error) {
        ShowToast.error("An error occurred ${error.toString()}");
        emit(ForgotPasswordFailure());
      }
      );
    }
  }

  bool _isFieldEmpty() => emailCtrl.text.isEmpty;
}
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {}

class ForgotPasswordFailure extends ForgotPasswordState {}
