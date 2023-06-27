// To parse this JSON data, do
//
//     final AddSettingResponse = AddSettingResponseFromJson(jsonString);

import 'dart:convert';

AddSettingResponse AddSettingResponseFromJson(String str) => AddSettingResponse.fromJson(json.decode(str));

String AddSettingResponseToJson(AddSettingResponse data) => json.encode(data.toJson());

class AddSettingResponse {
  AddSettingResponse({
    required this.status,
    required this.response,
    required this.code,
    required this.data,
  });

  String status;
  String response;
  int code;
  String data;

  factory AddSettingResponse.fromJson(Map<String, dynamic> json) => AddSettingResponse(
    status: json["status"],
    response: json["response"],
    code: json["code"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response": response,
    "code": code,
    "data": data,
  };
}
