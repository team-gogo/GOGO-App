import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/design_system/theme/color.dart';
import '../../../core/design_system/theme/icon.dart';
import '../../logIn/widgets/google_login_button.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      // Google 로그인
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // 로그인 취소
      }

      // Google 인증을 통해 ID 토큰과 인증 정보를 받음
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Firebase에 Google 인증 정보를 전달하여 로그인
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase에서 로그인
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Error during Google sign-in: $e");
      return null;
    }
  }

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
                child: GoogleLoginButton(onPressed: () async {
                  User? user = await signInWithGoogle();
                  if (user != null) {
                    // 로그인 성공
                    print('Signed in as ${user.displayName}');
                  } else {
                    // 로그인 실패
                    print('Sign-in failed');
                  }
                }),
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
