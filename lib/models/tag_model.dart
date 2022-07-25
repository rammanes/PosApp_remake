import 'dart:convert';

TagModel tagModelFromJson(String str) => TagModel.fromJson(json.decode(str));

String tagModelToJson(TagModel data) => json.encode(data.toJson());

class TagModel {
  TagModel({
    required this.ndefformatable,
  });

  Ndefformatable ndefformatable;

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
    ndefformatable: Ndefformatable.fromJson(json["ndefformatable"]),
  );

  Map<String, dynamic> toJson() => {
    "ndefformatable": ndefformatable.toJson(),
  };
}

class Ndefformatable {
  Ndefformatable({
    required this.identifier,
  });

  List<int> identifier;

  factory Ndefformatable.fromJson(Map<String, dynamic> json) => Ndefformatable(
    identifier: List<int>.from(json["identifier"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "identifier": List<dynamic>.from(identifier.map((x) => x)),
  };
}