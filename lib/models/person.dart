class PersonModel {
  int id;
  double popularity;
  String name;
  String profileImg;
  String known;

  PersonModel(this.id, this.popularity, this.name, this.profileImg, this.known);

  PersonModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        name = json["name"],
        profileImg = json["profile_path"],
        known = json["known_for_department"];
}
