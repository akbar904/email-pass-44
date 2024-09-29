
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/screens/login_screen.dart';
import 'package:com.example.flutter_cubit_app/cubits/login_cubit.dart';
import 'package:com.example.flutter_cubit_app/widgets/login_form.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('should display email and password fields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<LoginCubit>(
						create: (_) => MockLoginCubit(),
						child: LoginScreen(),
					),
				),
			);

			expect(find.byType(LoginForm), findsOneWidget);
		});

		testWidgets('should display login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<LoginCubit>(
						create: (_) => MockLoginCubit(),
						child: LoginScreen(),
					),
				),
			);

			expect(find.text('Login'), findsOneWidget);
		});
	});

	group('LoginCubit Tests', () {
		late LoginCubit loginCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
		});

		blocTest<LoginCubit, LoginState>(
			'emit [LoginLoading, LoginSuccess] when login is successful',
			build: () => loginCubit,
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => <LoginState>[
				LoginLoading(),
				LoginSuccess(),
			],
		);

		blocTest<LoginCubit, LoginState>(
			'emit [LoginLoading, LoginFailure] when login fails',
			build: () => loginCubit,
			act: (cubit) => cubit.login('test@example.com', 'wrongpassword'),
			expect: () => <LoginState>[
				LoginLoading(),
				LoginFailure('Invalid credentials'),
			],
		);
	});
}
