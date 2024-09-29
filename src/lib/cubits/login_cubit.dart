
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_app/models/user_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
	final User user;

	LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
	final String error;

	LoginFailure(this.error);
}

class LoginCubit extends Cubit<LoginState> {
	LoginCubit() : super(LoginInitial());

	void login(String email, String password) async {
		emit(LoginLoading());

		// Mock login logic
		await Future.delayed(Duration(seconds: 1));
		if (email == 'test@example.com' && password == 'password123') {
			final user = User(id: '1', email: email);
			emit(LoginSuccess(user));
		} else {
			emit(LoginFailure('Invalid credentials'));
		}
	}
}
