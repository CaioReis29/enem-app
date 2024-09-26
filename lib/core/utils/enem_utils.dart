import 'package:cached_network_image/cached_network_image.dart';
import 'package:enem_app/core/extensions/navigator_extension.dart';
import 'package:enem_app/core/extensions/screen_size_extension.dart';
import 'package:enem_app/core/themes/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';


class EnemUtils {

  static List<Widget> parseContent(String context, BuildContext c) {
      final List<Widget> contentWidgets = [];
      final RegExp regex = RegExp(r"!\[.*?\]\((.*?)\)");

      final Iterable<RegExpMatch> matches = regex.allMatches(context);
      int previousEnd = 0;

      for (final match in matches) {
        if (match.start > previousEnd) {
          contentWidgets.add(Text(context.substring(previousEnd, match.start), style: AppTextStyle.poppinsW600s18));
        }

        final String? imageUrl = match.group(1);
        if (imageUrl != null) {
          if (imageUrl.endsWith('.svg')) {
            contentWidgets.add(Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () => _openZoomableImage(c, imageUrl, isSvg: true),
                child: SvgPicture.network(
                  imageUrl, height: 
                  c.getHeight() * 0.4, 
                  width: c.getWidth(),
                  fit: BoxFit.fill,
                  placeholderBuilder: (context) => const Center(child: CircularProgressIndicator()),
                ),
              ),
            ));
          } else {
            contentWidgets.add(Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () => _openZoomableImage(c, imageUrl, isSvg: false),
                child: Hero(
                  tag: imageUrl,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: c.getHeight() * 0.4,
                    width: c.getWidth(),
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
            ));
          }
        }

        previousEnd = match.end;
      }

      if (previousEnd < context.length) {
        contentWidgets.add(Text(context.substring(previousEnd), style: AppTextStyle.poppinsW400s18));
      }

      return contentWidgets;
    }

  static void _openZoomableImage(BuildContext context, String imageUrl, {bool isSvg = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text("Zoom", style: AppTextStyle.poppinsW700s20.copyWith(color: Colors.white)),
            centerTitle: true,
            leading: IconButton(onPressed: () => context.pop(), 
            icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: Center(
            child: isSvg
                ? PhotoView.customChild(
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    child: SvgPicture.network(
                      imageUrl,
                      placeholderBuilder: (context) => const Center(child: CircularProgressIndicator()),
                    ),
                  )
                : Hero(
                  tag: imageUrl,
                  child: PhotoView(
                      imageProvider: CachedNetworkImageProvider(imageUrl),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2,
                    ),
                ),
          ),
        ),
      ),
    );
  }
}
