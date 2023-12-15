import 'package:flutter_icons/flutter_icons.dart';

import '../../../../app/global_imports.dart';
import '../../profile/view_model.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final appVersion = context.read<SettingVM>().appVersion;
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
                    Text(
                      'Version: $appVersion',
                      style: Theme.of(context).textTheme.labelLarge,
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
                  ),
                  leading: CircleAvatar(
                      radius: AppSize.s20,
                      backgroundColor: Theme.of(context).secondaryHeaderColor,
                      child: Icon(
                        icons[index],
                        color: Colors.grey[600],
                      )),
                  onTap: () async {
                    Navigator.pop(context);
                    if (index == 0) {
                      // nextScreen(context, BookmarkPage());
                    } else if (index == 1) {
                      // nextScreenPopup(context, const LanguagePopup());
                    } else if (index == 2) {
                      // AppService().openLinkWithCustomTab(
                      //     context, Config().ourWebsiteUrl);
                    } else if (index == 3) {
                      // AppService().openLinkWithCustomTab(
                      //     context, Config().privacyPolicyUrl);
                    } else if (index == 4) {
                      // AppService().openEmailSupport(context);
                    } else if (index == 5) {
                      // AppService().openLink(context, Config.facebookPageUrl);
                    } else if (index == 6) {
                      // AppService()
                      //     .openLink(context, Config.youtubeChannelUrl);
                    } else if (index == 7) {
                      // AppService().openLink(context, Config.twitterUrl);
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
