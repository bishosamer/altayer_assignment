part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {
  final TextEditingController controller;

  NewsLoading({required this.controller});
}

class NewsLoaded extends NewsState {
  final List<Article> articles;
  final TextEditingController controller;
  NewsLoaded({required this.controller, required this.articles});
}

class ErrorState extends NewsState {
  final String message;

  ErrorState({required this.message});
}
