import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import 'package:nti5/core/data_source/firebase_data_source.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseDataSource firebaseDataSource;

  AuthCubit(this.firebaseDataSource) : super(AuthInitial());

  Future<void> signUp(String email, String password, String name) async {
    emit(AuthLoading());

    try {
      await firebaseDataSource.signUp(email, password, name);
      emit(AuthSuccess("Signup Success"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      await firebaseDataSource.login(email, password);
      emit(AuthSuccess("Login Success"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}