// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:altayer_assignment/bloc/news_bloc/news_bloc.dart';
import 'package:altayer_assignment/ui/widgets/article_card.dart';
import 'package:altayer_assignment/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoaded) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Article List'),
                actions: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: CustomTextField(
                      searchTextController: state.controller,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (state.controller.text != '') {
                          context
                              .read<NewsBloc>()
                              .add(GetNews(controller: state.controller));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Please Search for something")));
                        }
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
              body: ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (BuildContext context, int index) {
                  return ArticleCard(article: state.articles[index]);
                },
              ));
        } else if (state is NewsLoading) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Article List'),
                actions: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: CustomTextField(
                      searchTextController: state.controller,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (state.controller.text != '') {
                          context
                              .read<NewsBloc>()
                              .add(GetNews(controller: state.controller));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Please Search for something")));
                        }
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ));
        } else
          return Container();
      },
    );
  }
}
