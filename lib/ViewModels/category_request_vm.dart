
import 'package:ecommerce/Models/Request/category_request.dart';
import 'package:flutter/cupertino.dart';
import '../Data/response/api_response.dart';
import '../Repository/ecommerce_repo.dart';

class CategoryRequestViewModel extends ChangeNotifier{
  final _categoryRepo = EcommerceRepository();
  //ApiResponse<CategoryRequest> response = ApiResponse.loading();
  var response = ApiResponse();
  setProductList(response) {
    this.response = response;
    notifyListeners();
  }
  Future<dynamic> postCategory(data,{id}) async {
    // print('Posting.....................');
    setProductList(ApiResponse.loading());
    await _categoryRepo.postCategories(data,id:id)
        .then((isPost) => setProductList(ApiResponse.completed(isPost)))
        .onError((error, stackTrace) => setProductList(ApiResponse.error(stackTrace.toString())));
  }

}