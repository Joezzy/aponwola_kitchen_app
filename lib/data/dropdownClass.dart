import 'dart:convert';

List<DropDownClass> dropDownClassFromJson(String str) =>
    List<DropDownClass>.from(
        json.decode(str).map((x) => DropDownClass.fromJson(x)));

String dropDownClassToJson(List<DropDownClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DropDownClass {
  DropDownClass({
    this.caption,
    this.type,
  });

  String? caption;
  String? type;

  factory DropDownClass.fromJson(Map<String, dynamic> json) => DropDownClass(
        caption: json["caption"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "caption": caption,
        "type": type,
      };
}
