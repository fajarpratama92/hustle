import 'dart:convert';

class BookingHistoryCompleted {
  int? currentPage;
  List<Data>? data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  String? perPage;
  dynamic prevPageUrl;
  int? to;
  num total;

  BookingHistoryCompleted({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    required this.total,
  });

  factory BookingHistoryCompleted.fromRawJson(String str) =>
      BookingHistoryCompleted.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookingHistoryCompleted.fromJson(Map<String, dynamic> json) =>
      BookingHistoryCompleted(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Data {
  int? id;
  int? memberPackageId;
  int? sessionId;
  String? status;
  DateTime? createdAt;
  int? memberId;
  double? averageRating;
  bool? isCancelable;
  Session? session;
  bool? isUserComment;

  Data({
    this.id,
    this.memberPackageId,
    this.sessionId,
    this.status,
    this.createdAt,
    this.memberId,
    this.averageRating,
    this.isCancelable,
    this.session,
    this.isUserComment,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["id"],
      memberPackageId: json["memberPackageID"],
      sessionId: json["sessionID"],
      status: json["status"],
      createdAt: DateTime.parse(json["createdAt"]),
      memberId: json["memberID"],
      averageRating: json["averageRating"]?.toDouble(),
      isCancelable: json["isCancelable"],
      session: Session.fromJson(json["session"]),
      isUserComment: json["isUserComment"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "memberPackageID": memberPackageId,
        "sessionID": sessionId,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "memberID": memberId,
        "averageRating": averageRating,
        "isCancelable": isCancelable,
        "session": session?.toJson(),
        "isUserComment": isUserComment
      };
}

class Session {
  int? id;
  DateTime? start;
  int? sportsClassId;
  int? teacherId;
  int? locationId;
  int? price;
  String? category;
  int? quota;
  int? slotTaken;
  String? endTime;
  bool? isCancelable;
  SportsClass? sportsClass;
  Location? location;
  Teacher? teacher;

  Session({
    this.id,
    this.start,
    this.sportsClassId,
    this.teacherId,
    this.locationId,
    this.price,
    this.category,
    this.quota,
    this.slotTaken,
    this.endTime,
    this.isCancelable,
    this.sportsClass,
    this.location,
    this.teacher,
  });

  factory Session.fromRawJson(String str) => Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        start: DateTime.parse(json["start"]),
        sportsClassId: json["sportsClassID"],
        teacherId: json["teacherID"],
        locationId: json["location_id"],
        price: json["price"],
        category: json["category"],
        quota: json["quota"],
        slotTaken: json["slotTaken"],
        endTime: json["endTime"],
        isCancelable: json["isCancelable"],
        sportsClass: json["sportsClass"] == null
            ? null
            : SportsClass.fromJson(json["sportsClass"]),
        location: json['location'] == null
            ? null
            : Location.fromJson(json["location"]),
        teacher: Teacher.fromJson(json["teacher"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start": start?.toIso8601String(),
        "sportsClassID": sportsClassId,
        "teacherID": teacherId,
        "location_id": locationId,
        "price": price,
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

class Location {
  int? id;
  String? locationName;

  Location({
    this.id,
    this.locationName,
  });

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        locationName: json["location_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location_name": locationName,
      };
}

class SportsClass {
  int? id;
  String? name;
  String? description;
  int? quota;
  int? duration;
  int? price;
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

  SportsClass({
    this.id,
    this.name,
    this.description,
    this.quota,
    this.duration,
    this.price,
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

  factory SportsClass.fromRawJson(String str) =>
      SportsClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SportsClass.fromJson(Map<String, dynamic> json) => SportsClass(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        quota: json["quota"],
        duration: json["duration"],
        price: json["price"],
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
        "price": price,
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

class Teacher {
  int? id;
  String? firstName;
  String? lastName;
  int? price;
  dynamic rewardPoint;
  dynamic about;
  dynamic image;
  String? imageUrl;

  Teacher({
    this.id,
    this.firstName,
    this.lastName,
    this.price,
    this.rewardPoint,
    this.about,
    this.image,
    this.imageUrl,
  });

  factory Teacher.fromRawJson(String str) => Teacher.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        price: json["price"],
        rewardPoint: json["rewardPoint"],
        about: json["about"],
        image: json["image"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "price": price,
        "rewardPoint": rewardPoint,
        "about": about,
        "image": image,
        "imageUrl": imageUrl,
      };
}
