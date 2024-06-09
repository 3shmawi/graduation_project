import 'package:donation/presentation/_resources/component/cache_img.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../app/functions.dart';
import '../../../app/global_imports.dart';

class FieldsPage extends StatefulWidget {
  const FieldsPage({super.key});

  @override
  FieldsPageState createState() => FieldsPageState();
}

class FieldsPageState extends State<FieldsPage> {
  int calculateCrossAxisCount(BuildContext context) {
    final screenWidth = Dimensions.screenWidth(context);

    if (screenWidth > 1200) {
      return 4;
    } else if (screenWidth > 768) {
      return 3;
    } else {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(AppStrings.fields).tr()),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p14,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: calculateCrossAxisCount(context),
            mainAxisSpacing: Dimensions.heightPercentage(context, 1),
            crossAxisSpacing: Dimensions.widthPercentage(context, 1),
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return CardItem(
              icon:
                  'https://plus.unsplash.com/premium_photo-1701713781709-966e8f4c5920?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8',
              title: AppStrings.chat,
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}

class CardItem extends StatefulWidget {
  const CardItem({
    required this.icon,
    required this.title,
    this.onTap,
    super.key,
  });

  final GestureTapCallback? onTap;
  final String icon;
  final String title;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: -30, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Opacity(
        opacity: _animation.value,
        child: Transform.translate(
          offset: Offset(0, _animation2.value),
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: widget.onTap,
            child: SizedBox(
              height: w / 1.5,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomCacheImage(
                      imageUrl: widget.icon,
                      height: w / 1.1,
                      width: double.infinity,
                      radius: 25,
                    ),
                    Container(
                      height: AppHeight.h35,
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(25),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.title.tr(),
                          maxLines: 4,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
