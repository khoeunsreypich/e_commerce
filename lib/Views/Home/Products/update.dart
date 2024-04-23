import 'package:ecommerce/Views/Home/Products/home_product.dart';
import 'package:ecommerce/Views/Home/Products/update_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Data/response/status.dart';
import '../../../ViewModels/product_vm.dart';
import '../../Skeleton/skeleton.dart';
import '../drawer.dart';

class UpdateScreen extends StatefulWidget {
  UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _productViewModel = ProductViewModel();

  @override
  void initState() {
    super.initState();
    _productViewModel.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerScreen(),
      appBar: AppBar(
        title: Text('Update Product'),
        backgroundColor: Color(0xFF8dc1d0),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          //color: Colors.amberAccent,
          //height: 350,
          height: MediaQuery.of(context).size.height * .98,
          width: MediaQuery.of(context).size.width * .98,
          child: ChangeNotifierProvider(
            create: (context) => _productViewModel,
            child: Consumer<ProductViewModel>(
              builder: (context, viewModel, _) {
                switch (viewModel.response.status!) {
                  case Status.LOADING:
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: 20,
                        itemBuilder: (context, index) => ProductCardSkeleton());
                  case Status.COMPLETED:
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 300),
                        itemCount: viewModel.response.data?.data?.length,
                        itemBuilder: (context, index) {
                          var product = viewModel.response.data!.data?[index];
                          return InkWell(
                            child: HomeProduct(
                              products: product,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateProduct(
                                      isFromUpdate: true,
                                      products: product,
                                    ),
                                  ));
                            },
                          );
                        });

                  case Status.ERROR:
                    return Text('Error');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
