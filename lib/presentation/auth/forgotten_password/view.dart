import 'package:donation/presentation/auth/forgotten_password/view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../_resources/strings_manager.dart';
import '../widgets.dart';

class ForgottenPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Password reset email sent.'),
              duration: Duration(seconds: 2),
            ));
          } else if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 2),
              content: Text('Password reset email failed!.'),
            ));
          }
        },
        builder: (context, state) {
          final cubit = context.read<ForgotPasswordCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text('Forgot Password'),
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AuthFormField(
                      controller: cubit.emailCtrl,
                      hintTxt: AppStrings.usrEmail.tr(),
                      prefixIcon: Icons.mail,
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<ForgotPasswordCubit>(context)
                            .requestPasswordReset(emailController.text);
                      },
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (state is ForgotPasswordLoading)
                      const CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
