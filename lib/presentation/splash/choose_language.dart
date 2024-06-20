import 'package:donation/app/global_imports.dart';
import 'package:easy_localization/easy_localization.dart';

import '../_resources/component/button.dart';
import '../_resources/routes_manager.dart';

class ChooseLanguagePage extends StatefulWidget {
  const ChooseLanguagePage({super.key});

  @override
  State<ChooseLanguagePage> createState() => _ChooseLanguagePageState();
}

class _ChooseLanguagePageState extends State<ChooseLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر اللغة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          AppPadding.p20,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose the language',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: AppHeight.h20),
              const Divider(
                height: AppHeight.h20,
              ),
              const SizedBox(height: AppHeight.h20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      label: 'العربية',
                      onPressed: () {
                        context
                            .setLocale(const Locale('ar', 'SA'))
                            .then((value) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.onBoardingRoute, (route) => false);
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: AppWidth.w20,
                  ),
                  Expanded(
                    child: CustomButton(
                      label: 'English',
                      onPressed: () {
                        context
                            .setLocale(const Locale('en', 'US'))
                            .then((value) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.onBoardingRoute, (route) => false);
                        });
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
