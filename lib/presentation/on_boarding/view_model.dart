import '../../app/global_imports.dart';
import '../../domain/model/models.dart';

class OnBoardingVM extends Cubit<AppCubitStates> {
  OnBoardingVM() : super(OnBoardInitState());

  List<SliderObject> get slidersData => _getSliderData;

  int currentIndex = 0;

  void changeOnBoardPageIndex(int index) {
    currentIndex = index;
    emit(ChangeOnBoardPageIndexState());
  }

  final List<SliderObject> _getSliderData = [
    SliderObject(AppStrings.onBoardTitle1, AppAssets.onBoardingImg1),
    SliderObject(AppStrings.onBoardTitle2, AppAssets.onBoardingImg2),
    SliderObject(AppStrings.onBoardTitle3, AppAssets.onBoardingImg3),
  ];
}
