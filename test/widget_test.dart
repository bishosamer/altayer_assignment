import 'package:altayer_assignment/bloc/news_bloc/news_bloc.dart';
import 'package:altayer_assignment/models/article_model.dart';
import 'package:altayer_assignment/repository/news_repository.dart';
import 'package:altayer_assignment/ui/pages/article_list.dart';
import 'package:altayer_assignment/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([http.Client])
class MockNewsRepository extends Mock implements NewsRepository {
  @override
  Future<List<Article>> fetchNewsByKeyword(String keyword) {
    return Future(() => [Article.fromJson(mockArticle)]);
  }
}

void main() {
  testWidgets('HomePage normal flow', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    MockNewsRepository mockRepo = MockNewsRepository();

    await tester.pumpWidget(BlocProvider(
      create: (context) => NewsBloc(mockRepo),
      child: MaterialApp.router(
          title: 'Altayer Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: router),
    ));

    expect(find.text('News about anything'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.enterText(find.byType(TextField), 'keyword');

    await tester.tap(find.byType(ElevatedButton));

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();

    await mockNetworkImages(() async => tester.pump());

    expect(find.byType(CircularProgressIndicator), findsAtLeastNWidgets(1));
    await mockNetworkImages(() async => tester.pumpAndSettle());
  });
  testWidgets('HomePage no string input ', (WidgetTester tester) async {
    MockNewsRepository mockRepo = MockNewsRepository();

    await tester.pumpWidget(BlocProvider(
      create: (context) => NewsBloc(mockRepo),
      child: MaterialApp.router(
          title: 'Altayer Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: router),
    ));

    expect(find.text('News about anything'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.tap(find.byType(ElevatedButton));

    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    await tester.pumpAndSettle();
  });
}

var mockArticle = {
  "source": {"id": "source_id", "name": "Source Name"},
  "author": "John Doe",
  "title": "Sample Article Title",
  "description":
      "This is a sample article description. It can provide a brief overview of the article content.",
  "url": "https://www.example.com/sample-article",
  "urlToImage": "https://picsum.photos/200/300",
  "publishedAt": "2023-12-05T12:30:00Z",
  "content":
      "This is the content of the sample article. It can contain more detailed information about the article topic."
};
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: '/articles',
      builder: (context, state) {
        return const ArticlePage();
      },
    )
  ],
);
