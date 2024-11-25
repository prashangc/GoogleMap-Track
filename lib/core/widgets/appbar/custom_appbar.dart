import 'package:blog/config/theme/colors.dart';
import 'package:blog/core/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: AppColors.kWhite),
      backgroundColor: AppColors.kPrimary,
      centerTitle: true,
      title: CustomText(
        text: title,
        color: AppColors.kWhite,
        fontSize: 18.0,
        isBold: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
