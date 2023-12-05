import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation/app/global_imports.dart';

class CustomCacheImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final bool? circularShape;
  final double height;
  final double width;

  const CustomCacheImage({
    super.key,
    required this.imageUrl,
    required this.radius,
    this.circularShape,
    this.height = AppSize.s35,
    this.width = AppSize.s200,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(circularShape == false ? 0 : radius),
        bottom: Radius.circular(radius),
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
