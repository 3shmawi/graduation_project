import 'dart:io';

import 'package:donation/app/config.dart';
import 'package:donation/presentation/layout/profile/view_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:launch_review/launch_review.dart';

class AppService {
 static Future<bool?> checkInternet() async {
    bool? internet;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
        internet = true;
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
      internet = false;
    }
    return internet;
  }

 static Future openLink(context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      //error
    }
  }

static  Future openEmailSupport(context) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: AppConfigs.supportEmail,
      query:
          'subject=About ${AppConfigs.appName}&body=', //add subject and body here
    );

    if (!await launchUrl(uri)) {}
  }

 static Future launchAppReview(context) async {
    final packageName = context.watch<SettingVM>().packageName;
    await LaunchReview.launch(
        androidAppId: packageName,
        iOSAppId: AppConfigs.iOSAppId,
        writeReview: false);
    if (Platform.isIOS) {
      if (AppConfigs.iOSAppId == '000000') {}
    }
  }
}
