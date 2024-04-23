import 'dart:convert';

import 'package:ecommerce/Data/response/status.dart';
import 'package:ecommerce/Models/Request/product_request.dart';
import 'package:ecommerce/ViewModels/image_viewModel.dart';
import 'package:ecommerce/ViewModels/product_request_vm.dart';
import 'package:ecommerce/Views/Home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../Models/response/category.dart';
import '../../../Models/response/product.dart';
import '../../../ViewModels/category_vm.dart';
import '../Categories/home_brand.dart';

class AddProducts extends StatefulWidget {
  AddProducts({
    super.key,
    this.isFromUpdate,
    this.products,
  });
  bool? isFromUpdate;
  Datum? products;

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final _formKey = GlobalKey<FormState>();
  bool categorySelected = false;
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final rattingController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final createdAtController = TextEditingController();
  final updatedAdController = TextEditingController();
  final publishedAtController = TextEditingController();
  final _productRequestViewModel = ProductRequestViewModel();
  final _imageViewModel = ImageViewModel();
  final _categoryVM = CategoryViewModel();
  var imgFile;
  var productId;
  var imgId;
  var sizeBox = SizedBox(
    height: 15,
  );
  int? selectedCategoryId;
  var labelStyles = TextStyle(
    fontSize: 18,
  );
  @override
  void initState() {
    super.initState();
    _categoryVM.getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerScreen(),
      // drawer: AddProductToCategory(),
      appBar: AppBar(
        backgroundColor: Color(0xFF8dc1d0),
        title: Text('Add New Product'),
      ),
      backgroundColor: Colors.grey.shade400,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 15, right: 15, bottom: 15),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            // hintText: 'Product Name',
                            labelText: 'Product Name',
                            labelStyle: labelStyles,
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a product name';
                          }
                          return null;
                        },
                      ),
                      sizeBox,
                      TextFormField(
                        controller: priceController,
                        decoration: InputDecoration(
                            labelText: 'Product Price',
                            labelStyle: labelStyles,
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a product Price';
                          }
                          return null;
                        },
                      ),
                      sizeBox,
                      TextFormField(
                        controller: rattingController,
                        decoration: InputDecoration(
                            labelText: 'Ratting',
                            labelStyle: labelStyles,
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a product Ratting';
                          }
                          return null;
                        },
                      ),
                      sizeBox,
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                            labelText: 'Product Descriptions',
                            labelStyle: labelStyles,
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a product Descriptions';
                          }
                          return null;
                        },
                      ),
                      sizeBox,
                      TextFormField(
                        controller: quantityController,
                        decoration: InputDecoration(
                            labelText: 'Product qty',
                            labelStyle: labelStyles,
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a product qty';
                          }
                          return null;
                        },
                      ),
                      ChangeNotifierProvider(
                        create: (context) => _categoryVM,
                        child: Consumer<CategoryViewModel>(
                          builder: (context, viewModel, _) {
                            switch (viewModel.response.status!) {
                              case Status.LOADING:
                                // Show a loading indicator while data is being fetched
                                return const Center(
                                    child: CircularProgressIndicator());
                              case Status.COMPLETED:
                                // Show dropdown button when data is loaded
                                var categories =
                                    viewModel.response.data!.data ??
                                        []; // Update categories here
                                return DropdownButton<int>(
                                  value: selectedCategoryId,
                                  hint: Text(
                                    'Select a category',
                                    style: labelStyles,
                                  ),
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      selectedCategoryId = newValue;
                                    });
                                  },
                                  items: categories.map<DropdownMenuItem<int>>(
                                      (DatumCategory category) {
                                    return DropdownMenuItem<int>(
                                      value: category.id ?? 0,
                                      child: HomeBrand(
                                          category:
                                              category), // You might want to replace this with the actual category name
                                    );
                                  }).toList(),
                                );
                              case Status.ERROR:
                                // Show error message if data fetching fails
                                return Text(viewModel.response.message!);
                            }
                          },
                        ),
                      ),
                      sizeBox,
                      ChangeNotifierProvider(
                        create: (context) => _productRequestViewModel,
                        child: Consumer<ProductRequestViewModel>(
                          builder: (ctx, viewModel, _) {
                            if (viewModel.response.status == null) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _addNew();
                                  }
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
    var addProduct = ProductRequest(
        data: Data(
      title: titleController.text,
      rating: rattingController.text,
      description: descriptionController.text,
      quantity: quantityController.text,
      category: selectedCategoryId.toString(),
      thumbnail: imgId.toString(),
      price: priceController.text,
    ));
    _productRequestViewModel.postProducts(
      addProduct,
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
