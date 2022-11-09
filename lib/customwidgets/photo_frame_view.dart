import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoFrameView extends StatelessWidget {
  final Widget child;
  final String url;
  final VoidCallback onImagePresed;
  const PhotoFrameView(
      {Key? key,
      required this.child,
      required this.url,
      required this.onImagePresed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.5),
      ),
      child: url.isEmpty ? child : InkWell(
              onTap: onImagePresed,
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
    );
  }
}
