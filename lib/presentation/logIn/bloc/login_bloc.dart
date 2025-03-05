import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gogo_app/presentation/logIn/bloc/login_event.dart';
import 'package:gogo_app/presentation/logIn/bloc/login_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final UserCredential userCredential;

  LoginBloc() : super(Init()) {
    on<GoogleLogInEvent>(_loginEventHandler);
  }

  Stream<LoginState> _mapGoogleSignInRequestedToState() async* {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        yield GoogleLoginFail();
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      userCredential = await _auth.signInWithCredential(credential);

      yield GoogleLoginSuccess();
    } catch (e) {
      yield GoogleLoginFail();
    }
  }

  void _loginEventHandler(LoginEvent event, Emitter<LoginState> emit) {
    _mapGoogleSignInRequestedToState();
  }
}
