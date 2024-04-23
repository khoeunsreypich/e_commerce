import 'package:ecommerce/Data/response/status.dart';
import 'package:ecommerce/Models/response/product.dart';
import 'package:ecommerce/ViewModels/product_vm.dart';
import 'package:ecommerce/Views/Home/Order/card.dart';
import 'package:ecommerce/Views/Home/Order/order_screen.dart';
import 'package:ecommerce/Views/Home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCard extends StatefulWidget {
  AddToCard({Key? key, this.product}) : super(key: key);

  Datum? product;

  @override
  State<AddToCard> createState() => _AddToCardState();
}

class _AddToCardState extends State<AddToCard> {
  final _productMVD = ProductViewModel();
  @override
  void initState() {
    _productMVD.getAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 55,
        width: 150,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  15), // Set your desired border radius here
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderScreen(),
                ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Buy Now',
                style: TextStyle(fontSize: 18),
              ),
              Icon(
                Icons.add_shopping_cart,
                size: 30,
              ),
            ],
          ),
        ),
      ),
      endDrawer: DrawerScreen(),
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text('Add to Cart'),
        backgroundColor: Color(0xFF8dc1d0),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 5, right: 8),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .98,
          child: ChangeNotifierProvider(
            create: (context) => _productMVD,
            child: Consumer<ProductViewModel>(
              builder: (context, viewModel, _) {
                switch (viewModel.response.status!) {
                  case Status.LOADING:
                    return Center(child: CircularProgressIndicator());
                  case Status.COMPLETED:
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        var product = viewModel.response.data!.data?[index];
                        return CartPro(
                          product: product,
                        );
                      },
                      itemCount: viewModel.response.data?.data?.length,
                    );
                  case Status.ERROR:
                    return Text('No Data');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
