
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/widgets/logout_button.dart';

// Mock HomeCubit for testing purposes
class MockHomeCubit extends MockCubit<void> implements HomeCubit {}

void main() {
	group('LogoutButton Widget Tests', () {
		late HomeCubit homeCubit;

		setUp(() {
			homeCubit = MockHomeCubit();
		});

		testWidgets('should show a button with text "Logout"', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<HomeCubit>.value(
							value: homeCubit,
							child: LogoutButton(),
						),
					),
				),
			);

			expect(find.text('Logout'), findsOneWidget);
			expect(find.byType(ElevatedButton), findsOneWidget);
		});
		
		testWidgets('should call logout on HomeCubit when pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<HomeCubit>.value(
							value: homeCubit,
							child: LogoutButton(),
						),
					),
				),
			);

			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			verify(() => homeCubit.logout()).called(1);
		});
	});
}
