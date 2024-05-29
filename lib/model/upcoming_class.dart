import 'dart:convert';

class UpcomingClass {
  List<Active>? active;
  List<dynamic>? waiting;

  UpcomingClass({
    this.active,
    this.waiting,
  });

  factory UpcomingClass.fromRawJson(String str) =>
      UpcomingClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingClass.fromJson(Map<String, dynamic> json) => UpcomingClass(
        active:
            List<Active>.from(json["active"].map((x) => Active.fromJson(x))),
        waiting: List<dynamic>.from(json["waiting"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "active": List<dynamic>.from(active!.map((x) => x.toJson())),
        "waiting": List<dynamic>.from(waiting!.map((x) => x)),
      };
}

class Active {
  int? id;
  int? memberPackageId;
  int? sessionId;
  String? status;
  int? memberId;
  bool? isCancelable;
  UpcomingSession? session;

  Active({
    this.id,
    this.memberPackageId,
    this.sessionId,
    this.status,
    this.memberId,
    this.isCancelable,
    this.session,
  });

  factory Active.fromRawJson(String str) => Active.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Active.fromJson(Map<String, dynamic> json) => Active(
        id: json["id"],
        memberPackageId: json["memberPackageID"],
        sessionId: json["sessionID"],
        status: json["status"],
        memberId: json["memberID"],
        isCancelable: json["isCancelable"],
        session: UpcomingSession.fromJson(json["session"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "memberPackageID": memberPackageId,
        "sessionID": sessionId,
        "status": status,
        "memberID": memberId,
        "isCancelable": isCancelable,
        "session": session?.toJson(),
      };
}

class UpcomingSession {
  int? id;
  DateTime? start;
  int? sportsClassId;
  int? teacherId;
  int? locationId;
  String? category;
  int? quota;
  int? slotTaken;
  String? endTime;
  bool? isCancelable;
  UpcomingSportsClass? sportsClass;
  UpcomingLocation? location;
  UpcomingTeacher? teacher;

  UpcomingSession({
    this.id,
    this.start,
    this.sportsClassId,
    this.teacherId,
    this.locationId,
    this.category,
    this.quota,
    this.slotTaken,
    this.endTime,
    this.isCancelable,
    this.sportsClass,
    this.location,
    this.teacher,
  });

  factory UpcomingSession.fromRawJson(String str) =>
      UpcomingSession.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingSession.fromJson(Map<String, dynamic> json) =>
      UpcomingSession(
        id: json["id"],
        start: DateTime.parse(json["start"]),
        sportsClassId: json["sportsClassID"],
        teacherId: json["teacherID"],
        locationId: json["location_id"],
        category: json["category"],
        quota: json["quota"],
        slotTaken: json["slotTaken"],
        endTime: json["endTime"],
        isCancelable: json["isCancelable"],
        sportsClass: json["sportsClass"] == null
            ? null
            : UpcomingSportsClass.fromJson(json["sportsClass"]),
        location: UpcomingLocation.fromJson(json["location"]),
        teacher: UpcomingTeacher.fromJson(json["teacher"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start": start?.toIso8601String(),
        "sportsClassID": sportsClassId,
        "teacherID": teacherId,
        "location_id": locationId,
        "category": category,
        "quota": quota,
        "slotTaken": slotTaken,
        "endTime": endTime,
        "isCancelable": isCancelable,
        "sportsClass": sportsClass?.toJson(),
        "location": location?.toJson(),
        "teacher": teacher?.toJson(),
      };
}

class UpcomingLocation {
  int? id;
  String? locationName;

  UpcomingLocation({
    this.id,
    this.locationName,
  });

  factory UpcomingLocation.fromRawJson(String str) =>
      UpcomingLocation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingLocation.fromJson(Map<String, dynamic> json) =>
      UpcomingLocation(
        id: json["id"],
        locationName: json["location_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location_name": locationName,
      };
}

class UpcomingSportsClass {
  int? id;
  String? name;
  String? description;
  int? quota;
  int? duration;
  String? sportType;
  String? category;
  int? branchId;
  String? subTitle;
  int? rewardPoints;
  int? loyaltyPoints;
  String? cancellationPolicy;
  String? prepare;
  String? image;
  String? imageUrl;
  SportsClassAsset? sportsClassAsset;

  UpcomingSportsClass({
    this.id,
    this.name,
    this.description,
    this.quota,
    this.duration,
    this.sportType,
    this.category,
    this.branchId,
    this.subTitle,
    this.rewardPoints,
    this.loyaltyPoints,
    this.cancellationPolicy,
    this.prepare,
    this.image,
    this.imageUrl,
    this.sportsClassAsset,
  });

  factory UpcomingSportsClass.fromRawJson(String str) =>
      UpcomingSportsClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingSportsClass.fromJson(Map<String, dynamic> json) =>
      UpcomingSportsClass(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        quota: json["quota"],
        duration: json["duration"],
        sportType: json["sport_type"],
        category: json["category"],
        branchId: json["branchID"],
        subTitle: json["subTitle"],
        rewardPoints: json["rewardPoints"],
        loyaltyPoints: json["loyaltyPoints"],
        cancellationPolicy: json["cancellationPolicy"],
        prepare: json["prepare"],
        image: json["image"],
        imageUrl: json["imageUrl"],
        sportsClassAsset: json["sportsClassAsset"] == null
            ? null
            : SportsClassAsset.fromJson(json["sportsClassAsset"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "quota": quota,
        "duration": duration,
        "sport_type": sportType,
        "category": category,
        "branchID": branchId,
        "subTitle": subTitle,
        "rewardPoints": rewardPoints,
        "loyaltyPoints": loyaltyPoints,
        "cancellationPolicy": cancellationPolicy,
        "prepare": prepare,
        "image": image,
        "imageUrl": imageUrl,
        "sportsClassAsset": sportsClassAsset?.toJson(),
      };
}

class SportsClassAsset {
  int? id;
  String? logo;
  String? fontLogo;
  String? fontLogoColored;
  String? color;
  int? sportsClassId;
  String? logoUrl;
  String? fontLogoUrl;
  String? fontLogoColoredUrl;

  SportsClassAsset({
    this.id,
    this.logo,
    this.fontLogo,
    this.fontLogoColored,
    this.color,
    this.sportsClassId,
    this.logoUrl,
    this.fontLogoUrl,
    this.fontLogoColoredUrl,
  });

  factory SportsClassAsset.fromRawJson(String str) =>
      SportsClassAsset.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SportsClassAsset.fromJson(Map<String, dynamic> json) =>
      SportsClassAsset(
        id: json["id"],
        logo: json["logo"],
        fontLogo: json["fontLogo"],
        fontLogoColored: json["fontLogoColored"],
        color: json["color"],
        sportsClassId: json["sportsClassID"],
        logoUrl: json["logoUrl"],
        fontLogoUrl: json["fontLogoUrl"],
        fontLogoColoredUrl: json["fontLogoColoredUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
        "fontLogo": fontLogo,
        "fontLogoColored": fontLogoColored,
        "color": color,
        "sportsClassID": sportsClassId,
        "logoUrl": logoUrl,
        "fontLogoUrl": fontLogoUrl,
        "fontLogoColoredUrl": fontLogoColoredUrl,
      };
}

class UpcomingTeacher {
  int? id;
  String? firstName;
  String? lastName;
  dynamic price;
  dynamic rewardPoints;
  dynamic about;
  dynamic image;
  String? imageUrl;

  UpcomingTeacher({
    this.id,
    this.firstName,
    this.lastName,
    this.price,
    this.rewardPoints,
    this.about,
    this.image,
    this.imageUrl,
  });

  factory UpcomingTeacher.fromRawJson(String str) =>
      UpcomingTeacher.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingTeacher.fromJson(Map<String, dynamic> json) =>
      UpcomingTeacher(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        price: json["price"],
        rewardPoints: json["rewardPoints"],
        about: json["about"],
        image: json["image"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "price": price,
        "rewardPoint": rewardPoints,
        "about": about,
        "image": image,
        "imageUrl": imageUrl,
      };
}
