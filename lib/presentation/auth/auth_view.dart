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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.logo,
                height: AppSize.s200,
              ),
              const SizedBox(height: AppSize.s8),
              Text(
                AppStrings.welcome,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: AppSize.s14),
              Text(
                AppStrings.welcome2,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: AppSize.s28),
              AuthButton(
                icon: AppAssets.google,
                label: AppStrings.google,
                onPressed: () {},
                color: AppColors.white,
              ),
              const SizedBox(height: AppSize.s28),
              AuthButton(
                icon: AppAssets.facebook,
                label: AppStrings.facebook,
                onPressed: () {},
              ),
              const SizedBox(height: AppSize.s28),
              AuthButton(
                icon: AppAssets.apple,
                label: AppStrings.apple,
                onPressed: () {},
                color: Colors.black,
              ),
              AuthDashLine(AppStrings.or),
              AuthButton(
                label: AppStrings.withPass,
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.loginRoute);
                },
              ),
              const SizedBox(height: AppSize.s8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.donHaveAcc,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.registerRoute);
                    },
                    child: Text(
                      AppStrings.signUp,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: FontSize.s18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
