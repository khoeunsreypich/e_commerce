import 'package:ecommerce/Models/Request/product_request.dart';
import 'package:ecommerce/ViewModels/product_vm.dart';
import 'package:flutter/material.dart';
import '../../../Models/response/product.dart';
import 'package:http/http.dart' as http;
class DeleteProduct extends StatelessWidget {
  DeleteProduct( {super.key, this.product,this.products });
  Datum? product;
  Data? products;

  var productViewModel = ProductViewModel();

  @override
  Widget build(BuildContext context) {
    String stars = 'N/A';
    try {
      int ratingValue = int.parse(product?.attributes?.rating ?? '');
      stars = '⭐️' * ratingValue;
    } catch (e) {
      stars = 'N/A';
    }
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product?.attributes?.thumbnail?.data?.attributes?.url != null
                    ? 'https://cms.istad.co${product?.attributes?.thumbnail?.data?.attributes?.url}'
                    : 'https://t3.ftcdn.net/jpg/04/62/93/66/360_F_462936689_BpEEcxfgMuYPfTaIAOC1tCDurmsno7Sp.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            product?.attributes?.title ?? 'No Title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Price: \$${double.tryParse(product?.attributes!.price ?? "")?.toStringAsFixed(2) ?? "N/A"}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Rating: ${product?.attributes?.rating != null ? stars : "N/A"}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Change this to the desired color
            ),
            child: Text('Delete Product'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Product'),
          content: Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Call _deleteProduct with the product ID and the BuildContext
                _deleteProduct(product?.id, context);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(int? productId, BuildContext context) async {
    if (productId == null) {
      print('Product ID is null. Cannot delete product.');
      return;
    }

    Navigator.of(context).pop(); // Close the dialog
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Delete Success')));
    });
    try {
      await deleteProduct(productId);
      print('Product deleted successfully');
    } catch (error) {
      print('Error deleting product: $error');
    }
  }

  Future<void> deleteProduct(int? productId) async {
    if (productId == null) {
      print('Product ID is null. Cannot delete product.');
      return;
    }
    final url = 'https://cms.istad.co/api/e-commerce-products/$productId';

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        // Product deleted successfully
        print('Product $productId deleted successfully');
      } else {
        // Error occurred while deleting product
        print('Failed to delete product. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Exception occurred while making the HTTP request
      print('Error deleting product: $error');
    }
  }
}
