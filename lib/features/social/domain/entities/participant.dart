class Participant {
  int id;
  String display;
  bool publisher;
  bool talking;

  Participant({
    this.id,
    this.display,
    this.publisher,
    this.talking,
  });

  Participant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        display = json['display'],
        publisher = json['publisher'],
        talking = json['talking'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'display': display,
        'publisher': publisher,
        'talking': talking,
      };
}
