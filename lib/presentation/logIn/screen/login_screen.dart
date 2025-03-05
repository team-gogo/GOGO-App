import 'package:flutter/cupertino.dart';
import 'package:gogo_app/presentation/sign_up/screen/sign_up_screen.dart';
import '../../../core/design_system/theme/color.dart';
import '../../../core/design_system/theme/icon.dart';
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
                child: GoogleLoginButton(onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => SignUpScreen()))),
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
