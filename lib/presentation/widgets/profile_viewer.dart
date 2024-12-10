import 'dart:io';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileViewer extends StatelessWidget {
  const ProfileViewer({
    super.key,
    this.fileImage,
    this.networkImageUrl,
    this.placeholder = 'assets/images/default_profile.png',
    this.radius = 100,
    this.onTap,
  });

  final File? fileImage;
  final String? networkImageUrl;
  final String placeholder;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey[200],
          child: fileImage != null
              ? Image.file(
                  fileImage!,
                  fit: BoxFit.cover,
                )
              : networkImageUrl != null
                  ? FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(networkImageUrl!),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      placeholder,
                      fit: BoxFit.cover,
                    ),
        ),
      ),
    );
  }
}
