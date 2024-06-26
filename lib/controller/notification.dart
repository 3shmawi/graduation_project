import 'package:donation/app/enums.dart';
import 'package:donation/services/local_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCtrl extends Cubit<bool> {
  NotificationCtrl()
      : super(CacheHelper.getData(key: SharedPrefKeys.notificationEnable) ??
            true);

  void changeNotification(bool value, String usrId) {
    CacheHelper.saveData(key: SharedPrefKeys.notificationEnable, value: value);
    if (value) {
      FirebaseMessaging.instance.subscribeToTopic(usrId);
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic(usrId);
    }
    emit(value);
  }
}
