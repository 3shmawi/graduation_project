import 'package:donation/controller/theme.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';
import 'package:donation/presentation/auth/widgets.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../app/global_imports.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: AppPadding.p28),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.logo,
                  height: AppHeight.h200,
                ),
                const SizedBox(height: AppHeight.h8),
                Text(
                  AppStrings.welcome.tr(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: AppHeight.h14),
                Text(
                  AppStrings.welcome2.tr(),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: AppHeight.h28),
                CustomButton(
                  icon: AppAssets.google,
                  label: AppStrings.google,
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.successRoute, (route) => false);
                  },
                  color: context.watch<ThemeCtrl>().state
                      ? AppColors.white.withOpacity(.7)
                      : AppColors.white,
                ),
                const SizedBox(height: AppHeight.h28),
                CustomButton(
                  icon: AppAssets.facebook,
                  label: AppStrings.facebook,
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.successRoute, (route) => false);
                  },
                ),
                const SizedBox(height: AppHeight.h28),
                CustomButton(
                  icon: AppAssets.apple,
                  label: AppStrings.apple,
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.successRoute, (route) => false);
                  },
                  color: Colors.black,
                ),
                const AuthDashLine(AppStrings.or),
                CustomButton(
                  label: AppStrings.withPass,
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.loginRoute);
                  },
                ),
                const SizedBox(height: AppHeight.h8),
                Toggle(
                  title: AppStrings.donHaveAcc,
                  bTxt: AppStrings.signUp,
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.registerRoute);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
