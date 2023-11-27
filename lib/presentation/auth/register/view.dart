import 'package:donation/app/global_imports.dart';

import '../../_resources/routes_manager.dart';
import '../widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController mailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: AppSize.s8),
                    Image.asset(
                      AppAssets.logo,
                      height: AppSize.s200,
                    ),
                    Text(
                      AppStrings.signUp,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSize.s20),
                    AuthFormField(
                      controller: nameCtrl,
                      hintTxt: AppStrings.usrName,
                      prefixIcon: Icons.person,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppPadding.p20),
                      child: AuthFormField(
                        controller: mailCtrl,
                        hintTxt: AppStrings.usrEmail,
                        prefixIcon: Icons.mail,
                      ),
                    ),
                    AuthFormField(
                      controller: passCtrl,
                      hintTxt: AppStrings.usrPass,
                      prefixIcon: Icons.lock,
                      isPassword: true,
                    ),
                    const SizedBox(
                      height: AppSize.s40,
                    ),
                    CustomButton(
                      label: AppStrings.signUp,
                      onPressed: () {
                        nameCtrl.clear();
                        mailCtrl.clear();
                        passCtrl.clear();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.loginRoute, (route) => false);
                      },
                    ),
                    AuthDashLine(AppStrings.or),
                    const AuthWithoutPassword(),
                    const SizedBox(height: AppSize.s12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.haveAcc,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.loginRoute);
                          },
                          child: Text(
                            AppStrings.signIn,
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
          ),
        ),
      ),
    );
  }
}
