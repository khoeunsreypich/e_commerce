import 'package:ecommerce/Views/Home/Order/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/ViewModels/product_vm.dart';
import '../../../Data/response/status.dart';
import '../../../Models/response/product.dart';

class TotalPrice extends StatefulWidget {
  TotalPrice({Key? key, this.product}) : super(key: key);
  final Datum? product;

  @override
  State<TotalPrice> createState() => _TotalPriceState();
}

class _TotalPriceState extends State<TotalPrice> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Total Price Calculator',
      home: TotalPriceScreen(),
    );
  }
}

class TotalPriceScreen extends StatefulWidget {
  @override
  _TotalPriceScreenState createState() => _TotalPriceScreenState();
}

class _TotalPriceScreenState extends State<TotalPriceScreen> {
  final proVMD = ProductViewModel();

  Map<Datum, int> selectedItems = {};

  void _updateQuantity(Datum item, int quantity) {
    setState(() {
      if (quantity == 0) {
        selectedItems.remove(item);
      } else {
        selectedItems[item] = quantity;
      }
    });
  }

  double _calculateTotalPrice() {
    double totalPrice = 0.0;
    selectedItems.forEach((item, quantity) {
      double price = double.parse(item.attributes!.price!); // Parse the price string to double
      totalPrice += price * quantity;
    });
    return totalPrice;
  }

  @override
  void initState() {
    super.initState();
    proVMD.getAllProduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total Price Calculator'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => proVMD,
        child: Consumer<ProductViewModel>(
          builder: (context, viewModel, _) {
            switch (viewModel.response.status!) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.COMPLETED:
                return ListView.builder(
                  itemBuilder: (context, index) {
                    var product = viewModel.response.data!.data?[index];
                    return ListTile(
                      leading:Image.network(
                        product?.attributes?.thumbnail?.data
                            ?.attributes?.url !=
                            null
                            ? 'https://cms.istad.co${product?.attributes?.thumbnail?.data?.attributes?.url}'
                            : 'https://i.pinimg.com/originals/d1/c4/db/d1c4db78a9ccb94c19f5958f50648ace.jpg',
                        fit: BoxFit.cover,
                      ),
                      title: Text(product!.attributes!.title ?? ''), // Use the actual property of your product
                      subtitle: Text('\$${product.attributes!.price ?? ''}',
                      style: TextStyle(color: Colors.red),), // Use the actual property of your product
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:20),
                            child: SizedBox(
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
                                  child: Icon(Icons.remove),
                                  onPressed: () {
                                    if (selectedItems.containsKey(product)) {
                                      _updateQuantity(product, selectedItems[product]! - 1);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Text(selectedItems.containsKey(product) ? selectedItems[product].toString() : '0',
                              style: TextStyle(fontSize: 18)),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: SizedBox(
                              height: 30,
                              width: 46,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: ElevatedButton(
                                  style:  ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding:EdgeInsets.only(left: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50), // Set your desired border radius here
                                    ),
                                  ),
                                  onPressed: () {
                                    _updateQuantity(product, selectedItems.containsKey(product) ? selectedItems[product]! + 1 : 1);
                                  }, child:  Icon(Icons.add),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: viewModel.response.data?.data?.length ?? 0,
                );
              case Status.ERROR:
                return Center(child: Text('Error fetching data'));
              default:
                return Center(child: Text('No data'));
            }
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              'Total Price: \$${_calculateTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: SizedBox(
                width: 130,
                child: ElevatedButton(
                    onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => CreditCard(),));},
                    child:Text('Pay Now')),
              ),
            )
          ],
        )
      ),
    );
  }
}
