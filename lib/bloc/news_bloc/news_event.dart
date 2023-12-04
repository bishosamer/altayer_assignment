part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class GetNews extends NewsEvent {
  final TextEditingController controller;

  GetNews({required this.controller});
}
