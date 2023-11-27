import 'package:donation/presentation/_resources/routes_manager.dart';
import 'package:donation/presentation/auth/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/global_imports.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p28),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.success),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
                child: Text(
                  AppStrings.success,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Text(
                AppStrings.successMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      height: 2,
                    ),
              ),
              const SizedBox(height: AppSize.s40),
              CustomButton(
                label: AppStrings.getStarted,
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.layoutRoute,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
