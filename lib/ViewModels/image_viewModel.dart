import 'package:ecommerce/Data/response/api_response.dart';
import 'package:ecommerce/Repository/image_repo.dart';
import 'package:flutter/cupertino.dart';

class ImageViewModel extends ChangeNotifier{
  final _imageRepo = ImageRepository();
  ApiResponse<dynamic> response = ApiResponse();
  setImageData(response){
    this.response = response;
    notifyListeners();
  }
  Future<dynamic> uploadImage(image) async {
    setImageData(ApiResponse.loading());
    await _imageRepo.uploadImages(image)
    .then((images) => setImageData(ApiResponse.completed(images)))
    .onError((error, stackTrace) => setImageData(ApiResponse.error(stackTrace.toString())));
  }

}