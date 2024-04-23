import 'dart:convert';
import 'package:ecommerce/Views/Home/Products/search_detail.dart';
import 'package:ecommerce/Views/Home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../Models/response/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Title',
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  SearchProductModel? _searchResult;
  SearchProductModel searchProductModelFromJson(String str) =>
      SearchProductModel.fromJson(json.decode(str));
  String searchProductModelToJson(SearchProductModel data) =>
      json.encode(data.toJson());

  Future<void> _searchTitle(String query) async {
    // Make the HTTP request
    String url = 'https://cms.istad.co/api/e-commerce-products?populate=%2A';
    http.Response response = await http.get(Uri.parse(url));
    if (query.isEmpty) {
      // Display the message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please Enter Product Title To Search'),
      ));
      return; // Exit the method early
    }

    // Parse the response
    if (response.statusCode == 200) {
      // Decode the response JSON
      var jsonData = json.decode(response.body);
      // Filter products based on the query string
      List<Datum> filteredProducts = searchProducts(
          SearchProductModel.fromJson(jsonData).data ?? [], query);

      setState(() {
        // Update the search result with filtered products
        _searchResult = SearchProductModel(data: filteredProducts);
      });
    } else {
      throw Exception('Failed to load search results');
    }
  }

  List<Datum> searchProducts(List<Datum> products, String query) {
    // Filter products whose titles or descriptions contain the query string
    return products.where((product) =>
    (product.attributes?.title?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
        (product.attributes?.description?.toLowerCase().contains(query.toLowerCase()) ?? false)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerScreen(),
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xFF8dc1d0),
        title: Text('Product Search',style: TextStyle(fontWeight: FontWeight.w500),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search by title',
                      hintText: 'Enter product title...',
                    ),
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _searchTitle(_searchController.text);
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: _searchResult == null ||
                    _searchResult!.data == null ||
                    _searchResult!.data!.isEmpty
                ? Center(child: Text('No search results'))
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            mainAxisExtent: 300),
                    itemCount: _searchResult!.data!.length,
                    itemBuilder: (context, index) {
                      var product = _searchResult!.data![index];
                      String stars = 'N/A';
                      try {
                        int ratingValue =
                            int.parse(product.attributes?.rating ?? '');
                        stars = '⭐️' * ratingValue;
                      } catch (e) {
                        stars = 'N/A';
                      }
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(product: product),
                              ),
                            );
                          },
                          child: Container(
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(20)
                           ),
                            margin: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 180,
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        product.attributes?.thumbnail?.data
                                                    ?.attributes?.url !=
                                                null
                                            ? 'https://cms.istad.co${product.attributes?.thumbnail?.data?.attributes?.url}'
                                            : 'https://i.pinimg.com/originals/d1/c4/db/d1c4db78a9ccb94c19f5958f50648ace.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                             //fontWeight: FontWeight.bold,
                                             fontSize: 14,
                                             color: Colors.red
                                           ),
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
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
