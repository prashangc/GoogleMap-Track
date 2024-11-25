import 'package:blog/config/route/nav.dart';
import 'package:blog/config/route/routes.dart';
import 'package:blog/config/theme/colors.dart';
import 'package:flutter/material.dart';

class NavToMap extends StatelessWidget {
  const NavToMap({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Nav.push(route: Routes.map);
      },
      mini: true,
      backgroundColor: AppColors.kPrimary,
      shape: const CircleBorder(),
      child: Icon(
        Icons.location_on,
        color: AppColors.kWhite,
      ),
    );
  }
}
