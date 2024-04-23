import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8dc1d0),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            children: [
              Card(
                elevation: 1,
                child: Lottie.asset('assets/LottieLogo1.json',
                  width: 500,
                  height: 300,
                  fit: BoxFit.fill,),
              ),
              Text('Order   Confirmed!',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30,fontFamily: "Poppins"),),
            ],
          ),
        ),
      ),
    );
  }
}
