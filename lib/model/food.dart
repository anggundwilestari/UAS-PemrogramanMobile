class Food {
  int? id;
  String nama;
  String asal;

  Food({this.id, required this.nama, required this.asal});

  Map<String, dynamic> toMap() => {"id": id, "nama": nama, "asal": asal};

  factory Food.fromMap(Map<String, dynamic> data) =>
      Food(id: data["id"], nama: data["nama"], asal: data["asal"]);
}
