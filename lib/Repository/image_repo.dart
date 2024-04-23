import 'package:ecommerce/Data/network/api_service.dart';
import 'package:ecommerce/Models/response/image_response.dart';
import 'package:ecommerce/Res/url.dart';

class ImageRepository {
  final _apiService = ApiService();

  Future<List<ImageResponse>> uploadImages(image) async {
    var response = await _apiService.uploadImage(image, ClsUrl.uploadPhotoUrl);
    return imageResponseFromJson(response);
  }
}