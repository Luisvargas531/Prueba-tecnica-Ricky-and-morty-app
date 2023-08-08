import 'package:flutter/material.dart';
import 'package:flutter_techinal_test_rick_and_morty/models/character_model.dart.dart';
import 'package:flutter_techinal_test_rick_and_morty/screens/episodios.dart';

class Characterscreen extends StatelessWidget {
  final Character character;
  const Characterscreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(character.name!),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
                height: Size.height * 0.30,
                width: double.infinity,
                child: Hero(
                  tag: character.id!,
                  child: Image.network(
                    character.image!,
                    fit: BoxFit.cover,
                  ),
                )),
            Container(
                padding: EdgeInsets.all(10),
                height: Size.height * 0.20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    cardData("estatus:", character.status!),
                    cardData("especie:", character.species!),
                    cardData("origen:", character.origin!.name!),
                  ],
                )),
            const Text(
              "Episodios",
              style: TextStyle(
                  color: Color.fromARGB(255, 112, 255, 122), fontSize: 17),
            ),
            EpisodeList(size: Size, character: character)
          ],
        ),
      ),
    );
  }

  Widget cardData(String descripcion, String episodio) {
    return Expanded(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(episodio),
            Text(descripcion,
                style: TextStyle(overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}
