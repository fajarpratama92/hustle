import 'dart:convert';

class ComplimentaryVouchers {
  int? code;
  bool? status;
  String? message;
  List<Datum>? data;
  List<dynamic>? errors;

  ComplimentaryVouchers({
    this.code,
    this.status,
    this.message,
    this.data,
    this.errors,
  });

  factory ComplimentaryVouchers.fromRawJson(String str) =>
      ComplimentaryVouchers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ComplimentaryVouchers.fromJson(Map<String, dynamic> json) =>
      ComplimentaryVouchers(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        errors: json["errors"] == null
            ? []
            : List<dynamic>.from(json["errors"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "errors":
            errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
      };
}

class Datum {
  int? id;
  String? code;
  int? memberId;
  int? rvId;
  DateTime? expired;
  RewardVoucher? rewardVoucher;

  Datum({
    this.id,
    this.code,
    this.memberId,
    this.rvId,
    this.expired,
    this.rewardVoucher,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        memberId: json["memberID"],
        rvId: json["rvID"],
        expired:
            json["expired"] == null ? null : DateTime.parse(json["expired"]),
        rewardVoucher: json["rewardVoucher"] == null
            ? null
            : RewardVoucher.fromJson(json["rewardVoucher"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "memberID": memberId,
        "rvID": rvId,
        "expired":
            "${expired!.year.toString().padLeft(4, '0')}-${expired!.month.toString().padLeft(2, '0')}-${expired!.day.toString().padLeft(2, '0')}",
        "rewardVoucher": rewardVoucher?.toJson(),
      };
}

class RewardVoucher {
  int? id;
  String? name;
  String? code;
  int? value;
  int? rewardPoints;
  String? image;
  String? description;
  DateTime? expired;
  int? isPercentage;
  String? imageUrl;

  RewardVoucher({
    this.id,
    this.name,
    this.code,
    this.value,
    this.rewardPoints,
    this.image,
    this.description,
    this.expired,
    this.isPercentage,
    this.imageUrl,
  });

  factory RewardVoucher.fromRawJson(String str) =>
      RewardVoucher.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RewardVoucher.fromJson(Map<String, dynamic> json) => RewardVoucher(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        value: json["value"],
        rewardPoints: json["rewardPoints"],
        image: json["image"],
        description: json["description"],
        expired:
            json["expired"] == null ? null : DateTime.parse(json["expired"]),
        isPercentage: json["isPercentage"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "value": value,
        "rewardPoints": rewardPoints,
        "image": image,
        "description": description,
        "expired": expired?.toIso8601String(),
        "isPercentage": isPercentage,
        "imageUrl": imageUrl,
      };
}
