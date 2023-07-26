class Character {
  String name;
  String img;
  int id;

  Character({
    required this.name,
    required this.img,
    required this.id,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json["name"],
      img: json["image"],
      id: json["id"],
    );
  }
}
