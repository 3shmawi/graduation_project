import 'package:donation/app/config.dart';
import 'package:donation/app/global_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguagePopup extends StatefulWidget {
  const LanguagePopup({super.key});

  @override
  LanguagePopupState createState() => LanguagePopupState();
}

class LanguagePopupState extends State<LanguagePopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.language.tr()),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppPadding.p12),
        itemCount: AppConfigs.languages.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemList(context, AppConfigs.languages[index], index);
        },
      ),
    );
  }

  Widget _itemList(BuildContext context, d, index) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(d),
          onTap: () async {
            if (d == 'English') {
              context.setLocale(const Locale('en', 'US'));
            } else if (d == 'Arabic') {
              context.setLocale(const Locale('ar', 'SA'));
            }

            Navigator.pop(context);
          },
        ),
        Divider(
          height: AppHeight.h2_5,
          color: Colors.grey[400],
        ),
      ],
    );
  }
}
