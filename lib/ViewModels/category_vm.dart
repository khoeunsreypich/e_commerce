

import 'package:ecommerce/Data/response/api_response.dart';
import 'package:ecommerce/Models/response/category.dart';
import 'package:ecommerce/Repository/ecommerce_repo.dart';
import 'package:flutter/cupertino.dart';



class CategoryViewModel extends ChangeNotifier{
  final _categoryRepo = EcommerceRepository();
  ApiResponse<Categories> response = ApiResponse.loading();

  setProductList(response) {
    this.response = response;
    notifyListeners();
  }
  Future<dynamic> getAllCategory() async {
    await _categoryRepo.getAllCategories()
        .then((product) => setProductList(ApiResponse.completed(product)))
        .onError((error, stackTrace)
    => setProductList(ApiResponse.error(stackTrace.toString())));
  }


}