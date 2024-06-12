import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';

import 'notification_widget.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(AppMargin.m12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.notification,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.searchRoute);
                  },
                  icon: const Icon(Icons.search),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return NotificationWidget(
                    notificationContent:
                        'your last story had 16 viewers . share a new story with friends',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
