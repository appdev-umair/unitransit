import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/color_constant.dart';

class CustomSocialButton extends StatelessWidget {
  const CustomSocialButton(
      {super.key,
      required this.iconPath,
      required this.text,
      required this.onClick});
  final String iconPath;
  final String text;
  final void Function() onClick;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(child: Text(text, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: ColorConstant.blueDarkColor),)),
      leading: SvgPicture.asset(iconPath),
      visualDensity: const VisualDensity(vertical: -1),
      onTap: () => onClick,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(width: 1, color: ColorConstant.greyStrockColor)),
    );
  }
}
