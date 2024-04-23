
import 'package:ecommerce/Data/response/api_response.dart';
import 'package:ecommerce/Models/response/product.dart';
import 'package:ecommerce/Repository/ecommerce_repo.dart';
import 'package:flutter/cupertino.dart';

import '../Models/Request/product_request.dart';

class ProductRequestViewModel extends ChangeNotifier{
  final _productRepo = EcommerceRepository();
  var deleteResponse = ApiResponse();
  //ApiResponse<ProductRequest> response = ApiResponse.loading();
  var response = ApiResponse();
  setProductList(response) {
    this.response = response;
    notifyListeners();
  }
  setDeleteResponse(response) {
    deleteResponse = response;
    notifyListeners();
  }

  Future<dynamic> postProducts(data,{id}) async {
   // print('Posting.....................');
    setProductList(ApiResponse.loading());
    await _productRepo.postProducts(data,id:id)
        .then((isPost) => setProductList(ApiResponse.completed(isPost)))
        .onError((error, stackTrace) => setProductList(ApiResponse.error(stackTrace.toString())));
  }

  Future<dynamic> updateProducts(data,{isUpdate,id}) async {
    // print('Posting.....................');
    setProductList(ApiResponse.loading());
    await _productRepo.updateProducts(data,isUpdate: isUpdate,id: id)
        .then((isPost) => setProductList(ApiResponse.completed(isPost)))
        .onError((error, stackTrace) => setProductList(ApiResponse.error(stackTrace.toString())));
  }
  Future<dynamic> deleteProduct(id) async{
    await _productRepo.deleteProducts(id)
        .then((data) => setDeleteResponse(ApiResponse.completed(data)))
        .onError((error, stackTrace) => setDeleteResponse(ApiResponse.error(stackTrace.toString())));
  }

}