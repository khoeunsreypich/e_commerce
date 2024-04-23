import 'package:ecommerce/Models/response/category.dart';
import 'package:ecommerce/Views/Home/Categories/product_by_category.dart';
import 'package:ecommerce/Views/Home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CategoryListView extends StatefulWidget {
  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  List<DatumCategory>? categories;
  int defaultValue = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String url = 'https://cms.istad.co/api/e-commerce-categories?populate=%2A';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final categoriesData = Categories.fromJson(jsonResponse);
      setState(() {
        categories = categoriesData.data;
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: categories == null
          ? Center(child: CircularProgressIndicator())
          : SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories!.length,
          itemBuilder: (BuildContext context, int index) {
            final categoryName = categories![index].attributes!.title;
            final iconUrl = categories![index].attributes!.iconUrl;
            return GestureDetector(
              onTap: () {
                final categoryId = categories![index].id ?? defaultValue;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsPage(categoryId: categoryId),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.network(
                          iconUrl != null && iconUrl.isNotEmpty
                              ? iconUrl
                              : 'https://pngfre.com/wp-content/uploads/Adidas-Logo-2.png',
                          fit: BoxFit.fill,
                          width: 60,
                          height: 50,
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8),
                          child: Text(categoryName ?? 'Unknown',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true),
                        ),
                        // Add more widgets for category details if needed
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

