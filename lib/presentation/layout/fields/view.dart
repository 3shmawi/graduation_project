import 'package:donation/presentation/_resources/component/cache_img.dart';

import '../../../app/functions.dart';
import '../../../app/global_imports.dart';

class FieldsPage extends StatefulWidget {
  const FieldsPage({super.key});

  @override
  FieldsPageState createState() => FieldsPageState();
}

class FieldsPageState extends State<FieldsPage>
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
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(
              AppSize.s8,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.black,
        elevation: 0,
        shadowColor: Colors.white10,
        title: Text(
          AppStrings.fields,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        centerTitle: false,
      ),
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
              animation2: _animation2,
              animation: _animation,
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

class CardItem extends StatelessWidget {
  const CardItem({
    required this.animation,
    required this.animation2,
    required this.icon,
    required this.title,
    this.onTap,
    super.key,
  });

  final Animation<double> animation;
  final Animation<double> animation2;
  final GestureTapCallback? onTap;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Opacity(
        opacity: animation.value,
        child: Transform.translate(
          offset: Offset(0, animation2.value),
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: onTap,
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
                      imageUrl: icon,
                      height: w / 1.1,
                      width: double.infinity,
                      radius: 25,
                    ),
                    Container(
                      height: AppSize.s35,
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(25),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          title,
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
