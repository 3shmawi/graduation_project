import 'package:flutter/material.dart';

import '../../../_resources/color_manager.dart';
import '../../../_resources/strings_manager.dart';
import '../../../_resources/values_manager.dart';

class NotificationWidget extends StatefulWidget {
  String notificationContent;
  NotificationWidget({required this.notificationContent});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool counter = true;

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
                          widget.notificationContent,
                          style: counter == true
                              ? Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: AppColors.gradient1)
                              : Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    color: Colors.white30,
                                  )),
                      Text(
                          '${DateTime.now().hour} :'
                          '${DateTime.now().minute}',
                          style: counter == true
                              ? Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.black)
                              : Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white30,
                                  )),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                InkWell(
                  onTap: () {
                    counter = false;
                    setState(() {});
                  },
                  child: Text(AppStrings.notification_done,
                      style: counter == true
                          ? Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: AppColors.gradient1)
                          : Theme.of(context).textTheme.displayLarge!.copyWith(
                                color: Colors.white30,
                              )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
