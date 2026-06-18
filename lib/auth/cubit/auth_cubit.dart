import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import 'package:nti5/core/data_source/firebase_data_source.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseDataSource firebaseDataSource;

  AuthCubit(this.firebaseDataSource) : super(AuthInitial());

  String getErrorMessage(String error) {
    if (error.contains('invalid-email')) {
      return 'Invalid email format';
    } else if (error.contains('wrong-password')) {
      return 'Wrong password';
    } else if (error.contains('user-not-found')) {
      return 'No user found with this email';
    } else if (error.contains('email-already-in-use')) {
      return 'Email already exists';
    } else {
      return 'Something went wrong';
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    emit(AuthLoading());

    try {
      // 🔥 Password validation
      if (password.length < 6) {
        emit(AuthError("Password must be at least 6 characters"));
        return;
      }

      await firebaseDataSource.signUp(email, password, name);

      emit(AuthSuccess("Signup Success"));
    } catch (e) {
      emit(AuthError(getErrorMessage(e.toString())));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      // 🔥 Password validation
      if (password.length < 6) {
        emit(AuthError("Password must be at least 6 characters"));
        return;
      }

      await firebaseDataSource.login(email, password);

      emit(AuthSuccess("Login Success"));
    } catch (e) {
      emit(AuthError(getErrorMessage(e.toString())));
    }
  }
}
