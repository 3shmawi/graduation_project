import 'package:donation/presentation/auth/auth_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../_resources/strings_manager.dart';
import '../widgets.dart';

class ForgottenPasswordPage extends StatelessWidget {
  const ForgottenPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCtrl, AuthStates>(
      builder: (context, state) {
        final cubit = context.read<AuthCtrl>();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(AppStrings.forgotPass.tr()),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AuthFormField(
                    controller: cubit.emailCtrl,
                    hintTxt: AppStrings.usrEmail.tr(),
                    prefixIcon: Icons.mail,
                  ),
                  const SizedBox(height: 50.0),
                  ElevatedButton(
                    onPressed: () {
                      cubit.requestPasswordReset();
                    },
                    child: Text(
                      'Reset Password',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.white,
                          ),
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
    );
  }
}
