
import 'package:bloc/bloc.dart';

// Define the states
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoggedOut extends HomeState {}

// Define the Cubit
class HomeCubit extends Cubit<HomeState> {
	HomeCubit() : super(HomeInitial());

	void logout() {
		emit(HomeLoading());
		// Simulate logout logic, could be async operation here
		emit(HomeLoggedOut());
	}
}
