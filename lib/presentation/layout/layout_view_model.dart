import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/layout/home/view.dart';
import 'package:donation/presentation/layout/profile/view.dart';

import 'campaign/view.dart';
import 'chats/view.dart';
import 'fields/view.dart';

class LayoutVM extends Cubit<AppCubitStates> {
  LayoutVM() : super(LayoutInitState());

  List<Widget> pages = [
    const HomePage(),
    const CampaignPage(),
    const ChatsPage(),
    const FieldsPage(),
    const ProfilePage(),
  ];
  int currentIndex = 0;

  void changeCurrentIndex(int n) {
    currentIndex = n;
    emit(ChangeLayoutPageIndexState());
  }
}
