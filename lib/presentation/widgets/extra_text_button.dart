import 'package:flutter/material.dart';

import '../../core/constants/color_constant.dart';

class ExtraTextButton extends StatelessWidget {
  const ExtraTextButton(
      {super.key,
      required this.text,
      required this.buttonText,
      required this.onClick});
  final String text;
  final void Function() onClick;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorConstant.blueDarkColor,
              ),
        ),
        TextButton(onPressed: () => onClick(), child: Text(buttonText))
      ],
    );
  }
}
