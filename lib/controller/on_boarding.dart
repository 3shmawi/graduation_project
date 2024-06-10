import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingCtrl extends Cubit<OnBoardingStates> {
  OnBoardingCtrl() : super(OnBoardingInitial());
}

abstract class OnBoardingStates {}

class OnBoardingInitial extends OnBoardingStates {}
