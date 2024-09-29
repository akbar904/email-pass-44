
import 'dart:convert';

class User {
	final String id;
	final String email;

	User({required this.id, required this.email});

	// Factory method to create a User instance from a JSON object
	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			id: json['id'] as String,
			email: json['email'] as String,
		);
	}

	// Method to convert a User instance to a JSON object
	Map<String, dynamic> toJson() {
		return {
			'id': id,
			'email': email,
		};
	}
}
