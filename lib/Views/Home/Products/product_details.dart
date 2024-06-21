import 'package:ecommerce/Views/Home/Order/add_to_card_screen.dart';
import 'package:ecommerce/Views/Home/Order/order_screen.dart';
import 'package:ecommerce/Views/Home/drawer.dart';
import 'package:flutter/material.dart';
import '../../../Models/response/product.dart';
import '../../../ViewModels/product_vm.dart';

class ProductDetails extends StatefulWidget {
  Datum? product;

  ProductDetails({Key? key, this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool descTextShowFlag = false;
  final _productViewModel = ProductViewModel();
  @override
  void initState() {
    super.initState();
    _productViewModel.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    String stars = 'N/A';
    try {
      int ratingValue = int.parse(widget.product?.attributes?.rating ?? '');
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
                  widget.product?.attributes?.thumbnail?.data?.attributes
                              ?.url !=
                          null
                      ? 'https://cms.istad.co${widget.product?.attributes?.thumbnail?.data?.attributes?.url}'
                      : 'https://ae01.alicdn.com/kf/S10b84bfb3201464e91764e1e2cd623841.jpg_640x640Q90.jpg_.webp',
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
                  widget.product?.attributes?.description ?? 'No Description',
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
                        builder: (context) => TotalPrice(),
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
          ],
        ),
      ),
    );
  }
}
