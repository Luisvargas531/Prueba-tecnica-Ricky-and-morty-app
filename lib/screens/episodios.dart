import 'package:flutter/material.dart';
import 'package:flutter_techinal_test_rick_and_morty/models/character_model.dart.dart';
import 'package:flutter_techinal_test_rick_and_morty/provider/api_provider.dart';
import 'package:provider/provider.dart';

class EpisodeList extends StatefulWidget {
  const EpisodeList({Key? key, required this.size, required this.character})
      : super(key: key);
  final Size size;
  final Character character;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  get itemCount => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getEpisodes(widget.character);
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    return SizedBox(
      height: widget.size.height * 0.35,
      child: ListView.builder(
          itemCount: apiProvider.episodes.length,
          itemBuilder: (context, index) {
            final episode = apiProvider.episodes[index];
            return ListTile(
              leading: Text(episode.episode!),
              title:Text(episode.name!),
              trailing: Text(episode.airDate!),
            );
          }),
    );
  }
}
