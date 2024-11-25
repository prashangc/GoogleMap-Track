import 'package:blog/core/injector/dependency_injection.dart';
import 'package:blog/feature/home/data/repo/news_repository.dart';
import 'package:blog/feature/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProviders {
  AllProviders._();
  static get providers => [
        BlocProvider(
          create: (context) => HomeBloc(
            newsRepository: GetItServices.getIt<NewsRepository>(),
          ),
        ),
      ];
}
