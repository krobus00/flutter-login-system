import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:latihan_request/views/mobile/regis_mobile.dart';
class RegisView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: RegisMobile(),
      // desktop: LoginDesktop(),
    );
  }
}