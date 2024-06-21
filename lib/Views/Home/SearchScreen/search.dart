import 'package:ecommerce/Models/response/product.dart';
import 'package:ecommerce/ViewModels/product_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Data/response/api_response.dart';
import '../../../Data/response/status.dart';

class SearchProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductSearch(products: []),
    );
  }
}

class ProductSearch extends StatefulWidget {
  final List<Datum> products;

  ProductSearch({required this.products});

  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  late TextEditingController _controller;
  final _productViewModel = ProductViewModel();
  List<Datum> _products = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      _onSearchTextChanged(_controller.text);
    });
    _getProducts(); // Fetch products when the widget initializes
  }

  void _getProducts() async {
    // Fetch products and update _products list
    await _productViewModel.getAllProduct();
    setState(() {
      _products = _productViewModel.response.data?.data ?? [];
    });
  }

  void _onSearchTextChanged(String query) {
    if (query.isEmpty) {
      // Reset the product list to show all products if the search query is empty
      _productViewModel.setProductList(ApiResponse.completed(
        Products(data: widget.products),
      ));
    } else {
      // Filter products based on the search query
      final filteredProducts = _filterProducts(_products, query);
      _productViewModel.setProductList(ApiResponse.completed(
        Products(data: filteredProducts),
      ));
    }
  }

  List<Datum> _filterProducts(List<Datum> products, String query) {
    // Filter products whose titles or descriptions contain the query string
    return products
        .where((product) =>
            (product.attributes?.title
                    ?.toLowerCase()
                    .contains(query.toLowerCase()) ??
                false) ||
            (product.attributes?.description
                    ?.toLowerCase()
                    .contains(query.toLowerCase()) ??
                false))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          onChanged: _onSearchTextChanged,
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => _productViewModel,
        child: Consumer<ProductViewModel>(
          builder: (context, viewModel, _) {
            switch (viewModel.response.status!) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.COMPLETED:
                var filteredProducts = viewModel.response.data?.data ?? [];
                if (_controller.text.isEmpty) {
                  // Show all products when the search query is empty
                  return ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ListTile(
                        title: Text(product.attributes!.title!),
                        subtitle: Text(product.attributes!.description!),
                        leading: Image.network(
                          product.attributes?.thumbnail?.data?.attributes
                                      ?.url !=
                                  null
                              ? 'https://cms.istad.co${product.attributes?.thumbnail?.data?.attributes?.url}'
                              : 'https://i.pinimg.com/originals/d1/c4/db/d1c4db78a9ccb94c19f5958f50648ace.jpg',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                } else {
                  // Show search results or "No search results" message
                  return filteredProducts.isEmpty
                      ? Center(child: Text('No search results'))
                      : ListView.builder(
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return ListTile(
                              title: Text(product.attributes!.title!),
                              subtitle: Text(product.attributes!.description!),
                              leading: Image.network(
                                product.attributes?.thumbnail?.data?.attributes
                                            ?.url !=
                                        null
                                    ? 'https://cms.istad.co${product.attributes?.thumbnail?.data?.attributes?.url}'
                                    : 'https://i.pinimg.com/originals/d1/c4/db/d1c4db78a9ccb94c19f5958f50648ace.jpg',
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                }
              case Status.ERROR:
                return Center(child: Text('Error'));
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
