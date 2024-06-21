import 'package:ecommerce/Data/response/api_response.dart';
import 'package:ecommerce/Repository/ecommerce_repo.dart';
import 'package:flutter/cupertino.dart';
import '../Models/response/product.dart';

class ProductViewModel extends ChangeNotifier {
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
  // Inside your ProductViewModel

  Future<dynamic> getAllProductPage( {required int page, required int itemsPerPage}) async {
    await _productRepo
        .getAllProducts()
        .then((product) => setProductList(ApiResponse.completed(product)))
        .onError((error, stackTrace) =>
        setProductList(ApiResponse.error(stackTrace.toString())));
  }











}
