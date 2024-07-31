import 'package:flutter_bloc/flutter_bloc.dart';

enum DashboardState { home, search, library }

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.home);

  void showHome() => emit(DashboardState.home);
  void showSearch() => emit(DashboardState.search);
  void showLibrary() => emit(DashboardState.library);
}
