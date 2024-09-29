
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/widgets/login_form.dart';
import 'package:com.example.flutter_cubit_app/cubits/login_cubit.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginForm Widget Tests', () {
		testWidgets('renders email and password TextFields', (WidgetTester tester) async {
			final mockLoginCubit = MockLoginCubit();
			when(() => mockLoginCubit.state).thenReturn(LoginInitial());

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<LoginCubit>.value(
						value: mockLoginCubit,
						child: LoginForm(),
					),
				),
			);

			expect(find.byType(TextField), findsNWidgets(2));
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
		});

		testWidgets('renders login button', (WidgetTester tester) async {
			final mockLoginCubit = MockLoginCubit();
			when(() => mockLoginCubit.state).thenReturn(LoginInitial());

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<LoginCubit>.value(
						value: mockLoginCubit,
						child: LoginForm(),
					),
				),
			);

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});

		testWidgets('shows error message on login failure', (WidgetTester tester) async {
			final mockLoginCubit = MockLoginCubit();
			when(() => mockLoginCubit.state).thenReturn(LoginFailure('Login failed'));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<LoginCubit>.value(
						value: mockLoginCubit,
						child: LoginForm(),
					),
				),
			);

			expect(find.text('Login failed'), findsOneWidget);
		});
	});

	group('LoginCubit Tests', () {
		late MockLoginCubit mockLoginCubit;

		setUp(() {
			mockLoginCubit = MockLoginCubit();
		});

		blocTest<MockLoginCubit, LoginState>(
			'emits [LoginLoading, LoginSuccess] when login is successful',
			build: () => mockLoginCubit,
			act: (cubit) {
				when(() => cubit.login('email', 'password')).thenAnswer((_) async {});
				cubit.login('email', 'password');
			},
			expect: () => [LoginLoading(), LoginSuccess()],
		);

		blocTest<MockLoginCubit, LoginState>(
			'emits [LoginLoading, LoginFailure] when login fails',
			build: () => mockLoginCubit,
			act: (cubit) {
				when(() => cubit.login('email', 'password')).thenThrow(Exception('Login failed'));
				cubit.login('email', 'password');
			},
			expect: () => [LoginLoading(), LoginFailure('Login failed')],
		);
	});
}
