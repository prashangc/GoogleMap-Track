import 'package:blog/core/widgets/appbar/custom_appbar.dart';
import 'package:blog/feature/home/presentation/bloc/home_bloc.dart';
import 'package:blog/feature/home/presentation/bloc/home_state.dart';
import 'package:blog/feature/home/presentation/widgets/go_to_map_view.dart';
import 'package:blog/feature/home/presentation/widgets/home_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Home Page"),
      floatingActionButton: const NavToMap(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeErrorState) {
            return Center(child: Text(state.error));
          }
          if (state is HomeSuccessState) {
            return HomeListView(newsModel: state.newsModel);
          }
          return const Text("thing went wrong on bloc");
        },
      ),
    );
  }
}
