import 'package:donation/app/global_imports.dart';
import 'package:donation/controller/notification.dart';
import 'package:donation/presentation/auth/widgets.dart';
import 'package:donation/presentation/layout/layout_view_model.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../_resources/routes_manager.dart';
import '../auth_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCtrl, AuthStates>(
      listener: (context, state) {
        if (state is AuthLoginSuccessState) {
          context.read<LayoutVM>().changeCurrentIndex(0, false);
          context
              .read<NotificationCtrl>()
              .changeNotification(true, AuthCtrl.usrId!);

          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.successRoute, (route) => false);
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
          body: CenteredItemScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: cubit.saveLoginProcess,
                                  onChanged: (state) {
                                    cubit.changeSaveLoginState();
                                  }),
                              Text(
                                AppStrings.rememberAuth,
                                style: Theme.of(context).textTheme.labelSmall,
                              ).tr(),
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.forgotPasswordRoute);
                              },
                              child: Text(
                                AppStrings.forgotPass.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: Colors.black),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: AppHeight.h40,
                      ),
                      CustomButton(
                        label: AppStrings.signIn,
                        onPressed:
                            state is AuthLoginLoadingState ? null : cubit.login,
                      ),
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
                          Navigator.of(context).pushNamed(Routes.registerRoute);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
