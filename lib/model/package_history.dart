import 'dart:convert';

class PackageHistory {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  String? perPage;
  dynamic prevPageUrl;
  int? to;
  num total;

  PackageHistory({
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

  factory PackageHistory.fromRawJson(String str) => PackageHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackageHistory.fromJson(Map<String, dynamic> json) => PackageHistory(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
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

class Datum {
  int? id;
  int? memberId;
  int? credit;
  DateTime? expired;
  String? package;
  String? description;
  DateTime? transactionDate;
  int? price;
  String? status;
  int? packageId;

  Datum({
    this.id,
    this.memberId,
    this.credit,
    this.expired,
    this.package,
    this.description,
    this.transactionDate,
    this.price,
    this.status,
    this.packageId
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    memberId: json["memberID"],
    credit: json["credit"],
    expired: json["expired"] == null ? null : DateTime.parse(json["expired"]),
    package: json["package"],
    description: json["description"],
    transactionDate: json["transactionDate"] == null ? null : DateTime.parse(json["transactionDate"]),
    price: json["price"],
    status: json["status"],
    packageId: json["package_id"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "memberID": memberId,
    "credit": credit,
    "expired": "${expired!.year.toString().padLeft(4, '0')}-${expired!.month.toString().padLeft(2, '0')}-${expired!.day.toString().padLeft(2, '0')}",
    "package": package,
    "description": description,
    "transactionDate": transactionDate?.toIso8601String(),
    "price": price,
    "status": status,
    "package_id": packageId,
  };
}
