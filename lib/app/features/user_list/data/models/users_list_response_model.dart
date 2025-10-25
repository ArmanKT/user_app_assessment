// To parse this JSON data, do
//
//     final userListResponseModel = userListResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:user_app_assessment/app/features/user_list/data/models/user_model.dart';

UserListResponseModel userListResponseModelFromJson(String str) => UserListResponseModel.fromJson(json.decode(str));

String userListResponseModelToJson(UserListResponseModel data) => json.encode(data.toJson());

class UserListResponseModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<UserModel> data;

  UserListResponseModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    required this.data,
  });

  factory UserListResponseModel.fromJson(Map<String, dynamic> json) => UserListResponseModel(
        page: json["page"] ?? 0,
        perPage: json["per_page"] ?? 0,
        total: json["total"] ?? 0,
        totalPages: json["total_pages"] ?? 0,
        data: List<UserModel>.from(json["data"].map((x) => UserModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  bool get hasNextPage => (page ?? 0) < (totalPages ?? 0);
}
