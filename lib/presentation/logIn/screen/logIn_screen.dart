import 'package:flutter/cupertino.dart';

import '../../../../designSystem/theme/color.dart';
import 'component/google_login_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: GogoColors.black),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 111),
            child: SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GoogleLoginButton(onPressed: () {}),
              ),
            ),
          ),
          Center(
            child: SvgPicture.asset(
              'assets/drawable/logo.svg',
            ),
          ),
        ],
      ),
    );
  }
}
