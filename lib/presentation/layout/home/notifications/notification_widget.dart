import 'package:flutter/material.dart';

import '../../../_resources/color_manager.dart';
import '../../../_resources/routes_manager.dart';
import '../../../_resources/strings_manager.dart';
import '../../../_resources/values_manager.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppPadding.p10),
            margin: const EdgeInsets.only(
                right: AppMargin.m10, left: AppMargin.m10, top: AppMargin.m10),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s12),
                color: Colors.grey),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 10,
                  decoration: BoxDecoration(
                      color: AppColors.gradient1,
                      borderRadius: BorderRadius.circular(AppSize.s8)),
                ),
                const Spacer(
                  flex: 1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //notofications content!
                        'your last story had 16 viewers . share a new story with friends',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: AppColors.gradient1),
                      ),
                      Text(
                        '${DateTime.now().hour} :'
                        '${DateTime.now().minute}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.black),
                      ),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(AppStrings.notification_done,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColors.gradient1)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
