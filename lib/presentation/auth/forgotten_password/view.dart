import 'package:donation/app/global_imports.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

import '../widgets.dart';

class ForgottenPasswordPage extends StatefulWidget {
  const ForgottenPasswordPage({super.key});

  @override
  ForgottenPasswordPageState createState() => ForgottenPasswordPageState();
}

class ForgottenPasswordPageState extends State<ForgottenPasswordPage> {
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
        print('success');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: Text('Password reset email sent to $email.'),
              actions: [
                ElevatedButton(
                  child: const Text('OK'),
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
              title: const Text('Error'),
              content: const Text('Failed to reset password.'),
              actions: [
                ElevatedButton(
                  child: const Text('OK'),
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
            title: const Text('Error'),
            content: const Text('An error occurred. Please try again later.'),
            actions: [
              ElevatedButton(
                child: const Text('OK'),
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
        title: const Text('Forgot Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
                child: AuthFormField(
                  controller: _emailController,
                  hintTxt: AppStrings.usrEmail.tr(),
                  prefixIcon: Icons.mail,
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: resetPassword,
                      child: Text(
                        'Reset Password',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
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
