
import 'package:ecommerce/Data/network/apiPag_service.dart';
import 'package:ecommerce/Data/network/api_service.dart';
import 'package:ecommerce/Models/Request/category_request.dart';
import 'package:ecommerce/Models/response/category.dart';
import 'package:ecommerce/Models/Request/product_request.dart';
import 'package:ecommerce/Models/response/product.dart';
import 'package:ecommerce/Res/url.dart';

class EcommerceRepository {
  var apiService = ApiService();
  var apiPageService =ApiServicePag();
  Future<Products> getAllProducts() async {
    try {
      dynamic response = await apiService.getApi(ClsUrl.getAllProductUrl);
      return productsFromJson(response);
    } catch (exception) {
      rethrow;
    }
  }

  Future<Products> getAllProductsPage({int page = 1, int pageSize = 25}) async {
    try {
      Map<String, String> queryParams = {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      };
      dynamic response = await apiPageService.getApiPag(ClsUrl.getAllProductUrl, queryParams: queryParams);
      print('API response: $response'); // Debug print
      if (response == null) {
        throw FetchDataException('Null response received');
      }
      return productsFromJson(response);
    } catch (exception) {
      print('Error: $exception'); // Debug print
      rethrow;
    }
  }

  Future<Categories> getAllCategories() async {
    try {
      var response = await apiService.getApi(ClsUrl.getAllCategoryUrl);
      return categoriesFromJson(response);
    } catch (exception) {
      rethrow;
    }
  }

  Future<dynamic> postProducts(data, {id}) async {
    print('restaurant id $id');

    var productRequest = productRequestToJson(data);
    // var url = isUpdate? '${ClsUrl.postProductUrl}/$id':ClsUrl.postProductUrl;
    // print('Posting ..........');
    var url = ClsUrl.postProductUrl;
    dynamic response = await apiService.postProduct(url, productRequest);
    return response;
  }

  Future<dynamic> postCategories(data, {id}) async {
    print('restaurant id $id');

    var categoryRequest = categoryRequestToJson(data);
    // var url = isUpdate? '${ClsUrl.postProductUrl}/$id':ClsUrl.postProductUrl;
    // print('Posting ..........');
    var url = ClsUrl.postCategoryUrl;
    dynamic response = await apiService.postCategory(url, categoryRequest);
    return response;
  }

  Future<dynamic> updateProducts(data, {isUpdate, id}) async {
    print('restaurant id $id');

    var productRequest = productRequestToJson(data);
    //var url = isUpdate? '${ClsUrl.postProductUrl}/$id':ClsUrl.postProductUrl;
    // print('Posting ..........');
    var url = '${ClsUrl.postProductUrl}/$id';
    dynamic response =
        await apiService.updateProduct(url, productRequest, isUpdate);
    return response;
  }

  Future<dynamic> deleteProducts(id) async {
    if (id == null) {
      print('Product ID is null. Cannot delete product.');
      return;
    }
    final url = 'https://cms.istad.co/api/e-commerce-products/$id';

    try {
      dynamic response = await apiService.deleteProduct(url);

      if (response.statusCode == 200) {
        // Product deleted successfully
        print('Product $id deleted successfully');
      } else {
        // Error occurred while deleting product
        print('Failed to delete product. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Exception occurred while making the HTTP request
      print('Error deleting product: $error');
    }
  }
}


