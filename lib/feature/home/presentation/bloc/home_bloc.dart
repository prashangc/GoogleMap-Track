import 'package:blog/core/services/network/network_response.dart';
import 'package:blog/feature/home/data/model/news_model.dart';
import 'package:blog/feature/home/data/repo/news_repository.dart';
import 'package:blog/feature/home/presentation/bloc/home_event.dart';
import 'package:blog/feature/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NewsRepository newsRepository;
  HomeBloc({required this.newsRepository}) : super(HomeLoadingState()) {
    on<HomeSuccessEvent>(
      ((event, emit) async {
        emit(HomeSuccessState(newsModel: event.newsModel));
      }),
    );
    on<HomeErrorEvent>(
      ((event, emit) async {
        emit(HomeErrorState(error: event.error));
      }),
    );
    on<HomeFetchEvent>(
      ((event, emit) async {
        DataResponse<NewsModel> resp = await newsRepository.fetchNews();
        if (resp.status == NetworkStatus.sucess) {
          add(HomeSuccessEvent(newsModel: resp.data!));
        } else {
          add(HomeErrorEvent(error: resp.message.toString()));
        }
      }),
    );
    add(HomeFetchEvent());
  }
}
