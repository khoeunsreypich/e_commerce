import 'package:ecommerce/Views/Home/Add_Pro_to_cat/add_Pro_toCate.dart';
import 'package:ecommerce/Views/Home/Categories/display_cate.dart';
import 'package:ecommerce/Views/Home/Products/update.dart';
import 'package:ecommerce/Views/Home/drawer.dart';
import 'package:flutter/material.dart';
import '../Categories/add_category.dart';
import '../Products/add_products.dart';
import '../Products/delete_screen.dart';

class Settings extends StatelessWidget {
   Settings({super.key});
var borderRadius =  BorderRadius.circular(10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerScreen(),
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Color(0xFF8dc1d0),
        title: Text('Setting'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8,right: 8,top: 100),
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 100,left: 15,right: 15),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color:Color(0xFF8dc1d0),
                      borderRadius: borderRadius
                    ),
                    child: ListTile(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddProducts(),),);},
                      leading: Icon(Icons.add_circle,color: Colors.blue,size: 35,),
                      title: Text('Add New Product',style: TextStyle(fontSize: 20,color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                        color:Color(0xFF8dc1d0),
                        borderRadius: borderRadius
                    ),
                    child: ListTile(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategory(),),);},
                      leading: Icon(Icons.add_circle_outline,color: Colors.blue,size: 35,),
                      title: Text('Add New Category',style: TextStyle(fontSize: 20,color: Colors.white),),

                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                        color:Color(0xFF8dc1d0),
                        borderRadius: borderRadius
                    ),
                    child: ListTile(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen(),),);},
                      leading: Icon(Icons.update_sharp,color: Colors.orange,size: 30,),
                      title: Text('Update Product',style: TextStyle(fontSize: 20,color: Colors.white),),

                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                        color:Color(0xFF8dc1d0),
                        borderRadius: borderRadius
                    ),
                    child: ListTile(
                     onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteScreen(),),);},
                      leading: Icon(Icons.delete,color: Colors.red,size: 35,),
                      title: Text('Delete Product',style: TextStyle(fontSize: 20,color: Colors.white),),

                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
