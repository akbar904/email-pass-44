
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/login_cubit.dart';

class LoginForm extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocListener<LoginCubit, LoginState>(
			listener: (context, state) {
				if (state is LoginFailure) {
					ScaffoldMessenger.of(context)
						.showSnackBar(SnackBar(content: Text(state.error)));
				}
			},
			child: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					children: <Widget>[
						TextField(
							key: Key('emailField'),
							decoration: InputDecoration(labelText: 'Email'),
							onChanged: (value) => context.read<LoginCubit>().emailChanged(value),
						),
						SizedBox(height: 8.0),
						TextField(
							key: Key('passwordField'),
							obscureText: true,
							decoration: InputDecoration(labelText: 'Password'),
							onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
						),
						SizedBox(height: 16.0),
						ElevatedButton(
							key: Key('loginButton'),
							onPressed: () {
								final loginCubit = context.read<LoginCubit>();
								loginCubit.login(loginCubit.state.email, loginCubit.state.password);
							},
							child: Text('Login'),
						),
					],
				),
			),
		);
	}
}
