import 'dart:convert';

class ReferralList {
  int? code;
  bool? status;
  String? message;
  List<Datum>? data;

  ReferralList({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory ReferralList.fromRawJson(String str) =>
      ReferralList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReferralList.fromJson(Map<String, dynamic> json) => ReferralList(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? referrerId;
  int? memberId;
  DateTime? createdAt;
  dynamic isActive;
  Member? member;

  Datum({
    this.referrerId,
    this.memberId,
    this.createdAt,
    this.isActive,
    this.member,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        referrerId: json["referrerID"],
        memberId: json["memberID"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        isActive: json["isActive"],
        member: json["member"] == null ? null : Member.fromJson(json["member"]),
      );

  Map<String, dynamic> toJson() => {
        "referrerID": referrerId,
        "memberID": memberId,
        "createdAt": createdAt?.toIso8601String(),
        "isActive": isActive,
        "member": member?.toJson(),
      };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? loginType;
  bool? isAdmin;
  bool? isManager;
  bool? isOperator;
  bool? isMember;
  bool? hasActiveShift;
  dynamic administrator;
  dynamic manager;
  dynamic userOperator;
  Member? member;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.loginType,
    this.isAdmin,
    this.isManager,
    this.isOperator,
    this.isMember,
    this.hasActiveShift,
    this.administrator,
    this.manager,
    this.userOperator,
    this.member,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        loginType: json["login_type"],
        isAdmin: json["isAdmin"],
        isManager: json["isManager"],
        isOperator: json["isOperator"],
        isMember: json["isMember"],
        hasActiveShift: json["hasActiveShift"],
        administrator: json["administrator"],
        manager: json["manager"],
        userOperator: json["operator"],
        member: json["member"] == null ? null : Member.fromJson(json["member"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "login_type": loginType,
        "isAdmin": isAdmin,
        "isManager": isManager,
        "isOperator": isOperator,
        "isMember": isMember,
        "hasActiveShift": hasActiveShift,
        "administrator": administrator,
        "manager": manager,
        "operator": userOperator,
        "member": member?.toJson(),
      };
}

class Member {
  int? userId;
  String? phone;
  String? emergencyName;
  String? emergencyPhone;
  dynamic address;
  String? gender;
  DateTime? dateOfBirth;
  int? tierId;
  dynamic image;
  dynamic deviceToken;
  dynamic referralCode;
  bool? isVerified;
  int? remainingCredit;
  int? classCompleted;
  int? rewardPoints;
  int? loyaltyPoints;
  String? tierProgress;
  List<dynamic>? recentAchievement;
  String? imageUrl;
  User? user;
  dynamic memberVerified;

  Member({
    this.userId,
    this.phone,
    this.emergencyName,
    this.emergencyPhone,
    this.address,
    this.gender,
    this.dateOfBirth,
    this.tierId,
    this.image,
    this.deviceToken,
    this.referralCode,
    this.isVerified,
    this.remainingCredit,
    this.classCompleted,
    this.rewardPoints,
    this.loyaltyPoints,
    this.tierProgress,
    this.recentAchievement,
    this.imageUrl,
    this.user,
    this.memberVerified,
  });

  factory Member.fromRawJson(String str) => Member.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        userId: json["userID"],
        phone: json["phone"],
        emergencyName: json["emergencyName"],
        emergencyPhone: json["emergencyPhone"],
        address: json["address"],
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        tierId: json["tierID"],
        image: json["image"],
        deviceToken: json["deviceToken"],
        referralCode: json["referralCode"],
        isVerified: json["isVerified"],
        remainingCredit: json["remainingCredit"],
        classCompleted: json["classCompleted"],
        rewardPoints: json["rewardPoints"],
        loyaltyPoints: json["loyaltyPoints"],
        tierProgress: json["tierProgress"],
        recentAchievement: json["recentAchievement"] == null
            ? []
            : List<dynamic>.from(json["recentAchievement"]!.map((x) => x)),
        imageUrl: json["imageUrl"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        memberVerified: json["memberVerified"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "phone": phone,
        "emergencyName": emergencyName,
        "emergencyPhone": emergencyPhone,
        "address": address,
        "gender": gender,
        "dateOfBirth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "tierID": tierId,
        "image": image,
        "deviceToken": deviceToken,
        "referralCode": referralCode,
        "isVerified": isVerified,
        "remainingCredit": remainingCredit,
        "classCompleted": classCompleted,
        "rewardPoints": rewardPoints,
        "loyaltyPoints": loyaltyPoints,
        "tierProgress": tierProgress,
        "recentAchievement": recentAchievement == null
            ? []
            : List<dynamic>.from(recentAchievement!.map((x) => x)),
        "imageUrl": imageUrl,
        "user": user?.toJson(),
        "memberVerified": memberVerified,
      };
}
