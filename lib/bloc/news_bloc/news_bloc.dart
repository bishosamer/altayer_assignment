import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:altayer_assignment/models/article_model.dart';
import 'package:altayer_assignment/repository/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsRepository repo = NewsRepository();
  NewsBloc() : super(NewsInitial()) {
    on<GetNews>((event, emit) async {
      emit(NewsLoading(controller: event.controller));
      try {
        final articles = await repo.fetchNewsByKeyword(event.controller.text);
        emit(NewsLoaded(articles: articles, controller: event.controller));
      } catch (e) {
        emit(ErrorState(message: e.toString()));
      }
    });
  }
}
