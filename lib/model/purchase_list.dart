class PurchaseList {
  final String? title;
  final String? description;
  final String? requestTime;
  final int? price;
  final String? status;
  final String? token;
  final String? url;

  PurchaseList({
    this.title,
    this.description,
    this.requestTime,
    this.price,
    this.status,
    this.token,
    this.url,
  });

  factory PurchaseList.fromJson(Map<String, dynamic> json) => PurchaseList(
        title: json["title"],
        description: json["description"],
        requestTime: json["requestTime"],
        price: json["price"],
        status: json["status"],
        token: json["token"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "requestTime": requestTime,
        "price": price,
        "status": status,
        "token": token,
        "url": url,
      };
}
