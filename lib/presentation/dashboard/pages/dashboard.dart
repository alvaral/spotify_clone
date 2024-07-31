import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_flutter/presentation/dashboard/bloc/dashboard_cubit.dart';
import 'package:spotify_clone_flutter/presentation/dashboard/pages/example_pages.dart';
import 'package:spotify_clone_flutter/presentation/home/pages/home_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            body: _getBody(state),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _getCurrentIndex(state),
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.read<DashboardCubit>().showHome();
                    break;
                  case 1:
                    context.read<DashboardCubit>().showSearch();
                    break;
                  case 2:
                    context.read<DashboardCubit>().showLibrary();
                    break;
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_music),
                  label: 'Your Library',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getBody(DashboardState state) {
    switch (state) {
      case DashboardState.home:
        return const HomePage();
      case DashboardState.search:
        return SearchPage();
      case DashboardState.library:
        return YourLibraryPage();
      default:
        return const HomePage();
    }
  }

  int _getCurrentIndex(DashboardState state) {
    switch (state) {
      case DashboardState.home:
        return 0;
      case DashboardState.search:
        return 1;
      case DashboardState.library:
        return 2;
      default:
        return 0;
    }
  }
}
