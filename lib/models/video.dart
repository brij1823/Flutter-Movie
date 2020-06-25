class Video {
  String id;
  String key;
  String name;
  String site;
  String type;

  Video(this.id, this.key, this.name, this.site, this.type);

  Video.jsonDecode(Map<String, dynamic> json)
      : id = json["id"],
        key = json["key"],
        name = json["name"],
        site = json["site"],
        type = json["type"];
}
