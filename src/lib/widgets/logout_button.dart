
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/home_cubit.dart';

class LogoutButton extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final homeCubit = context.read<HomeCubit>();

		return ElevatedButton(
			onPressed: () {
				homeCubit.logout();
			},
			child: Text('Logout'),
		);
	}
}
