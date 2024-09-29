
import 'package:flutter_test/flutter_test.dart';
import 'package:lib/models/user_model.dart';

void main() {
	group('User Model', () {
		test('should serialize from JSON', () {
			// Arrange
			final json = {
				'id': '123',
				'email': 'test@example.com',
			};

			// Act
			final user = User.fromJson(json);

			// Assert
			expect(user.id, '123');
			expect(user.email, 'test@example.com');
		});

		test('should serialize to JSON', () {
			// Arrange
			final user = User(id: '123', email: 'test@example.com');

			// Act
			final json = user.toJson();

			// Assert
			expect(json, {
				'id': '123',
				'email': 'test@example.com',
			});
		});

		test('should initialize properties correctly', () {
			// Arrange & Act
			final user = User(id: '123', email: 'test@example.com');

			// Assert
			expect(user.id, '123');
			expect(user.email, 'test@example.com');
		});
	});
}
