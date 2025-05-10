import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/router.dart';
import '../../../design_system/theme/icon.dart';
import '../../logIn/widgets/google_login_button.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is GogoLoginFail || state is UnauthorizedGogoLoginSuccess) {
            context.goNamed(PageRouter.signUp);
          } else if (state is UserGogoLoginSuccess) {
            context.goNamed(PageRouter.home);
          }
        },
        builder: (context, state) => Scaffold(
          body: Stack(
            children: [
              Center(
                child: GogoIcons.logo(width: double.infinity, height: 60),
              ),
              Positioned(
                bottom: 111,
                left: 16,
                right: 16,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GoogleLoginButton(
                    onPressed: () =>
                        context.read<LoginBloc>().add(GoogleLogInEvent()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
