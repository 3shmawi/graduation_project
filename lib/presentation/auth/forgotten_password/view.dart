
import 'package:donation/app/global_imports.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../_resources/strings_manager.dart';
import '../../_resources/values_manager.dart';
import '../widgets.dart';

class ForgottenPasswordPage extends StatefulWidget {
  const ForgottenPasswordPage({super.key});

  @override
  _ForgottenPasswordPageState createState() => _ForgottenPasswordPageState();
}

class _ForgottenPasswordPageState extends State<ForgottenPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  late bool _isLoading = false;
  final TextEditingController emailController = TextEditingController();

  Future<void> resetPassword() async {
    final String email = emailController.text;
    const url = 'https://social-api-trlr.onrender.com';

    try {
      final response = await http.post(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        print('sucess');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Password reset email sent to $email.'),
              actions: [
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
         print('Failed to reset password');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to reset password.'),
              actions: [
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred. Please try again later.'),
            actions: [
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    //final cubit = context.read<AuthCtrl>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children:[
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p20),
                child: AuthFormField(
                  controller: _emailController,
                  hintTxt: AppStrings.usrEmail.tr(),
                  prefixIcon: Icons.mail,
                ),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: resetPassword,
                      child: Text('Reset Password' ,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
// //https://social-api-trlr.onrender.com
