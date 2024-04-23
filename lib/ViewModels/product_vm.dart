import 'package:ecommerce/Data/response/api_response.dart';
import 'package:ecommerce/Data/response/status.dart';
import 'package:ecommerce/Repository/ecommerce_repo.dart';
import 'package:flutter/cupertino.dart';

import '../Models/response/product.dart';

class ProductViewModel extends ChangeNotifier {
  int _currentPage = 1;
  List<Datum> _products = [];
  bool _isLoading = false;
  final _productRepo = EcommerceRepository();
  ApiResponse<Products> response = ApiResponse.loading();
  var deleteResponse = ApiResponse();
  setProductList(response) {
    this.response = response;
    notifyListeners();
  }

  Future<dynamic> getAllProduct() async {
    await _productRepo
        .getAllProducts()
        .then((product) => setProductList(ApiResponse.completed(product)))
        .onError((error, stackTrace) =>
            setProductList(ApiResponse.error(stackTrace.toString())));
  }

  Future<void> fetchNextPage() async {
    if (_isLoading) return;

    _isLoading = true;
    await _productRepo
        .getAllProductsPage(pageNumber: _currentPage)
        .then((product) => setProductList(ApiResponse.completed(product)))
        .onError((error, stackTrace) =>
            setProductList(ApiResponse.error(stackTrace.toString())));
    //final response = await api.fetchProducts(pageNumber: _currentPage);
    // final response = await _productRepo.getAllProductsPage(pageNumber: _currentPage);

    if (response.status == Status.COMPLETED) {
      _products.addAll(response.data!.data!);
      _currentPage++;
    }

    _isLoading = false;
    notifyListeners();
  }
}
