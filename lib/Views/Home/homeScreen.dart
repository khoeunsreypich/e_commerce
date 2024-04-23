import 'package:ecommerce/Data/response/status.dart';
import 'package:ecommerce/ViewModels/category_vm.dart';
import 'package:ecommerce/ViewModels/product_vm.dart';
import 'package:ecommerce/Views/Home/Categories/display_cate.dart';
import 'package:ecommerce/Views/Home/Categories/product_by_category.dart';
import 'package:ecommerce/Views/Home/Products/product_details.dart';
import 'package:ecommerce/Views/Home/Products/search.dart';
import 'package:ecommerce/Views/Home/Settings/settings.dart';
import 'package:ecommerce/Views/Skeleton/skeleton.dart';
import 'package:ecommerce/Views/Skeleton/skeleton_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'Categories/home_brand.dart';
import 'Products/home_product.dart';
import 'drawer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, this.id});
  int? id;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _productViewModel = ProductViewModel();
  final _categoryViewModel = CategoryViewModel();

//  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _productViewModel.getAllProduct();
    _categoryViewModel.getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      endDrawer: DrawerScreen(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search_outlined),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ));
        },
      ),
      backgroundColor: Colors.grey.shade200,
      //backgroundColor: globals.pageBackgroundColor,
      appBar: AppBar(
        title: Text('Shopping Now'),
        backgroundColor: Color(0xFF8dc1d0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 1,
              ),
              ImageSlideshow(
                width: double.infinity,
                height: 200,
                initialPage: 0,

                /// The color to paint the indicator.
                indicatorColor: Colors.blue,

                /// The color to paint behind th indicator.
                indicatorBackgroundColor: Colors.grey,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKPff5AlfjUolPzBsrnE2O2-QIttbUSomJ7I7Fkm5nOpGvpNEtviewCLv2EPxSHxvJiNU&usqp=CAU',
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://t4.ftcdn.net/jpg/05/39/99/67/360_F_539996737_T5gJEIEqsGUjMXhrLZt0lDLcrOWsSHlb.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://media.istockphoto.com/id/1131988037/photo/full-length-body-size-view-portrait-of-nice-attractive-trendy-cheerful-people-holding-in.jpg?s=612x612&w=0&k=20&c=ulTe20Yzelbd6FiHjrWaHg048waQ7WrVRLqwJP-fY4c=',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
                onPageChanged: (value) {
                  print('Page changed: $value');
                },
                autoPlayInterval: 3000,
                isLoop: true,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Choose Brand',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              SizedBox(
                height: 2,
              ),
              SizedBox(
                height: 120,
                // width: MediaQuery.of(context).size.width * .90,
                child: ChangeNotifierProvider(
                  create: (context) => _categoryViewModel,
                  child: Consumer<CategoryViewModel>(
                    builder: (context, viewModel, _) {
                      if (viewModel.response.status == null) {
                        return Image.network(
                          'https://www.shutterstock.com/image-vector/default-ui-image-placeholder-wireframes-600nw-1037719192.jpg',
                        );
                      }
                      switch (viewModel.response.status!) {
                        case Status.LOADING:
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: viewModel.response.data?.data?.length,
                              itemBuilder: (context, index) =>
                                  SkeletonCategory());
                        case Status.COMPLETED:
                          return CategoryListView();
                        case Status.ERROR:
                          return Text('Error');
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                'New Arrival ',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                //color: Colors.amberAccent,
                //height: 350,
                height: MediaQuery.of(context).size.height * .43,
                width: MediaQuery.of(context).size.width * .98,
                child: ChangeNotifierProvider(
                  create: (context) => _productViewModel,
                  child: Consumer<ProductViewModel>(
                    builder: (context, viewModel, _) {
                      switch (viewModel.response.status!) {
                        case Status.LOADING:
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: viewModel.response.data?.data?.length,
                              itemBuilder: (context, index) =>
                                  ProductCardSkeleton());
                        case Status.COMPLETED:
                          return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent: 300),
                              // itemCount: viewModel.response.data?.data?.length,
                              itemCount: viewModel.response.data?.data?.length,

                              // itemCount: 100,
                              itemBuilder: (context, index) {
                                var product =
                                    viewModel.response.data!.data?[index];
                                return InkWell(
                                  //     child: HomeProduct(products: product,),
                                  // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(products: product,),));},
                                  child: HomeProduct(
                                    products: product,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetails(
                                            product: product,
                                          ),
                                        ));
                                  },
                                  //onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));},
                                );
                              });

                        case Status.ERROR:
                          return Text('Error');
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
