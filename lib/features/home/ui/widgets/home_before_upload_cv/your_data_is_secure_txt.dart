import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/helper/spacing.dart';

class YourDataIsSecureTxt extends StatelessWidget {
  const YourDataIsSecureTxt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppSvgs.securityIcon),
        horizantalSpace(15),
        Expanded(
          child: Text(
            'Your data is secure and will only beused to improve your experience.',
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
