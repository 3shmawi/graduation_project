import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/layout/home/view.dart';

import 'campaign/view.dart';

class LayoutVM extends Cubit<AppCubitStates> {
  LayoutVM() : super(LayoutInitState());

  List<Widget> pages = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const CampaignPage(),
  ];
  int currentIndex = 0;

  void changeCurrentIndex(int n) {
    currentIndex = n;
    emit(ChangeLayoutPageIndexState());
  }
}
