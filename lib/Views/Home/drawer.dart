import 'package:ecommerce/Views/Home/Products/search.dart';
import 'package:ecommerce/Views/Home/Settings/settings.dart';
import 'package:ecommerce/Views/Home/homeScreen.dart';
import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
   DrawerScreen({super.key});
  var styleText =TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.w400);
  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Drawer(
            child: ListView(

              scrollDirection: Axis.vertical,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [


                        Color(0xFF8dc1d0),
                        Color(0xff6AD4DD),
                      ]
                    ),
                    //color: Color(0xFF8dc1d0),
                    //color: Color(0xffFFC0D9)
                  ),
                    currentAccountPicture: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU_7xOzl2JQiuJ7lMmrUc4HL0eCahsolVATw&s'),
                    ),
                    accountName: Text('Sreypich Khoeun',style: TextStyle(fontSize: 16),),
                    accountEmail: Text('khoeusreypich@gmail.com',style: TextStyle(fontSize: 16),)
                ),
                ListTile(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));},
                  leading: Icon(Icons.home_outlined,size: 30,color: Colors.blueGrey,),
                  title: Text('Home',style: styleText,),
                ),
                ListTile(
                  onTap: (){},
                  leading: Icon(Icons.shop_2_outlined,size: 30,color: Colors.blueGrey,),
                  title: Text('Shop',style: styleText),
                ),
                ListTile(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));},
                  leading: Icon(Icons.search_outlined,size: 30,color: Colors.blueGrey,),
                  title: Text('Search',style: styleText),
                ),
                ListTile(
                  onTap: (){},
                  leading: Icon(Icons.add_shopping_cart,size: 30,color: Colors.blueGrey,),
                  title: Text('My Card',style: styleText),
                ),
                ListTile(
                  onTap: (){},
                  leading: Icon(Icons.account_box,size: 30,color: Colors.blueGrey,),
                  title: Text('My Account',style: styleText),
                ),
                ListTile(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(),));},
                  leading: Icon(Icons.settings_outlined,size: 30,color: Colors.blueGrey,),
                  title: Text('Setting',style: styleText),
                ),
                ListTile(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: '')));},
                  leading: Icon(Icons.logout_outlined,size: 30,color: Colors.blueGrey,),
                  title: Text('Log Out',style: styleText),
                ),

              ],
            )
        ),
      );
  }
}
