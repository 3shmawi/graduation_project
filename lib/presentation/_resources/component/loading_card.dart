import 'package:donation/controller/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingCard extends StatelessWidget {
  final double? height;
  const LoadingCard({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SkeletonAnimation(
        child: Container(
          decoration: BoxDecoration(
              color: context.read<ThemeCtrl>().state
                  ? Colors.black38
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(15)),
          height: height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
