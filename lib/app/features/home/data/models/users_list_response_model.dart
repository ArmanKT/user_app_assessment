// To parse this JSON data, do
//
//     final userListResponseModel = userListResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:user_app_assessment/app/features/home/data/models/user_model.dart';

UserListResponseModel userListResponseModelFromJson(String str) => UserListResponseModel.fromJson(json.decode(str));

String userListResponseModelToJson(UserListResponseModel data) => json.encode(data.toJson());

class UserListResponseModel {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<UserModel> data;

  UserListResponseModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory UserListResponseModel.fromJson(Map<String, dynamic> json) => UserListResponseModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<UserModel>.from(json["data"].map((x) => UserModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
