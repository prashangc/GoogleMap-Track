import 'package:blog/config/theme/colors.dart';
import 'package:blog/core/utils/share/share_helper.dart';
import 'package:blog/core/utils/snackbar/custom_snackbar.dart';
import 'package:blog/feature/home/data/model/news_model.dart';
import 'package:flutter/material.dart';

class ShareNews extends StatelessWidget {
  final Articles articles;
  const ShareNews({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (articles.url != null) {
          ShareHelper.shareLink(
            url: articles.url!,
            message: 'Check out this news article!',
          );
        } else {
          CustomSnackBar.showSnackBar(
              message: "Can't share this article", color: AppColors.kRed);
        }
      },
      mini: true,
      backgroundColor: AppColors.kPrimary,
      shape: const CircleBorder(),
      child: Icon(
        Icons.share,
        color: AppColors.kWhite,
      ),
    );
  }
}
