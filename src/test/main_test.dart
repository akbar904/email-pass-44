
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_cubit_app/main.dart';

void main() {
	group('Main App Initialization Tests', () {
		testWidgets('renders MyApp', (tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.byType(MyApp), findsOneWidget);
		});

		testWidgets('displays LoginScreen initially', (tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.text('Login'), findsOneWidget); // Assuming 'Login' text is present on LoginScreen
		});
	});

	group('App Navigation Tests', () {
		testWidgets('navigates to HomeScreen on successful login', (tester) async {
			await tester.pumpWidget(MyApp());
			
			// Simulate successful login
			await tester.enterText(find.byType(TextField).first, 'test@example.com');
			await tester.enterText(find.byType(TextField).last, 'password');
			await tester.tap(find.byType(ElevatedButton)); // Assuming ElevatedButton triggers login
			await tester.pumpAndSettle();

			expect(find.text('Home'), findsOneWidget); // Assuming 'Home' text is present on HomeScreen
		});

		testWidgets('navigates back to LoginScreen on logout', (tester) async {
			await tester.pumpWidget(MyApp());
			
			// Simulate successful login
			await tester.enterText(find.byType(TextField).first, 'test@example.com');
			await tester.enterText(find.byType(TextField).last, 'password');
			await tester.tap(find.byType(ElevatedButton)); // Assuming ElevatedButton triggers login
			await tester.pumpAndSettle();

			// Now trigger logout
			await tester.tap(find.byType(ElevatedButton)); // Assuming ElevatedButton on HomeScreen triggers logout
			await tester.pumpAndSettle();

			expect(find.text('Login'), findsOneWidget); // Back to LoginScreen
		});
	});
}
