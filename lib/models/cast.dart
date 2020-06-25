class Cast {
  int id;
  String character;
  String name;
  String img;

  Cast(this.id, this.character, this.name, this.img);

  Cast.jsonDecode(Map<String, dynamic> json)
      : id = json["cast_id"],
        character = json["character"],
        name = json["name"],
        img = json["profile_path"];
}
