// To parse this JSON data, do
//
//     final categoryRequest = categoryRequestFromJson(jsonString);

import 'dart:convert';

CategoryRequest categoryRequestFromJson(String str) => CategoryRequest.fromJson(json.decode(str));

String categoryRequestToJson(CategoryRequest data) => json.encode(data.toJson());
class CategoryRequest {
  DataRequest? data;

  CategoryRequest({
    this.data,
  });

  factory CategoryRequest.fromJson(Map<String, dynamic> json) => CategoryRequest(
    data: json["data"] == null ? null : DataRequest.fromJson(json["data"]),
  );

  get products => null;

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class DataRequest {
  String? title;
  String? iconUrl;
  List<String>? products;

  DataRequest({
    this.title,
    this.iconUrl,
    this.products,
  });

  factory DataRequest.fromJson(Map<String, dynamic> json) => DataRequest(
    title: json["title"],
    iconUrl: json["iconUrl"],
    products: json["products"] == null ? [] : List<String>.from(json["products"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "iconUrl": iconUrl,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x)),
  };
}
