import 'dart:convert';

Image imageFromJson(String str) => Image.fromJson(json.decode(str));

String imageToJson(Image data) => json.encode(data.toJson());

class Image {
  Image({
    this.message,
    this.status,
  });

  List<String>? message;
  String? status;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    message: List<String>.from(json["message"].map((x) => x)),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": List<dynamic>.from(message!.map((x) => x)),
    "status": status,
  };
}
