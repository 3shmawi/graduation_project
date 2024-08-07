import 'package:flutter_svg/svg.dart';

import '../../../app/global_imports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.label,
    this.onPressed,
    this.isPadding = true,
    this.icon,
    this.color,
    super.key,
  });

  final bool isPadding;
  final String? icon;
  final String label;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor:
            color == AppColors.white ? AppColors.black : AppColors.white,
        elevation: 2,
        minimumSize: const Size(AppWidth.w327, AppHeight.h48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        backgroundColor: color ?? AppColors.primary,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment:
            icon == null ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          if (icon != null)
            Padding(
              padding: isPadding
                  ? const EdgeInsets.fromLTRB(
                      AppPadding.p20, 0, AppPadding.p8, 0)
                  : EdgeInsets.zero,
              child: SvgPicture.asset(
                icon!,
              ),
            ),
          Text(
            label,
            style: color == Colors.white
                ? Theme.of(context).textTheme.displayMedium
                : Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
