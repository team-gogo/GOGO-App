import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/router.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../../logIn/widgets/google_login_button.dart';

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
                child: GoogleLoginButton(
                    onPressed: () =>context.goNamed(PageRouter.signUp)),
              ),
            ),
          ),
          Center(
            child: GogoIcons.logo(width: double.infinity, height: 80),
          ),
        ],
      ),
    );
  }
}
