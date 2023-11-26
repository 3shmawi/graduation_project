import 'package:flutter_svg/flutter_svg.dart';

import '../../app/global_imports.dart';
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
    super.key,
  });

  final TextEditingController controller;
  final String hintTxt;
  final bool isPassword;
  final TextInputType textInputType;
  final IconData prefixIcon;

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
    return Container(
      height: width / 8,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: width / 30),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        border: Border.all(color: AppColors.black, width: AppSize.s1_5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
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
            hintText: widget.hintTxt,
            hintStyle: Theme.of(context).textTheme.labelSmall),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
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
        minimumSize: const Size(AppSize.s327, AppSize.s48),
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
              padding: const EdgeInsets.fromLTRB(
                  AppPadding.p20, 0, AppPadding.p8, 0),
              child: SvgPicture.asset(icon!),
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
            string,
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
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.successRoute,
                (route) => false,
              );
            },
          ),
          const SizedBox(width: AppSize.s12),
          AuthOutLinedButton(
            icon: AppAssets.facebook,
            isBlue: true,
            padding: AppPadding.p18,
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.successRoute,
                (route) => false,
              );
            },
          ),
          const SizedBox(width: AppSize.s12),
          AuthOutLinedButton(
            icon: AppAssets.apple,
            isBlue: false,
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.successRoute,
                (route) => false,
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
    this.isBlue,
    this.padding,
    super.key,
  });

  final String icon;
  final GestureTapCallback? onTap;
  final bool? isBlue;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: Container(
          height: AppSize.s48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8),
            border: Border.all(
              color: Colors.grey.withOpacity(.5),
              width: AppSize.s1_5,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              colorFilter: isBlue == null
                  ? null
                  : ColorFilter.mode(
                      isBlue! ? AppColors.primary : AppColors.black,
                      BlendMode.srcIn,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
