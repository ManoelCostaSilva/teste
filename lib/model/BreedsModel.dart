import 'dart:convert';

Breeds breedsFromJson(String str) => Breeds.fromJson(json.decode(str));

String breedsToJson(Breeds data) => json.encode(data.toJson());

class Breeds {
  Breeds({
    this.message,
    this.status,
  });

  Map<String, List<String>>? message;
  String? status;

  factory Breeds.fromJson(Map<String, dynamic> json) => Breeds(
    message: Map.from(json["message"]).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": Map.from(message!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
    "status": status,
  };
}
