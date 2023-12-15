import 'package:donation/presentation/_resources/logic/view_model.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';
import 'package:donation/presentation/auth/widgets.dart';

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
                  AppStrings.welcome,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: AppHeight.h14),
                Text(
                  AppStrings.welcome2,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: AppHeight.h28),
                CustomButton(
                  icon: AppAssets.google,
                  label: AppStrings.google,
                  onPressed: () {},
                  color: context.watch<AppLogicVM>().isDark
                      ? AppColors.white.withOpacity(.7)
                      : AppColors.white,
                ),
                const SizedBox(height: AppHeight.h28),
                CustomButton(
                  icon: AppAssets.facebook,
                  label: AppStrings.facebook,
                  onPressed: () {},
                ),
                const SizedBox(height: AppHeight.h28),
                CustomButton(
                  icon: AppAssets.apple,
                  label: AppStrings.apple,
                  onPressed: () {},
                  color: Colors.black,
                ),
                AuthDashLine(AppStrings.or),
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
