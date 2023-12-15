import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/auth/widgets.dart';

import '../../_resources/routes_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  TextEditingController mailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: AppHeight.h8),
                        Image.asset(
                          AppAssets.logo,
                          height: AppHeight.h200,
                        ),
                        Text(
                          AppStrings.signIn,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppHeight.h20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p20),
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
                        Row(
                          children: [
                            Checkbox(
                                value: isChecked,
                                onChanged: (state) {
                                  isChecked = state!;
                                  setState(() {});
                                }),
                            Text(
                              AppStrings.rememberAuth,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: AppHeight.h40,
                        ),
                        CustomButton(
                          label: AppStrings.signIn,
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.successRoute,
                              (route) => false,
                            );
                          },
                        ),
                        AuthDashLine(AppStrings.or),
                        const AuthWithoutPassword(),
                        const SizedBox(height: AppHeight.h12),
                        Toggle(
                          title: AppStrings.donHaveAcc,
                          bTxt: AppStrings.signUp,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(Routes.registerRoute);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
