import 'dart:convert';

class VoucherHistory {
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
  num? total;

  VoucherHistory({
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
    this.total,
  });

  factory VoucherHistory.fromRawJson(String str) =>
      VoucherHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VoucherHistory.fromJson(Map<String, dynamic> json) => VoucherHistory(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  int? id;
  String? code;
  int? memberId;
  int? rvId;
  int? type;
  int? limit;
  DateTime? expired;
  String? category;
  String? name;
  String? description;
  DateTime? transactionDate;

  Datum(
      {this.id,
      this.code,
      this.memberId,
      this.rvId,
      this.type,
      this.limit,
      this.expired,
      this.category,
      this.name,
      this.description,
      this.transactionDate});

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"],
      code: json["code"],
      memberId: json["memberID"],
      rvId: json["rvID"],
      type: json["type"],
      limit: json["limit"],
      expired: json["expired"] == null ? null : DateTime.parse(json["expired"]),
      category: json["category"],
      name: json["name"],
      description: json["description"],
      transactionDate: json["transactionDate"] == null
          ? null
          : DateTime.parse(json["transactionDate"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "memberID": memberId,
        "rvID": rvId,
        "type": type,
        "limit": limit,
        "expired":
            "${expired!.year.toString().padLeft(4, '0')}-${expired!.month.toString().padLeft(2, '0')}-${expired!.day.toString().padLeft(2, '0')}",
        "category": category,
        "name": name,
        "description": description,
        "transactionDate":
            "${transactionDate!.year.toString().padLeft(4, '0')}-${transactionDate!.month.toString().padLeft(2, '0')}-${transactionDate!.day.toString().padLeft(2, '0')}",
      };
}
