import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _isLoading = false;

  _openDeleteDialog() {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppStrings.accountDeleteTitle),
            content: Text(AppStrings.accountDeleteSubtitle),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleDeleteAccount();
                },
                child: Text(AppStrings.accountDeleteConfirm),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppStrings.cancel),
              ),
            ],
          );
        });
  }

  _handleDeleteAccount() async {
    // setState(() => _isLoading = true);
    // await context
    //     .read<SignInBloc>()
    //     .deleteUserDatafromDatabase()
    //     .then((_) async => await context.read<SignInBloc>().userSignout())
    //     .then((_) => context.read<SignInBloc>().afterUserSignOut())
    //     .then((_) {
    //   setState(() => _isLoading = false);
    //   Future.delayed(const Duration(seconds: 1))
    //       .then((value) => nextScreenCloseOthers(context, WelcomePage()));
    // });

    Future.delayed(const Duration(seconds: 1)).then(
      (value) => Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.onBoardingRoute,
        (route) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.security)),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              ListTile(
                title: Text(AppStrings.deleteUsrData),
                leading: const Icon(
                  Feather.trash,
                  size: AppSize.s20,
                ),
                onTap: _openDeleteDialog,
              ),
            ],
          ),
          Align(
            child: _isLoading == true
                ? const CircularProgressIndicator()
                : Container(),
          )
        ],
      ),
    );
  }
}
