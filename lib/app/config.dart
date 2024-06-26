import 'package:easy_localization/easy_localization.dart';

import '../presentation/_resources/assets_manager.dart';
import '../presentation/_resources/strings_manager.dart';

abstract class AppConfigs {
  static get appName => 'app_name'.tr();

  static const defaultImg =
      "https://i.pinimg.com/474x/49/3f/a0/493fa0f13970ab3ef29375669f670451.jpg";
  static const supportEmail = 'mohamedashmawy918@gmail.com';
  static const privacyPolicyUrl = '....';
  static const ourWebsiteUrl = '....';
  static const iOSAppId = '000000';

  static const facebookPageUrl = '  ';
  static const youtubeChannelUrl = '  ';
  static const twitterUrl = '  ';

  static const List<String> languages = ['English', 'Arabic'];

  static const List<String> campaignCategories = [
    AppStrings.solidarity,
    AppStrings.health,
    AppStrings.education,
    AppStrings.development,
    AppStrings.diggingWell,
    AppStrings.algarmin,
  ];
  static const List<String> campaignIcons = [
    AppAssets.solidarity,
    AppAssets.health,
    AppAssets.education,
    AppAssets.development,
    AppAssets.diggingWell,
    AppAssets.algarmin,
  ];
}
