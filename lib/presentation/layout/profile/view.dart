import 'package:donation/app/config.dart';
import 'package:donation/controller/theme.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';
import 'package:donation/presentation/layout/profile/language.dart';
import 'package:donation/presentation/layout/profile/view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_icons/line_icons.dart';

import '../../../app/global_imports.dart';
import '../../../app/services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  openAboutDialog() {
    final appVersion = context.read<SettingVM>().appVersion;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AboutDialog(
          applicationName: AppConfigs.appName,
          applicationIcon: const Image(
            image: AssetImage(
              AppAssets.splash,
            ),
            height: AppHeight.h30,
            width: AppWidth.w30,
          ),
          applicationVersion: appVersion,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(AppStrings.profile).tr(),
      ),
      body: SafeArea(
        child: AnimationLimiter(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppPadding.p14,
              AppPadding.p4,
              AppPadding.p20,
              AppPadding.p16,
            ),
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(
                milliseconds: AppConstants.durationAnimationDelay5,
              ),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: AppSize.s50,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                false ? const GuestUserUI() : const UserUI(),
                Text(
                  AppStrings.generalSettings.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: AppHeight.h14,
                ),
                Item(
                  label: AppStrings.bookmarks,
                  icon: Feather.bookmark,
                  color: Colors.blueGrey,
                  onTap: () {},
                ),
                const Divider(
                  height: AppHeight.h4,
                ),
                ListTile(
                  title: Text(
                    AppStrings.darkMode.tr(),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  leading: Container(
                    height: AppHeight.h30,
                    width: AppWidth.w30,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(AppSize.s4),
                    ),
                    child: Icon(
                      LineIcons.sun,
                      size: AppSize.s20,
                      color: AppColors.white,
                    ),
                  ),
                  trailing: Switch.adaptive(
                    activeColor: Theme.of(context).primaryColor,
                    value: context.watch<ThemeCtrl>().state,
                    onChanged: (bool b) =>
                        context.read<ThemeCtrl>().changeTheme(),
                  ),
                ),
                const Divider(
                  height: AppHeight.h4,
                ),
                ListTile(
                  title: Text(
                    AppStrings.getNotification.tr(),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  leading: Container(
                    height: AppHeight.h30,
                    width: AppWidth.w30,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(AppSize.s4),
                    ),
                    child: Icon(
                      LineIcons.bell,
                      size: AppSize.s20,
                      color: AppColors.white,
                    ),
                  ),
                  trailing: Switch.adaptive(
                      activeColor: Theme.of(context).primaryColor,
                      value: true,
                      onChanged: (bool newValue) {}),
                ),
                const Divider(
                  height: AppHeight.h2_5,
                ),
                Item(
                  label: AppStrings.language,
                  icon: Feather.globe,
                  color: Colors.pinkAccent,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LanguagePopup(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: AppHeight.h4,
                ),
                Item(
                  label: AppStrings.contactUs,
                  icon: Feather.mail,
                  onTap: () {},
                  color: Colors.blueAccent,
                ),
                const Divider(
                  height: AppHeight.h4,
                ),
                Item(
                  label: AppStrings.rateApp,
                  icon: Feather.star,
                  color: Colors.orangeAccent,
                  onTap: () async => AppService.launchAppReview(context),
                ),
                const Divider(
                  height: AppHeight.h4,
                ),
                Item(
                  label: AppStrings.licence,
                  icon: Feather.paperclip,
                  color: Colors.purpleAccent,
                  onTap: () => openAboutDialog(),
                ),
                const Divider(
                  height: AppHeight.h4,
                ),
                Item(
                  label: AppStrings.privacy,
                  icon: Feather.lock,
                  onTap: () async => AppService.openLink(
                    context,
                    AppConfigs.privacyPolicyUrl,
                  ),
                ),
                const Divider(
                  height: AppHeight.h4,
                ),
                Item(
                  label: AppStrings.aboutUs,
                  icon: Feather.info,
                  color: Colors.green,
                  onTap: () async => AppService.openLink(
                    context,
                    AppConfigs.ourWebsiteUrl,
                  ),
                ),
                false ? Container() : const SecurityOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecurityOption extends StatelessWidget {
  const SecurityOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: AppHeight.h4,
        ),
        Item(
          label: AppStrings.security,
          icon: Feather.lock,
          onTap: () => Navigator.of(context).pushNamed(Routes.securityRoute),
          color: Colors.red,
        ),
      ],
    );
  }
}

class GuestUserUI extends StatelessWidget {
  const GuestUserUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Item(
          label: AppStrings.login,
          icon: Feather.user,
          onTap: () {},
          color: Colors.blueAccent,
        ),
        const SizedBox(
          height: AppHeight.h20,
        ),
      ],
    );
  }
}

class UserUI extends StatelessWidget {
  const UserUI({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(
            milliseconds: AppConstants.durationAnimationDelay5,
          ),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: AppSize.s50,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [
            SizedBox(
              height: AppHeight.h200,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: AppSize.s60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: const AssetImage(AppAssets.logo2),
                  ),
                  const SizedBox(
                    height: AppHeight.h16,
                  ),
                  Text(
                    'Mohamed Ashmawi',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
            ),
            Item(
              label: 'mohamedashmawy918@gmail.com',
              icon: Feather.mail,
              color: Colors.blueAccent,
              onTap: () {},
            ),
            const Divider(
              height: AppHeight.h4,
            ),
            Item(
              label: AppStrings.editProfile,
              icon: Feather.edit_3,
              color: Colors.purpleAccent,
              onTap: () {},
            ),
            const Divider(
              height: AppHeight.h4,
            ),
            Item(
              label: AppStrings.logout,
              icon: Feather.log_out,
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.loginRoute, (route) => false);
              },
            ),
            const SizedBox(
              height: AppHeight.h16,
            )
          ],
        ),
      ),
    );
  }

  void openLogoutDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppStrings.logoutTitle.tr()),
          actions: [
            TextButton(
              child: Text(AppStrings.no.tr()),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(AppStrings.yes.tr()),
              onPressed: () async {
                // await context
                //     .read<SignInBloc>()
                //     .userSignout()
                //     .then((value) =>
                //         context.read<SignInBloc>().afterUserSignOut())
                //     .then((value) {
                //   Navigator.pop(context);
                //   if (context.read<ThemeBloc>().darkTheme == true) {
                //     context.read<ThemeBloc>().toggleTheme();
                //   }
                //   nextScreenCloseOthers(context, WelcomePage());
                // });
              },
            )
          ],
        );
      },
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    required this.label,
    required this.icon,
    this.color = Colors.redAccent,
    this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final GestureTapCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label.tr(),
        style: Theme.of(context).textTheme.displayMedium,
      ),
      leading: Container(
        height: AppHeight.h30,
        width: AppWidth.w30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            AppSize.s4,
          ),
        ),
        child: Icon(
          icon,
          size: AppSize.s20,
          color: AppColors.white,
        ),
      ),
      trailing: Icon(
        context.locale.countryCode == "US"
            ? Entypo.chevron_right
            : Feather.chevron_left,
        size: AppSize.s20,
      ),
      onTap: onTap,
    );
  }
}
