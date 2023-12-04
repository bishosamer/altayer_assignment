import 'package:altayer_assignment/bloc/news_bloc/news_bloc.dart';
import 'package:altayer_assignment/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NewsBloc, NewsState>(
        listener: (context, state) {
          if (state is NewsLoaded) {
            context.go('/articles');
          }

          if (state is ErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'News about anything',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: CustomTextField(
                      searchTextController: searchTextController),
                ),
                state is NewsLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        height: 40,
                        width: 120,
                        child: ElevatedButton(
                            onPressed: () {
                              if (searchTextController.text != '') {
                                context.read<NewsBloc>().add(
                                    GetNews(controller: searchTextController));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Please Search for something")));
                              }
                            },
                            child: const Text(
                              "Search",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
