import 'package:flutter/material.dart';
import 'package:flutter_techinal_test_rick_and_morty/models/character_model.dart.dart';
import 'package:flutter_techinal_test_rick_and_morty/provider/api_provider.dart';
import 'package:flutter_techinal_test_rick_and_morty/screens/home_page.dart';
import 'package:flutter_techinal_test_rick_and_morty/screens/personajes_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());
final GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return Homepage();
      },
      routes: [
        GoRoute(
            path: 'character',
            builder: (context, state) {
              final character = state.extra as Character;
              return Characterscreen(
                character: character,
              );
            })
      ])
]);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      child: MaterialApp.router(
        title: 'RICKY Y MORTY APP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}
