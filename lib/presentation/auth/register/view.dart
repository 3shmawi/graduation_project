import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/_resources/component/toast.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../_resources/routes_manager.dart';
import '../auth_view_model.dart';
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
    return BlocConsumer<AuthCtrl, AuthStates>(
      listener: (context, state) {
        if (state is AuthRegisterSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Create profile successfully"),
            ),
          );
          if (state.isUser) {
            ShowToast.success("تم ارسال رسالة الى الاىميل الخاص بك");
          } else {
            ShowToast.info(
                "يتم مراجعة بيناتك من قبل الادمن الرجاء الانتظار....");
          }
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.loginRoute,
            (r) => false,
          );
        }
      },
      buildWhen: (_, current) =>
          current is AuthRegisterLoadingState ||
          current is AuthRegisterSuccessState ||
          current is AuthRegisterErrorState ||
          current is ChangeUserTypeState,
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
                        AppStrings.signUp.tr(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppHeight.h40),
                      SizedBox(
                        width: double.infinity,
                        child: SegmentedButton(
                          multiSelectionEnabled: false,
                          style: SegmentedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            textStyle: Theme.of(context).textTheme.labelLarge,
                            selectedForegroundColor: Colors.white,
                            selectedBackgroundColor: AppColors.primary,
                            foregroundColor: AppColors.black,
                            backgroundColor: Colors.grey.shade200,
                          ),
                          onSelectionChanged: (v) {
                            cubit.changeRole();
                          },
                          segments: [
                            ButtonSegment(
                              value: true,
                              label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: const Text(
                                  "User",
                                ).tr(),
                              ),
                            ),
                            ButtonSegment(
                              value: false,
                              label: const Text(
                                "Organization",
                              ).tr(),
                            ),
                          ],
                          selected: {cubit.isUser},
                        ),
                      ),
                      const SizedBox(height: AppHeight.h40),
                      AuthFormField(
                        controller: cubit.nameCtrl,
                        hintTxt: AppStrings.usrName,
                        prefixIcon: Icons.person,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p20),
                        child: AuthFormField(
                          controller: cubit.emailCtrl,
                          hintTxt: AppStrings.usrEmail,
                          prefixIcon: Icons.mail,
                        ),
                      ),
                      AuthFormField(
                        controller: cubit.passwordCtrl,
                        hintTxt: AppStrings.usrPass,
                        prefixIcon: Icons.lock,
                        isPassword: true,
                      ),
                      const SizedBox(height: AppHeight.h20),
                      AuthFormField(
                        controller: cubit.confirmPasswordCtrl,
                        hintTxt: AppStrings.confirmPass,
                        prefixIcon: Icons.password,
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: AppHeight.h40,
                      ),
                      CustomButton(
                        label: AppStrings.signUp,
                        onPressed: state is AuthRegisterLoadingState
                            ? null
                            : cubit.register,
                      ),
                      if (state is AuthRegisterLoadingState)
                        const Padding(
                          padding: EdgeInsets.all(AppPadding.p8),
                          child: LinearProgressIndicator(),
                        ),
                      // AuthDashLine(AppStrings.or),
                      // const AuthWithoutPassword(),
                      const SizedBox(height: AppHeight.h12),
                      Toggle(
                        title: AppStrings.haveAcc,
                        bTxt: AppStrings.signIn,
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.loginRoute);
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
