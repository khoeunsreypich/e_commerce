import 'package:ecommerce/ViewModels/product_vm.dart';
import 'package:flutter/material.dart';
import '../../../Models/response/product.dart';

class HomeProduct extends StatefulWidget {
  HomeProduct({
    super.key,
    this.products,
  });
  Datum? products;

  @override
  State<HomeProduct> createState() => _HomeProductState();
}

class _HomeProductState extends State<HomeProduct> {
  var productViewModel = ProductViewModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 300,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 240,
                  width: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.products?.attributes?.thumbnail?.data?.attributes
                                  ?.url !=
                              null
                          ? 'https://cms.istad.co${widget.products?.attributes?.thumbnail?.data?.attributes?.url}'
                          : 'https://ae01.alicdn.com/kf/S10b84bfb3201464e91764e1e2cd623841.jpg_640x640Q90.jpg_.webp',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 95,
                      child: Text(
                        '${widget.products!.attributes!.title!}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true, 
                      ),
                    ),
                    Text(
                      '\$${widget.products!.attributes!.price!}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18, left: 8),
                child: Row(
                  children: [
                    new IconTheme(
                      data: new IconThemeData(color: Colors.orange),
                      child: new Icon(
                        Icons.star,
                        size: 14,
                      ),
                    ),
                    new IconTheme(
                      data: new IconThemeData(color: Colors.orange),
                      child: new Icon(
                        Icons.star,
                        size: 14,
                      ),
                    ),
                    new IconTheme(
                      data: new IconThemeData(color: Colors.orange),
                      child: new Icon(
                        Icons.star,
                        size: 14,
                      ),
                    ),
                    new IconTheme(
                      data: new IconThemeData(color: Colors.orange),
                      child: new Icon(
                        Icons.star_border_outlined,
                        size: 14,
                      ),
                    ),
                    new IconTheme(
                      data: new IconThemeData(color: Colors.orange),
                      child: new Icon(
                        Icons.star_border_outlined,
                        size: 14,
                      ),
                    ),
                    Text(
                      '${widget.products!.attributes!.rating!}',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
