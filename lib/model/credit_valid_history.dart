import 'dart:convert';

class CreditValidHistory {
  int? code;
  bool? status;
  String? message;
  DateTime? activeCreditValid;
  Data? data;

  CreditValidHistory({
    this.code,
    this.status,
    this.message,
    this.activeCreditValid,
    this.data,
  });

  factory CreditValidHistory.fromRawJson(String str) => CreditValidHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreditValidHistory.fromJson(Map<String, dynamic> json) => CreditValidHistory(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    activeCreditValid: json["active_credit_valid"] == null ? null : DateTime.parse(json["active_credit_valid"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "active_credit_valid": "${activeCreditValid!.year.toString().padLeft(4, '0')}-${activeCreditValid!.month.toString().padLeft(2, '0')}-${activeCreditValid!.day.toString().padLeft(2, '0')}",
    "data": data?.toJson(),
  };
}

class Data {
  int? currentPage;
  List<Datum>? data;
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

  Data({
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

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
  String? name;
  DateTime? transactionDate;
  int? price;
  String? status;

  Datum({
    this.id,
    this.memberId,
    this.credit,
    this.expired,
    this.name,
    this.transactionDate,
    this.price,
    this.status,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    memberId: json["memberID"],
    credit: json["credit"],
    expired: json["expired"] == null ? null : DateTime.parse(json["expired"]),
    name: json["name"],
    transactionDate: json["transactionDate"] == null ? null : DateTime.parse(json["transactionDate"]),
    price: json["price"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "memberID": memberId,
    "credit": credit,
    "expired": "${expired!.year.toString().padLeft(4, '0')}-${expired!.month.toString().padLeft(2, '0')}-${expired!.day.toString().padLeft(2, '0')}",
    "name": name,
    "transactionDate": transactionDate?.toIso8601String(),
    "price": price,
    "status": status,
  };
}