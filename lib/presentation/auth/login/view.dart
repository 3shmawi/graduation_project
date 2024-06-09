import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/auth/widgets.dart';
import 'package:donation/presentation/layout/layout_view_model.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../_resources/routes_manager.dart';
import '../auth_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCtrl(),
      child: BlocConsumer<AuthCtrl, AuthStates>(
        listener: (context, state) {
          if (state is AuthLoginSuccessState) {
            context.read<LayoutVM>().changeCurrentIndex(0);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text("Logged in successfully"),
              ),
            );
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.layoutRoute, (route) => false);
          } else if (state is AuthLoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("An error occurred, please try again!"),
              ),
            );
          }
        },
        buildWhen: (_, current) =>
            current is AuthLoginLoadingState ||
            current is AuthLoginSuccessState ||
            current is AuthLoginErrorState ||
            current is ChangeSaveLoginState,
        builder: (context, state) {
          final cubit = context.read<AuthCtrl>();
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p28),
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
                              ).tr(),
                              const SizedBox(height: AppHeight.h20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppPadding.p20),
                                child: AuthFormField(
                                  controller: cubit.emailCtrl,
                                  hintTxt: AppStrings.usrEmail.tr(),
                                  prefixIcon: Icons.mail,
                                ),
                              ),
                              AuthFormField(
                                controller: cubit.passwordCtrl,
                                hintTxt: AppStrings.usrPass,
                                prefixIcon: Icons.lock,
                                isPassword: true,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: cubit.saveLoginProcess,
                                      onChanged: (state) {
                                        cubit.changeSaveLoginState();
                                      }),
                                  Text(
                                    AppStrings.rememberAuth,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ).tr(),
                                ],
                              ),
                              const SizedBox(
                                height: AppHeight.h40,
                              ),
                              CustomButton(
                                  label: AppStrings.signIn,
                                  onPressed: state is AuthLoginLoadingState
                                      ? null
                                      : () {
                                          if (cubit.isFieldAtLoginEmpty()) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    "Please fill all the fields"),
                                              ),
                                            );
                                          } else {
                                            cubit.login();
                                          }
                                        }),
                              if (state is AuthLoginLoadingState)
                                const Padding(
                                  padding: EdgeInsets.all(AppPadding.p8),
                                  child: LinearProgressIndicator(),
                                ),
                              // AuthDashLine(AppStrings.or),
                              // const AuthWithoutPassword(),
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
        },
      ),
    );
  }
}
