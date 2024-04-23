import 'package:ecommerce/Views/Home/Order/add_to_card_screen.dart';
import 'package:ecommerce/Views/Home/Products/product_details.dart';
import 'package:ecommerce/Views/Home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Data/response/status.dart';
import '../../../Models/response/search.dart';
import '../../../ViewModels/product_vm.dart';
import '../../Skeleton/skeleton.dart';
import '../Order/order_screen.dart';
import 'home_product.dart';

class DetailScreen extends StatefulWidget {
  final Datum product;

  DetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _productViewModel = ProductViewModel();
  bool descTextShowFlag = false;
  @override
  void initState() {
    super.initState();
    _productViewModel.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    String stars = 'N/A';
    try {
      int ratingValue = int.parse(widget.product.attributes?.rating ?? '');
      stars = '⭐️' * ratingValue;
    } catch (e) {
      stars = 'N/A';
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      endDrawer: DrawerScreen(),
      appBar: AppBar(
        backgroundColor: Color(0xFF8dc1d0),
        title: Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 500,
              width: 400,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.product.attributes?.thumbnail?.data?.attributes?.url !=
                          null
                      ? 'https://cms.istad.co${widget.product.attributes?.thumbnail?.data?.attributes?.url}'
                      : 'https://i.pinimg.com/originals/d1/c4/db/d1c4db78a9ccb94c19f5958f50648ace.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product?.attributes?.title ?? 'No Title',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  maxLines: 1,
                ),
                SizedBox(height: 8),
                Text(
                  'Price: \$${double.tryParse(widget.product?.attributes!.price ?? "")?.toStringAsFixed(2) ?? "N/A"}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Rating: ${widget.product?.attributes?.rating != null ? stars : "N/A"}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.attributes?.description ?? 'No Description',
                  maxLines: descTextShowFlag ? 15 : 2,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                setState(() {
                  descTextShowFlag = !descTextShowFlag;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  descTextShowFlag
                      ? Text(
                          'Show Less',
                          style: TextStyle(color: Colors.blue),
                        )
                      : Text(
                          'Read More',
                          style: TextStyle(color: Colors.blue),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 270),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddToCard(),
                      ));
                },
                child: Text(
                  'Order Now',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8dc1d0)),
              ),
            ),
            // SizedBox(
            //   //color: Colors.amberAccent,
            //   //height: 350,
            //   height: MediaQuery.of(context).size.height*.43,
            //   width: MediaQuery.of(context).size.width * .98,
            //   child: ChangeNotifierProvider(
            //     create: (context) => _productViewModel,
            //     child: Consumer<ProductViewModel>(
            //       builder: (context,viewModel,_){
            //         switch(viewModel.response.status!){
            //           case Status.LOADING:
            //             return GridView.builder(
            //                 gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            //                   crossAxisCount: 2,
            //                 ),
            //                 itemCount: viewModel.response.data?.data?.length,
            //                 itemBuilder: (context,index) => ProductCardSkeleton());
            //           case Status.COMPLETED:
            //
            //             return GridView.builder(
            //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //                     crossAxisCount: 2,
            //                     mainAxisSpacing: 10,
            //                     mainAxisExtent: 300
            //                 ),
            //                 // itemCount: viewModel.response.data?.data?.length,
            //                 itemCount: viewModel.response.data?.data?.length ,
            //
            //                 // itemCount: 100,
            //                 itemBuilder: ( context, index) {
            //                   var product = viewModel.response.data!.data?[index];
            //                   return InkWell(
            //                     //     child: HomeProduct(products: product,),
            //                     // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(products: product,),));},
            //                     child: HomeProduct(products: product,),
            //                     onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(product: product,),));},
            //                     //onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));},
            //                   );
            //                 }
            //             );
            //
            //           case Status.ERROR:
            //             return Text('Error');
            //         }
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
