import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonCategory extends StatelessWidget {
  const SkeletonCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        margin: EdgeInsets.only(left: 15),
        width: MediaQuery.of(context).size.width * .40,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * .40,
                  height: 55,
                )),

          ],
        ),
      ),
    );
  }
}
