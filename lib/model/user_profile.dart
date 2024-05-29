class UserProfile {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? loginType;
  Member? member;

  UserProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.loginType,
    this.member,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        loginType: json["login_type"],
        member: json["member"] == null ? null : Member.fromJson(json["member"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "login_type": loginType,
        "member": member?.toJson(),
      };
}

class Member {
  int? userId;
  String? phone;
  String? emergencyName;
  String? emergencyPhone;
  String? address;
  String? gender;
  DateTime? dateOfBirth;
  int? tierId;
  String? image;
  String? deviceToken;
  String? referralCode;
  bool? isVerified;
  int? remainingCredit;
  int? classCompleted;
  int? rewardPoints;
  int? loyaltyPoints;
  String? tierProgress;
  List<String>? recentAchievement;
  String? imageUrl;
  MemberVerified? memberVerified;
  List<dynamic>? referrals;
  Tier? tier;

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
    this.memberVerified,
    this.referrals,
    this.tier,
  });

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
            : List<String>.from(json["recentAchievement"]!.map((x) => x)),
        imageUrl: json["imageUrl"],
        memberVerified: json["memberVerified"] == null
            ? null
            : MemberVerified.fromJson(json["memberVerified"]),
        referrals: json["referrals"] == null
            ? []
            : List<dynamic>.from(json["referrals"]!.map((x) => x)),
        tier: json["tier"] == null ? null : Tier.fromJson(json["tier"]),
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
        "memberVerified": memberVerified?.toJson(),
        "referrals": referrals == null
            ? []
            : List<dynamic>.from(referrals!.map((x) => x)),
        "tier": tier?.toJson(),
      };
}

class MemberVerified {
  int? memberId;

  MemberVerified({
    this.memberId,
  });

  factory MemberVerified.fromJson(Map<String, dynamic> json) => MemberVerified(
        memberId: json["memberID"],
      );

  Map<String, dynamic> toJson() => {
        "memberID": memberId,
      };
}

class Tier {
  int? id;
  String? name;
  double? rpMultiplier;
  int? lpAmount;

  Tier({
    this.id,
    this.name,
    this.rpMultiplier,
    this.lpAmount,
  });

  factory Tier.fromJson(Map<String, dynamic> json) => Tier(
        id: json["id"],
        name: json["name"],
        rpMultiplier: json["rpMultiplier"]?.toDouble(),
        lpAmount: json["lpAmount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rpMultiplier": rpMultiplier,
        "lpAmount": lpAmount,
      };
}
