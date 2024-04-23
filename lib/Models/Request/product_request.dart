// To parse this JSON data, do
//
//     final productRequest = productRequestFromJson(jsonString);

import 'dart:convert';

ProductRequest productRequestFromJson(String str) => ProductRequest.fromJson(json.decode(str));

String productRequestToJson(ProductRequest data) => json.encode(data.toJson());

class ProductRequest {
  Data? data;

  ProductRequest({
    this.data,
  });

  factory ProductRequest.fromJson(Map<String, dynamic> json) => ProductRequest(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? title;
  String? rating;
  String? description;
  String? quantity;
  String? category;
  String? thumbnail;
  String? price;

  Data({
    this.title,
    this.rating,
    this.description,
    this.quantity,
    this.category,
    this.thumbnail,
    this.price,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    rating: json["rating"],
    description: json["description"],
    quantity: json["quantity"],
    category: json["category"],
    thumbnail: json["thumbnail"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "rating": rating,
    "description": description,
    "quantity": quantity,
    "category": category,
    "thumbnail": thumbnail,
    "price": price,
  };
}
