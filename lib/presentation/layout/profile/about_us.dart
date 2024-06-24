
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../_resources/routes_manager.dart';
import '../../_resources/strings_manager.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Our Mission",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "our_mission1".tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                "our_vision".tr() ,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "our_vision1".tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                'our_values'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "our_values1".tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                "achievements".tr(),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),

              ),
              SizedBox(height: 10),
              Text(
                '${'achievements1'.tr()}\n'
                    '${'achievements2'.tr()}\n'
                    '${'achievements3'.tr()}.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(
                    Routes.contactUs,
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all( color : Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    AppStrings.contactUs,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }
}
