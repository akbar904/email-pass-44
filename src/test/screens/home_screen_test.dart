
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/screens/home_screen.dart';
import 'package:com.example.flutter_cubit_app/cubits/home_cubit.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
	group('HomeScreen', () {
		late HomeCubit homeCubit;

		setUp(() {
			homeCubit = MockHomeCubit();
		});

		testWidgets('displays a logout button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<HomeCubit>(
						create: (context) => homeCubit,
						child: HomeScreen(),
					),
				),
			);
			expect(find.byType(TextButton), findsOneWidget);
			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('triggers logout when logout button is pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<HomeCubit>(
						create: (context) => homeCubit,
						child: HomeScreen(),
					),
				),
			);
			await tester.tap(find.text('Logout'));
			await tester.pump();
			verify(() => homeCubit.logout()).called(1);
		});
	});
}
