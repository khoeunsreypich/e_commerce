import 'package:ecommerce/Data/response/status.dart';
import 'package:ecommerce/Models/Request/category_request.dart';
import 'package:ecommerce/ViewModels/category_request_vm.dart';
import 'package:ecommerce/ViewModels/image_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../Models/response/product.dart';

class AddCategory extends StatefulWidget {
  AddCategory({super.key, this.isFromUpdate, this.products});
  bool? isFromUpdate;
  DataRequest? products;

  @override
  State<AddCategory> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddCategory> {
  final titleController = TextEditingController();
  final iconUrlController = TextEditingController();
  final productController = Products();
  final _categoryRequestViewModel = CategoryRequestViewModel();
  final _imageViewModel = ImageViewModel();
  var imgFile;
  var productId;
  var imgId;
  var sizeBox = SizedBox(
    height: 15,
  );
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8dc1d0),
        title: Text('Add New Product'),
      ),
      backgroundColor: Colors.grey.shade400,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 15, right: 15, bottom: 15),
                  child: Column(
                    children: [
                      ChangeNotifierProvider(
                        create: (context) => _imageViewModel,
                        child: Consumer<ImageViewModel>(
                          builder: (ctx, viewModel, _) {
                            if (viewModel.response.status == null) {
                              return InkWell(
                                onTap: () {
                                  _getImageFromSource(source: 'gallery');
                                },
                                child: Image.network(
                                  'https://www.shutterstock.com/image-vector/default-ui-image-placeholder-wireframes-600nw-1037719192.jpg',
                                  fit: BoxFit.contain,
                                ),
                              );
                            }
                            switch (viewModel.response.status!) {
                              case Status.LOADING:
                                return const Center(
                                    child: CircularProgressIndicator());
                              case Status.COMPLETED:
                                //when upload success it's assign id tuk
                                imgId = viewModel.response.data[0].id;
                                //var categories = viewModel.response.data!.data![index];
                                return InkWell(
                                  onTap: () {
                                    _getImageFromSource(source: 'camera');
                                  },
                                  child: SizedBox(
                                    height: 350,
                                    width: 250,
                                    child: Image.network(
                                        'https://cms.istad.co${viewModel.response.data[0].url!}'),
                                  ),
                                );
                              case Status.ERROR:
                                return Text(viewModel.response.message!);
                            }
                          },
                        ),
                      ),
                      sizeBox,
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                            hintText: 'Category Name',
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a category name';
                          }
                          return null;
                        },
                      ),
                      sizeBox,
                      ChangeNotifierProvider(
                        create: (context) => _categoryRequestViewModel,
                        child: Consumer<CategoryRequestViewModel>(
                          builder: (ctx, viewModel, _) {
                            if (viewModel.response.status == null) {
                              return ElevatedButton(
                                onPressed: () {
                                  _addNew();
                                },
                                child: Text('Save'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF8dc1d0)),
                              );
                            }
                            switch (viewModel.response.status!) {
                              case Status.LOADING:
                                return const Center(
                                    child: CircularProgressIndicator());
                              case Status.COMPLETED:
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  ScaffoldMessenger.of(ctx).showSnackBar(
                                      const SnackBar(
                                          content: Text('Post Success')));
                                });
                                return ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate())
                                        _addNew();
                                    },
                                    child: Text('Save'));
                              case Status.ERROR:
                                return Text(viewModel.response.message!);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addNew() {
    var addCategory = CategoryRequest(
        data: DataRequest(
      title: titleController.text,
      iconUrl: imgId.toString(),
    ));
    _categoryRequestViewModel.postCategory(
      addCategory,
      id: productId,
    );
  }

  _getImageFromSource({source}) async {
    // print('picking image ');
    XFile? pickedFile = await ImagePicker().pickImage(
        source: source == "gallery" ? ImageSource.gallery : ImageSource.camera);
    if (pickedFile != null) {
      // uploading image to server
      _imageViewModel.uploadImage(pickedFile.path);
    }
  }
}
