import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/layout/home/view.dart';
import 'package:donation/presentation/layout/profile/view.dart';

import 'bookmark/view.dart';
import 'campaign/view.dart';
import 'chats/view.dart';

class LayoutVM extends Cubit<AppCubitStates> {
  LayoutVM() : super(LayoutInitState());

  final ctrl = PageController();

  List<Widget> pages = [
    const HomePage(),
    const CampaignPage(),
    const ChatsPage(),
    const BookMarkPage(),
    const ProfilePage(),
  ];
  int currentIndex = 0;

  void changeCurrentIndex(int n, [bool isAnimate = true]) {
    currentIndex = n;

    emit(ChangeLayoutPageIndexState());
  }
}
