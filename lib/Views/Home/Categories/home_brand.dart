import 'package:ecommerce/Models/response/category.dart';
import 'package:flutter/material.dart';

import '../../../Models/response/product.dart';

class HomeBrand extends StatefulWidget {
   HomeBrand({super.key,this.category,this.products});
  DatumCategory? category ;
   Datum? products;
  @override
  State<HomeBrand> createState() => _HomeBrandState();
}

class _HomeBrandState extends State<HomeBrand> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            decoration: BoxDecoration(
               color: Colors.white,
              // color: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(

                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white54,
                      ),
                      // child: SizedBox(
                      //   height: 100,
                      //   width: 50,
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(8),
                      //     child: Image.network(
                      //         '${widget.category?.attributes?.iconUrl}'),
                      //   ),
                      // )
                  ),
                  Padding(
                    padding:new  EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width:70,
                      child: Text(
                        '${widget.category?.attributes?.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500),

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
