import 'package:ecommerce/Data/response/status.dart';
import 'package:ecommerce/Models/Request/product_request.dart';
import 'package:ecommerce/Models/response/category.dart';
import 'package:ecommerce/ViewModels/category_vm.dart';
import 'package:ecommerce/ViewModels/image_viewModel.dart';
import 'package:ecommerce/ViewModels/product_request_vm.dart';
import 'package:ecommerce/Views/Home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../Models/response/product.dart';
import '../Categories/home_brand.dart';

class UpdateProduct extends StatefulWidget {
  UpdateProduct({super.key, this.isFromUpdate, this.products,this.category});
  bool? isFromUpdate;
  Datum? products;
  DatumCategory? category;

  @override
  State<UpdateProduct> createState() => _AddProductsState();
}

class _AddProductsState extends State<UpdateProduct> {
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
  var imgFile;
  var productId;
  var imgId;
  var sizeBox = SizedBox(
    height: 15,
  );
  var labelStyles = TextStyle(fontSize: 20, );
  final _categoryVM = CategoryViewModel();
  int? selectedCategoryId;
  @override
  void initState() {
    super.initState();
    checkIfFromUpdate();
    _categoryVM.getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerScreen(),
      appBar: AppBar(
        backgroundColor:Colors.blueGrey,
        title: Text('Update Product'),
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
                child: Column(
                  children: [
                    ChangeNotifierProvider(
                      create: (context) => _imageViewModel,
                      child: Consumer<ImageViewModel>(
                        builder: (ctx, viewModel, _) {
                          if (widget.isFromUpdate == null) {
                            return InkWell(
                              onTap: () {
                                _getImageFromSource(source: 'gallery');
                              },
                              child: Image.network(
                                widget.products!.attributes!.thumbnail!.data!.attributes!.url !=null?
                                'https://cms.istad.co${widget.products!.attributes!.thumbnail!.data!.attributes!.url!}'
                                :'https://t3.ftcdn.net/jpg/04/62/93/66/360_F_462936689_BpEEcxfgMuYPfTaIAOC1tCDurmsno7Sp.jpg',
                                fit: BoxFit.contain,
                              ),
                            );
                          }
                          if (viewModel.response.status == null) {
                            return InkWell(
                              onTap: () {
                                _getImageFromSource(source: 'gallery');
                              },

                              //
                              child: SizedBox(
                                height: 280,
                                width: 240,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(21),
                                  child: Image.network(
                                    'https://cms.istad.co${widget.products?.attributes?.thumbnail?.data?.attributes?.url}',
                                  //  'https://t3.ftcdn.net/jpg/04/62/93/66/360_F_462936689_BpEEcxfgMuYPfTaIAOC1tCDurmsno7Sp.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
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
                                  _getImageFromSource(source: 'gallery');
                                },
                                child: SizedBox(
                                  height: 350,
                                  width: 350,
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
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          labelText: 'Product Name',
                          labelStyle:labelStyles,
                          border: OutlineInputBorder()),
                    ),
                    sizeBox,
                    TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                          labelText: 'Product Price',
                          labelStyle:labelStyles,
                          border: OutlineInputBorder()),
                    ),
                    sizeBox,
                    TextField(
                      controller: rattingController,
                      decoration: InputDecoration(
                          labelText: 'Ratting',
                          labelStyle:labelStyles,
                          border: OutlineInputBorder()),
                    ),
                    sizeBox,
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                          labelText: 'Product Descriptions',
                          labelStyle:labelStyles,
                          border: OutlineInputBorder()),
                    ),
                    sizeBox,
                    TextField(
                      controller: quantityController,
                      decoration: InputDecoration(
                          labelText: 'Product qty',
                          labelStyle:labelStyles,
                          border: OutlineInputBorder()),
                    ),
                    ChangeNotifierProvider(
                      create: (context) => _categoryVM,
                      child: Consumer<CategoryViewModel>(
                        builder: (context, viewModel, _) {
                          switch (viewModel.response.status!) {
                            case Status.LOADING:
                            // Show a loading indicator while data is being fetched
                              return const Center(child: CircularProgressIndicator());
                            case Status.COMPLETED:
                            // Show dropdown button when data is loaded
                              var  categories = viewModel.response.data!.data ?? []; // Update categories here
                              return DropdownButton<int>(
                                value: selectedCategoryId,
                                hint: Text('Select a category',style: TextStyle(fontSize: 18)),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    selectedCategoryId = newValue;
                                  });
                                },
                                items: categories.map<DropdownMenuItem<int>>((DatumCategory category) {
                                  return DropdownMenuItem<int>(
                                    value: category.id ?? 0,
                                    child: HomeBrand(category:category ), // You might want to replace this with the actual category name
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
                                _addNew();
                              },
                              // child: widget.isFromUpdate != null
                              //     ? Text('Update')
                              //     : Text('Save'));
                              child: Text('Update'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF8dc1d0)),
                            );
                          }
                          switch (viewModel.response.status!) {
                            case Status.LOADING:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case Status.COMPLETED:
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ScaffoldMessenger.of(ctx).showSnackBar(
                                    const SnackBar(
                                        content: Text('Update Success')));
                              });
                              return ElevatedButton(
                                  onPressed: () {
                                    _addNew();
                                  },
                                  child: Text('Update'));
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
    _productRequestViewModel.updateProducts(addProduct,
        isUpdate: widget.isFromUpdate, id: productId);
  }

  _getImageFromSource({source}) async {
    // print('picking image ');
    XFile? pickedFile = await ImagePicker().pickImage(
        source: source == "gallery" ? ImageSource.gallery : ImageSource.camera);
    if (pickedFile != null) {
      // uploading image to server
      _imageViewModel.uploadImage(pickedFile.path);
      // setState(() {
      //   isPicked = true;
      //   imageFile = File(pickedFile.path);
      // });
      // print('Picked Image : ${File(pickedFile.path)}');
    }
  }

  void checkIfFromUpdate() {
    if (widget.isFromUpdate != null) {
      titleController.text = widget.products!.attributes!.title.toString();
      rattingController.text = widget.products!.attributes!.rating.toString();
      descriptionController.text =
          widget.products!.attributes!.description.toString();
      quantityController.text =
          widget.products!.attributes!.quantity.toString();
      priceController.text = widget.products!.attributes!.price.toString();
      productId = widget.products?.id;
      imgId = widget.products?.attributes?.thumbnail?.data?.id;
    }
  }
}
