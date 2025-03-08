import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/presentation/sign_up/bloc/name/name_bloc.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_bloc.dart';
import 'package:gogo_app/presentation/sign_up/bloc/sex/sex_bloc.dart';
import 'package:gogo_app/presentation/sign_up/widgets/page/name_page.dart';
import 'package:gogo_app/presentation/sign_up/widgets/page/number_page.dart';
import 'package:gogo_app/presentation/sign_up/widgets/page/school_page.dart';
import 'package:gogo_app/presentation/sign_up/widgets/page/sex_page.dart';
import '../bloc/number/number_bloc.dart';
import '../bloc/sex/sex_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static final PageController _pageController = PageController();
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController schoolController = TextEditingController();
  static final TextEditingController gradeController = TextEditingController();
  static final TextEditingController classController = TextEditingController();
  static final TextEditingController numberController = TextEditingController();
  static Sex? sexController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NameBloc(nameController)),
        BlocProvider(
            create: (_) => NumberBloc(
                  gradeController,
                  classController,
                  numberController,
                )),
        BlocProvider(create: (_) => SchoolBloc(schoolController)),
        BlocProvider(create: (_) => SexBloc(sexController)),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 50, 16, 95),
                child: PageView(
                  controller: _pageController,
                  children: <Widget>[
                    SchoolPage(pageController: _pageController),
                    NamePage(pageController: _pageController),
                    NumberPage(pageController: _pageController),
                    SexPage(pageController: _pageController)
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
