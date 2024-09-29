
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_cubit_app/cubits/login_cubit.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginCubit', () {
		late LoginCubit loginCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
		});

		test('initial state is LoginInitial', () {
			expect(loginCubit.state, LoginInitial());
		});

		blocTest<LoginCubit, LoginState>(
			'emits [LoginLoading, LoginSuccess] when login is successful',
			build: () => LoginCubit(),
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => [
				LoginLoading(),
				LoginSuccess(),
			],
		);

		blocTest<LoginCubit, LoginState>(
			'emits [LoginLoading, LoginFailure] when login fails',
			build: () => LoginCubit(),
			act: (cubit) => cubit.login('wrong@example.com', 'wrongpassword'),
			expect: () => [
				LoginLoading(),
				LoginFailure('Invalid credentials'),
			],
		);
	});
}
