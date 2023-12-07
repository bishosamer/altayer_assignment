import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:altayer_assignment/models/article_model.dart';
import 'package:altayer_assignment/repository/news_repository.dart';
import 'package:connectivity/connectivity.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repo;
  late final Connectivity _connectivity;

  NewsBloc(this.repo) : super(NewsInitial()) {
    _connectivity = Connectivity();

    on<GetNews>((event, emit) async {
      final connectivityResult = await _connectivity.checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        emit(ErrorState(message: 'No internet connection.'));
        return;
      }

      emit(NewsLoading(controller: event.controller));
      try {
        if (RegExp(r'^[a-zA-Z0-9]+$').hasMatch(event.controller.text)) {
          final articles = await repo.fetchNewsByKeyword(event.controller.text);
          emit(NewsLoaded(articles: articles, controller: event.controller));
        } else {
          emit(ErrorState(message: 'Please enter a valid keyword.'));
        }
      } catch (e) {
        emit(ErrorState(message: e.toString()));
      }
    });

    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        add(NoInternetEvent());
      }
    });

    on<NoInternetEvent>((event, emit) {
      emit(ErrorState(message: 'No internet connection.'));
    });
  }
}
