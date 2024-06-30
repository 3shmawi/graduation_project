import 'package:donation/app/config.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';
import 'package:donation/presentation/layout/profile/language.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../app/global_imports.dart';
import '../../../../app/services.dart';
import '../../profile/view_model.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List titles = [
      AppStrings.bookmarks,
      AppStrings.language,
      AppStrings.aboutUs,
      AppStrings.privacy,
      AppStrings.contactUs,
      AppStrings.facebookPage,
      AppStrings.youtube,
      AppStrings.twitter,
    ];

    final List icons = [
      Feather.bookmark,
      Feather.globe,
      Feather.info,
      Feather.lock,
      Feather.mail,
      Feather.facebook,
      Feather.youtube,
      Feather.twitter
    ];

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.logo2,
                      height: AppHeight.h100,
                    ),
                    BlocBuilder<SettingVM, AppCubitStates>(
                      builder: (context, state) {
                        return Text(
                          'Version: ${context.read<SettingVM>().appVersion}',
                          style: Theme.of(context).textTheme.labelLarge,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: AppPadding.p28),
              itemCount: titles.length,
              shrinkWrap: true,
              separatorBuilder: (ctx, idx) => const Divider(
                height: AppHeight.h0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    titles[index],
                    style: Theme.of(context).textTheme.titleMedium,
                  ).tr(),
                  leading: CircleAvatar(
                    radius: AppSize.s20,
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    child: Icon(
                      icons[index],
                      color: Colors.grey[600],
                    ),
                  ),
                  onTap: () async {
                    // Navigator.of(context).pop();
                    if (index == 0) {
                      Navigator.of(context).pushNamed(Routes.bookmark);
                    } else if (index == 1) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LanguagePopup(),
                        ),
                      );
                    } else if (index == 2) {
                      AppService.openLink(context, AppConfigs.ourWebsiteUrl);
                    } else if (index == 3) {
                      AppService.openLink(context, AppConfigs.privacyPolicyUrl);
                    } else if (index == 4) {
                      AppService.openEmailSupport(context);
                    } else if (index == 5) {
                      AppService.openLink(context, AppConfigs.facebookPageUrl);
                    } else if (index == 6) {
                      AppService.openLink(
                          context, AppConfigs.youtubeChannelUrl);
                    } else if (index == 7) {
                      AppService.openLink(context, AppConfigs.twitterUrl);
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
