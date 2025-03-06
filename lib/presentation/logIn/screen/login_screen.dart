import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/presentation/logIn/bloc/login_bloc.dart';
import 'package:gogo_app/presentation/logIn/bloc/login_event.dart';
import 'package:gogo_app/presentation/logIn/bloc/login_state.dart';

import '../../../core/design_system/theme/icon.dart';
import '../../logIn/widgets/google_login_button.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
          listener: (BuildContext context, LoginState state) {
            // 네비게이션 세팅
          },
          child: Stack(
            children: [
              Center(
                child: GogoIcons.logo(width: double.infinity, height: 80),
              ),
              Positioned(
                bottom: 111,
                left: 16,
                right: 16,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GoogleLoginButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(GoogleLogInEvent());
                    },
                  ),
                ),
              ),
            ],
          );
      ),
    );
  }
}
