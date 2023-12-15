import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation/app/global_imports.dart';

class CustomCacheImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final bool topRight;
  final bool topLeft;
  final bool bottomLeft;
  final bool bottomRight;
  final double height;
  final double width;

  const CustomCacheImage({
    super.key,
    required this.imageUrl,
    required this.radius,
    this.topRight = true,
    this.topLeft = true,
    this.bottomRight = true,
    this.bottomLeft = true,
    this.height = AppHeight.h35,
    this.width = AppWidth.w200,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(topRight ? radius : 0),
        topLeft: Radius.circular(topLeft ? radius : 0),
        bottomRight: Radius.circular(bottomRight ? radius : 0),
        bottomLeft: Radius.circular(bottomLeft ? radius : 0),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        height: height,
        width: width,
        placeholder: (context, url) => Container(color: Colors.grey[300]),
        errorWidget: (context, url, error) {
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.error),
          );
        },
      ),
    );
  }
}
