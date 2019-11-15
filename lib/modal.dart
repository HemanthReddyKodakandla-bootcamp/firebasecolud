import 'dart:convert';
Recipe itemFromJson(String str) => Recipe.fromMap(json.decode(str));

String itemToJson(Recipe data) => json.encode(data.toMap());

class Recipe {
  String title;
  String duration;
  List<String> ingredients;
  bool isFav;
  String imageUrl;

  Recipe({
    this.title,
    this.duration,
    this.ingredients,
    this.isFav,
    this.imageUrl,
  });

  factory Recipe.fromMap(Map<String, dynamic> json) => Recipe(
    title: json["title"],
    duration: json["duration"],
    ingredients: List<String>.from(json["ingredients"].map((x) => x)),
    isFav: json["isFav"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "duration": duration,
    "ingredients": List<String>.from(ingredients.map((x) => x)),
    "isFav": isFav,
    "imageUrl": imageUrl,
  };
}