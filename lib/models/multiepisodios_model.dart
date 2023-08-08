// To parse this JSON data, do
//
//     final episodios = episodiosFromJson(jsonString);

import 'dart:convert';

List<Episodios> episodiosFromJson(String str) => List<Episodios>.from(json.decode(str).map((x) => Episodios.fromJson(x)));

String episodiosToJson(List<Episodios> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Episodios {
    int? id;
    String? name;
    String? airDate;
    String? episode;
    List<String>? characters;
    String? url;
    DateTime? created;

    Episodios({
        this.id,
        this.name,
        this.airDate,
        this.episode,
        this.characters,
        this.url,
        this.created,
    });

    factory Episodios.fromJson(Map<String, dynamic> json) => Episodios(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: json["characters"] == null ? [] : List<String>.from(json["characters"]!.map((x) => x)),
        url: json["url"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode": episode,
        "characters": characters == null ? [] : List<dynamic>.from(characters!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
    };
}
