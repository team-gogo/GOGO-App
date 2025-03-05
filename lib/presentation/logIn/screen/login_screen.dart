import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/presentation/logIn/bloc/login_bloc.dart';
import 'package:gogo_app/presentation/logIn/bloc/login_event.dart';
import 'package:gogo_app/presentation/logIn/bloc/login_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/design_system/theme/color.dart';
import '../../../core/design_system/theme/icon.dart';
import '../../logIn/widgets/google_login_button.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is GoogleLoginFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("구글 로그인에 실패 했습니다")),
          );
        }
        if (state is GoogleLoginSuccess) {
          SnackBar(
            content: Text("${state.user.displayName}으로 구글 로그인에 성공0 했습니다"),
          );
        }
      },
      builder: (context, state) {
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
                      onPressed: () async {
                        context.read<LoginBloc>().add(GoogleLogInEvent());
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: GogoIcons.logo(width: double.infinity, height: 80),
              ),
            ],
          ),
        );
      },
    );
  }
}
