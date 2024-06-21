import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({super.key});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Credit Card Example'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CreditCardWidget(
                    cardNumber: '4242 4242 4242 4242',
                    expiryDate: '04/24',
                    cardHolderName: 'Khoeun Sreypich',
                    cvvCode: '424',
                    showBackView: false,
                    onCreditCardWidgetChange: (CreditCardBrand brand) {},
                    bankName: 'VISA',
                    cardType: CardType.mastercard,
                  ),
                  CreditCardForm(
                    cardNumber: 'Khoeun Sreypich',
                    expiryDate: '10/12/14',
                    cardHolderName: '',
                    cvvCode: '101214122552',
                    onCreditCardModelChange: (CreditCardModel data) {},
                    formKey: GlobalKey<FormState>(),
                    obscureCvv: true,
                    obscureNumber: true,
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    enableCvv: true,
                    // cvvValidationMessage: 'Please input a valid CVV',
                    // dateValidationMessage: 'Please input a valid date',
                    // numberValidationMessage: 'Please input a valid number',
                    cardNumberValidator: (String? cardNumber) {},
                    expiryDateValidator: (String? expiryDate) {},
                    cvvValidator: (String? cvv) {},
                    cardHolderValidator: (String? cardHolderName) {},
                    onFormComplete: () {
                      // callback to execute at the end of filling card data
                    },
                    autovalidateMode: AutovalidateMode.always,
                    disableCardNumberAutoFillHints: false,
                    inputConfiguration: const InputConfiguration(
                      cardNumberDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        labelStyle: TextStyle(
                          color:
                              Colors.black, // Set your desired label text color
                          fontSize: 16, // Set your desired label font size
                          fontWeight: FontWeight
                              .w400, // Set your desired label font weight
                          // Add more label style properties as needed
                        ),
                      ),
                      expiryDateDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                        labelStyle: TextStyle(
                          color:
                              Colors.black, // Set your desired label text color
                          fontSize: 16, // Set your desired label font size
                          fontWeight: FontWeight
                              .w400, // Set your desired label font weight
                          // Add more label style properties as needed
                        ),
                      ),
                      cvvCodeDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                        labelStyle: TextStyle(
                          color:
                              Colors.black, // Set your desired label text color
                          fontSize: 16, // Set your desired label font size
                          fontWeight: FontWeight
                              .w400, // Set your desired label font weight
                          // Add more label style properties as needed
                        ),
                      ),
                      cardHolderDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card Holder',
                        hintText: 'XXX XXX',
                        labelStyle: TextStyle(
                          color:
                              Colors.black, // Set your desired label text color
                          fontSize: 16, // Set your desired label font size
                          fontWeight: FontWeight
                              .w400, // Set your desired label font weight
                          // Add more label style properties as needed
                        ),
                      ),
                      cardNumberTextStyle: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                      cardHolderTextStyle: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                      expiryDateTextStyle: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                      cvvCodeTextStyle: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 40),
                    child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child:ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text("Do you want to save now?"),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      // Add your save logic here
                                      // For example, you can await for saving process and then show success dialog
                                      await Future.delayed(Duration(seconds: 0)); // Simulating a delay of 2 seconds

                                      Navigator.of(context).pop(); // Close the alert dialog

                                      // Show success dialog
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Padding(
                                              padding: const EdgeInsets.only(top: 50),
                                              child: Image.asset('assets/image/checklist.png',height: 100,),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Close the success dialog
                                                },
                                                child: Text("OK"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text("Save"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: Text("Cancel"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          'Save Now',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
