import 'dart:convert';
import 'package:ecommerce/Views/Home/Products/product_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Models/response/product.dart';
import '../drawer.dart';

class ProductsPage extends StatelessWidget {
  final int categoryId;

  ProductsPage({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerScreen(),
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xFF8dc1d0),
        title: Text('View Product'),
      ),
      body: FutureBuilder(
        future: fetchProducts(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          } else {
            // Display product titles using ListView.builder
            List<Datum> products = snapshot.data!;
            return GridView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                String stars = 'N/A';
                try {
                  int ratingValue = int.parse(product.attributes?.rating ?? '');
                  stars = '⭐️' * ratingValue;
                } catch (e) {
                  stars = 'N/A';
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetails(product: product),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    margin: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 190,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              product.attributes?.thumbnail?.data?.attributes
                                          ?.url !=
                                      null
                                  ? 'https://cms.istad.co${product.attributes?.thumbnail?.data?.attributes?.url}'
                                  : 'https://ae01.alicdn.com/kf/S10b84bfb3201464e91764e1e2cd623841.jpg_640x640Q90.jpg_.webp',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 2, bottom: 2, left: 10, right: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      product.attributes?.title ?? 'No Title',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '\$${double.tryParse(product.attributes!.price ?? "")?.toStringAsFixed(2) ?? "15"}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                width: 180,
                                child: Text(
                                  '${product.attributes?.rating != null ? stars : "⭐⭐⭐⭐⭐"}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                product.attributes?.description ??
                                    'No Description',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 2, mainAxisExtent: 320),
            );
          }
        },
      ),
    );
  }

  Future<List<Datum>> fetchProducts(int categoryId) async {
    String url =
        'https://cms.istad.co/api/e-commerce-products?populate=%2A&filters%5Bcategory%5D=$categoryId';
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> productList = jsonResponse['data'];
      // Convert each product JSON to Datum object
      List<Datum> products =
          productList.map<Datum>((item) => Datum.fromJson(item)).toList();

      return products;
    } else {
      // If response status code is not 200, throw an exception
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}
