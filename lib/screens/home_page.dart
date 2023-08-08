import 'package:flutter/material.dart';
import 'package:flutter_techinal_test_rick_and_morty/models/character_model.dart.dart';
import 'package:flutter_techinal_test_rick_and_morty/provider/api_provider.dart';
import 'package:flutter_techinal_test_rick_and_morty/widgets/search_delegate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final scrollController = ScrollController();
  bool isloanding = false;
  int page = 1;
  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getCharacters(page);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isloanding = true;
        });
        page++;
        await apiProvider.getCharacters(page);
        setState(() {
          isloanding = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rick and Morty',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchCharacter());
              },
              icon: const Icon(Icons.search_sharp))
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: apiProvider.characters.isNotEmpty
            ? CharacterList(
                apiProvider: apiProvider,
                isloanding: isloanding,
                scrollController: scrollController,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList(
      {super.key,
      required this.apiProvider,
      required this.scrollController,
      required this.isloanding});
  final ApiProvider apiProvider;
  final ScrollController scrollController;
  final bool isloanding;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.80,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemCount: isloanding
            ? apiProvider.characters.length + 2
            : apiProvider.characters.length,
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < apiProvider.characters.length) {}
          final character = apiProvider.characters[index];
          return GestureDetector(
            onTap: () {
              context.go('/character', extra: character);
            },
            child: Card(
              child: Column(
                children: [
                  Hero(
                    tag: character.id!,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/portal.gif'),
                      image: NetworkImage(character.image!),
                    ),
                  ),
                  Text(character.name!,
                      style: TextStyle(
                          fontSize: 16, overflow: TextOverflow.ellipsis))
                ],
              ),
            ),
          );
        });
  }
}
