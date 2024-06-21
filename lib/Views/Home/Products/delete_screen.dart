import 'package:ecommerce/ViewModels/product_request_vm.dart';
import 'package:ecommerce/Views/Home/Products/delete_product.dart';
import 'package:ecommerce/Views/Home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Data/response/status.dart';
import '../../../ViewModels/product_vm.dart';
import '../../Skeleton/skeleton.dart';

class DeleteScreen extends StatefulWidget {
  DeleteScreen({super.key});

  @override
  State<DeleteScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<DeleteScreen> {
  final _productViewModel = ProductViewModel();
  final _productRequestViewModel = ProductRequestViewModel();

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
        title: Text('Delete Product'),
        backgroundColor: Color(0xFF8dc1d0),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(10),
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
                      itemCount: viewModel.response.data?.data?.length,
                      itemBuilder: (context, index) => ProductCardSkeleton());
                case Status.COMPLETED:
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 350),
                      itemCount: viewModel.response.data?.data?.length,
                      itemBuilder: (context, index) {
                        var product = viewModel.response.data!.data?[index];
                        return DeleteProduct(product: product);
                      });

                case Status.ERROR:
                  return Text('Error');
              }
            },
          ),
        ),
      ),
    );
  }
}
