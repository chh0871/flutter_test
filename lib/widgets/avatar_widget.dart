// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AvatarImage extends StatelessWidget {
  final String image;

  AvatarImage(
    this.image,
  );

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.blue,
      child: image == "null"
          ? Center(child: FaIcon(FontAwesomeIcons.image))
          : Align(
              alignment: Alignment.bottomCenter,
              child: ClipOval(
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) {
                    return Center(child: FaIcon(FontAwesomeIcons.image));
                  },
                  placeholder: (context, url) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  imageUrl: image,
                ),
              ),
            ),
    );
  }
}
