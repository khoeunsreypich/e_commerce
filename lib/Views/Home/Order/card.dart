import 'package:ecommerce/Models/response/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPro extends StatefulWidget {
 CartPro({super.key,this.product});
 Datum? product;

  @override
  State<CartPro> createState() => _CartProState();
}

class _CartProState extends State<CartPro> {
  int _quantity = 0;
  @override
  Widget build(BuildContext context) {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(height: 1),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    // child: Image.network('https://t3.ftcdn.net/jpg/02/86/68/80/240_F_286688069_n7HH5pKqK49Dfm3KvAlKGs0AD4HbrFlV.jpg',
                    //   height: 105,width: 180,),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network('https://cms.istad.co${widget.product?.attributes?.thumbnail?.data?.attributes?.url}',
                        height: 100,width: 100,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [  SizedBox(height: 2),
                        SizedBox(
                          width: 120,
                          child: Text(
                            '\$${widget.product?.attributes?.title}',
                            // 'Dress',
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          '\$${widget.product?.attributes?.price}',
                          // '15\$',
                          style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.w500),
                        ),],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Container(
                      height: 30,
                      width: 66,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: ElevatedButton(
                          style:  ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding:EdgeInsets.only(left: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50), // Set your desired border radius here
                            ),
                          ),
                          onPressed: _quantity > 0 ? () => _removeFromCart() : null,
                          child: Icon(Icons.remove_circle_outline,size: 30,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    '$_quantity',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 16),
                  Container(
                    height: 30,
                    width: 46,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15,),
                      child: ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.only(left: 1,),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Set your desired border radius here
                          ),
                        ),
                        onPressed: () => _addToCart(),
                        child: Icon(Icons.add_circle_outline,size: 30,),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        SizedBox(height: 16),
        // ElevatedButton(
        //   onPressed: () {
        //     // Add logic to add the current product to the cart
        //   },
        //   child: Text('Add to Cart'),
        // ),
      ],
    );
  }
  void _addToCart() {
    setState(() {
      _quantity++;
    });
  }

  void _removeFromCart() {
    setState(() {
      _quantity--;
    });
  }
}


