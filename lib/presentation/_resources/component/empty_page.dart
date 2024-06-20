import 'package:donation/app/global_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class EmptyPage extends StatelessWidget {
  final IconData icon;
  final String message;
  final String message1;
  final VoidCallback? onPressed;

  const EmptyPage({
    super.key,
    required this.icon,
    required this.message,
    required this.message1,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppSize.s100,
              color: AppColors.grey,
            ),
            const SizedBox(
              height: AppHeight.h20,
            ),
            Text(
              message.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            OutlinedButton(
              onPressed: onPressed,
              child: Text(
                message1.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: AppColors.primary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
