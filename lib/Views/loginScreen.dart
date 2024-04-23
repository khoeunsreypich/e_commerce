import 'dart:io';

import 'package:ecommerce/Views/Home/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30,left: 8,right: 8),
      child: Container(
        height: MediaQuery.of(context).size.height*.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient:LinearGradient(
            colors:[
              Color(0xffF6F5F2),
              Color(0xffFFEFEF),
            ]
          ),
          color: Colors.white
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: Image.network('https://d1csarkz8obe9u.cloudfront.net/posterpreviews/fashion-boutique-circle-blue-pink-logo-design-template-94ff8fe643d8ed79a0436e92233fabee_screen.jpg?ts=1619134622',
              height: 150,
                width: 150,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: Text(
                'Welcome',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 31),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Please enter your data to continue',
                style: TextStyle(fontSize: 17),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 25, right: 12),
              child: TextField(
                obscureText: true,
                maxLength: 10,
                decoration: InputDecoration(
                    helperText: 'helper text',
                    border: OutlineInputBorder(
                      gapPadding: 7,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'Email',
                    suffixIcon: Icon(Icons.check_circle),
                    suffixText: '@gmail.com',
                    prefixIcon: Icon(Icons.mail),
                    //prefixText: '+855'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 50, right: 12),
              child: TextField(
                obscureText: true,
                maxLength: 10,
                decoration: InputDecoration(
                    helperText: 'helper text',
                    border: OutlineInputBorder(
                      gapPadding: 7,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'Password',
                    suffixIcon: Icon(Icons.check_circle),
                    prefixIcon: Icon(Icons.password),
                    //prefixText: '+855'
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 25,bottom: 10),
              child: Container(
                width: 300,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)
                ),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  HomeScreen()),);
                    },
                    style:  ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Set your desired border radius here
                      ),
                    ),
                    child: Text(
                      'Log in',
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 130,),
              child: Text('Forgot your password?',style: TextStyle(fontSize: 16,color: Colors.blue),),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 50,right: 50,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Don`t have account',style: TextStyle(fontSize: 16,),),
                 Text('Sign Up',style: TextStyle(fontSize: 19,color: Colors.blue,fontWeight: FontWeight.w500),),
               ],
                ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 100,right: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FaIcon(FontAwesomeIcons.google,color: Colors.yellow.shade900,size: 40,),
                  Icon(Icons.facebook_outlined,color: Colors.blue.shade400,size: 50,),
                  Icon(Icons.telegram_outlined,color: Colors.blue.shade400,size: 50,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
