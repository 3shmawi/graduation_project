import 'package:donation/app/global_imports.dart';
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
    return BlocProvider(
      create: (context) => AuthCtrl(),
      child: BlocConsumer<AuthCtrl, AuthStates>(
        listener: (context, state) {
          if (state is AuthRegisterSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text("Create profile successfully"),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text("An email sent to you, please verify your email"),
              ),
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.loginRoute,
              (r) => false,
            );
          } else if (state is AuthRegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text("Create profile failed,please try again"),
              ),
            );
          }
        },
        buildWhen: (_, current) =>
            current is AuthRegisterLoadingState ||
            current is AuthRegisterSuccessState ||
            current is AuthRegisterErrorState,
        builder: (context, state) {
          final cubit = context.read<AuthCtrl>();
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
                          const SizedBox(height: AppHeight.h8),
                          Image.asset(
                            AppAssets.logo,
                            height: AppHeight.h200,
                          ),
                          Text(
                            AppStrings.signUp.tr(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: AppHeight.h20),
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
                            hintTxt: AppStrings.confirmUsrPass,
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
                                : () {
                                    if (cubit.isFieldAtRegisterEmpty()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              "Please fill all the fields"),
                                        ),
                                      );
                                    } else {
                                      cubit.register();
                                    }
                                  },
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
                              Navigator.of(context)
                                  .pushNamed(Routes.loginRoute);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
