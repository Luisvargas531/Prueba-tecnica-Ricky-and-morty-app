import 'package:flutter/material.dart';
import 'package:flutter_techinal_test_rick_and_morty/models/character_model.dart.dart';
import 'package:flutter_techinal_test_rick_and_morty/provider/api_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchCharacter extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final charaterProvider = Provider.of<ApiProvider>(context);
    Widget circleLoanding() {
      return Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/images/portal.gif'),
        ),
      );
    }

    if (query.isEmpty) {
      return circleLoanding();
    }

    return FutureBuilder(
        future: charaterProvider.getCharacter(query),
        builder: (context, AsyncSnapshot<List<Character>> snapshot) {
          if (!snapshot.hasData) {
            return circleLoanding();
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final Character = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    context.go('/character', extra: Character);
                  },
                  title: Text(Character.name!),
                  leading: Hero(
                    tag: Character.id!,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(Character.image!),
                    ),
                  ),
                );
              });
        });
  }
}
