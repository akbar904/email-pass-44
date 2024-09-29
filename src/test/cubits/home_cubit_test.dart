
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/cubits/home_cubit.dart';

class MockHomeCubit extends Mock implements HomeCubit {}

void main() {
	group('HomeCubit', () {
		late HomeCubit homeCubit;

		setUp(() {
			homeCubit = HomeCubit();
		});

		tearDown(() {
			homeCubit.close();
		});

		test('initial state is HomeInitial', () {
			expect(homeCubit.state, HomeInitial());
		});

		blocTest<HomeCubit, HomeState>(
			'emits [HomeLoading, HomeLoggedOut] when logout is called',
			build: () => homeCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [HomeLoading(), HomeLoggedOut()],
		);
	});
}
