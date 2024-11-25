import 'package:blog/config/theme/colors.dart';
import 'package:blog/core/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function callback;
  final String title;
  final double? width;
  const CustomButton({
    super.key,
    required this.callback,
    this.width,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () {
          callback();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        child: CustomText(
          text: title,
          fontSize: 16.0,
          color: AppColors.kWhite,
        ),
      ),
    );
  }
}
