import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/global_imports.dart';
import '../../controller/theme.dart';
import '../_resources/routes_manager.dart';

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class AuthFormField extends StatefulWidget {
  const AuthFormField({
    required this.controller,
    required this.hintTxt,
    required this.prefixIcon,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    this.focusNode,
    this.onTap,
    super.key,
  });

  final TextEditingController controller;
  final String hintTxt;
  final bool isPassword;
  final TextInputType textInputType;
  final IconData prefixIcon;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;

  @override
  State<AuthFormField> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  bool isPass = true;

  @override
  void initState() {
    super.initState();
    isPass = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    final isDark = context.watch<ThemeCtrl>().state;
    return Container(
      height: width / 8,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: width / 30),
      decoration: BoxDecoration(
        color: isDark ? null : AppColors.lightGrey,
        border: Border.all(
            color: isDark ? AppColors.primary : AppColors.black,
            width: AppWidth.w1_5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        controller: widget.controller,
        obscureText: isPass,
        style: Theme.of(context).textTheme.titleMedium,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.prefixIcon,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(
                      () {
                        isPass = !isPass;
                      },
                    );
                  },
                  icon: Icon(
                    isPass ? Icons.visibility : Icons.visibility_off_outlined,
                  ),
                )
              : null,
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: widget.hintTxt.tr(),
          hintStyle: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.label,
    this.onPressed,
    this.icon,
    this.color,
    super.key,
  });

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
        minimumSize: const Size(
          AppWidth.w327,
          AppHeight.h48,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s12,
          ),
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
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p20,
                0,
                AppPadding.p8,
                0,
              ),
              child: SvgPicture.asset(icon!),
            ),
          Text(
            label.tr(),
            style: color == Colors.white
                ? Theme.of(context).textTheme.displayMedium
                : Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}

class AuthDashLine extends StatelessWidget {
  const AuthDashLine(this.string, {super.key});

  final String string;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p28),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Text(
            string.tr(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}

class AuthWithoutPassword extends StatefulWidget {
  const AuthWithoutPassword({super.key});

  @override
  State<AuthWithoutPassword> createState() => _AuthWithoutPasswordState();
}

class _AuthWithoutPasswordState extends State<AuthWithoutPassword> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCtrl>().state;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p12,
        AppPadding.p0,
        AppPadding.p12,
        AppPadding.p12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthOutLinedButton(
            icon: AppAssets.google,
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.successRoute,
              );
            },
          ),
          const SizedBox(width: AppWidth.w12),
          AuthOutLinedButton(
            icon: AppAssets.facebook,
            color: AppColors.primary,
            padding: AppPadding.p18,
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.successRoute,
              );
            },
          ),
          const SizedBox(width: AppWidth.w12),
          AuthOutLinedButton(
            icon: AppAssets.apple,
            color: theme ? AppColors.white : AppColors.black,
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.successRoute,
              );
            },
          ),
        ],
      ),
    );
  }
}

class AuthOutLinedButton extends StatelessWidget {
  const AuthOutLinedButton({
    required this.icon,
    this.onTap,
    this.color,
    this.padding,
    super.key,
  });

  final String icon;
  final GestureTapCallback? onTap;
  final Color? color;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: Container(
          height: AppHeight.h48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8),
            border: Border.all(
              color: Colors.grey.withOpacity(.5),
              width: AppWidth.w1_5,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              colorFilter: color == null
                  ? null
                  : ColorFilter.mode(
                      color!,
                      BlendMode.srcIn,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class Toggle extends StatelessWidget {
  const Toggle({
    required this.title,
    required this.bTxt,
    this.onPressed,
    super.key,
  });

  final String title;
  final String bTxt;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title.tr(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppSize.s8,
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            bTxt.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}

class CenteredItemScrollView extends StatelessWidget {
  final Widget child;

  const CenteredItemScrollView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: child,
          ),
        ),
      ],
    );
  }
}
