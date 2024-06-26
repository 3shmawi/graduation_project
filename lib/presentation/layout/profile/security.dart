import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';
import 'package:donation/presentation/auth/auth_view_model.dart';
import 'package:donation/presentation/layout/home/view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  _openDeleteDialog(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              AppStrings.accountDeleteTitle.tr(),
              style: theme.bodyLarge!.copyWith(
                color: AppColors.primary,
              ),
            ),
            content: Text(AppStrings.accountDeleteSubtitle.tr(),
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grey,
                )),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<HomeCtrl>().postBox.clear();
                  context.read<AuthCtrl>().deleteProfile();
                },
                child: Text(
                  AppStrings.accountDeleteConfirm.tr(),
                  style: theme.bodyMedium!.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppStrings.cancel.tr(),
                  style: theme.bodyMedium!.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          AppStrings.security.tr(),
        ),
      ),
      body: BlocConsumer<AuthCtrl, AuthStates>(
        buildWhen: (_, current) =>
            current is DeleteProfileLoading || current is DeleteProfileSuccess,
        listenWhen: (_, current) => current is DeleteProfileSuccess,
        listener: (context, state) {
          if (state is DeleteProfileSuccess) {
            Future.delayed(const Duration(seconds: 1)).then(
              (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.onBoardingRoute,
                (route) => false,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  ListTile(
                    title: Text(
                      AppStrings.deleteUsrData.tr(),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: AppColors.error,
                          ),
                    ),
                    leading: Icon(
                      Feather.trash,
                      size: AppSize.s20,
                      color: AppColors.error,
                    ),
                    onTap: () => _openDeleteDialog(context),
                  ),
                ],
              ),
              if (state is DeleteProfileLoading)
                const Center(child: CircularProgressIndicator())
            ],
          );
        },
      ),
    );
  }
}
