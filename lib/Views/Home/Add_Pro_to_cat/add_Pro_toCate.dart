
import 'package:ecommerce/Models/response/category.dart';
import 'package:ecommerce/ViewModels/category_vm.dart';
import 'package:ecommerce/Views/Home/Categories/home_brand.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

import '../../../Data/response/status.dart';

// void main() {
//   runApp(AddProductToCategory());
// }

class AddProductToCategory extends StatefulWidget {
  const AddProductToCategory({super.key});

  @override
  State<AddProductToCategory> createState() => _AddProductToCategoryState();
}

class _AddProductToCategoryState extends State<AddProductToCategory> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Dropdown Example'),
        ),
        body: Center(
          child: CategoryDropdown(),
        ),
      ),
    );
  }
}

class CategoryDropdown extends StatefulWidget {
  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  int? selectedCategoryId;
  final _categoryVM = CategoryViewModel();

  @override
  void initState() {
    super.initState();
    _categoryVM.getAllCategory();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Consumer widget listens to changes in CategoryViewModel
          ChangeNotifierProvider(
            create: (context) => _categoryVM,
            child: Consumer<CategoryViewModel>(
              builder: (context, viewModel, _) {
                switch (viewModel.response.status!) {
                  case Status.LOADING:
                  // Show a loading indicator while data is being fetched
                    return const Center(child: CircularProgressIndicator());
                  case Status.COMPLETED:
                  // Show dropdown button when data is loaded
                  var  categories = viewModel.response.data!.data ?? []; // Update categories here
                    return DropdownButton<int>(
                      value: selectedCategoryId,
                      hint: Text('Select a category'),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedCategoryId = newValue;
                        });
                      },
                      items: categories.map<DropdownMenuItem<int>>((DatumCategory category) {
                        return DropdownMenuItem<int>(
                          value: category.id ?? 0,
                          child: HomeBrand(category:category ), // You might want to replace this with the actual category name
                        );
                      }).toList(),
                    );
                  case Status.ERROR:
                  // Show error message if data fetching fails
                    return Text(viewModel.response.message!);
                }
              },
            ),
          ),
          // Add some space between the dropdown and the text below
          SizedBox(height: 20),
          // Show the selected category ID if one is selected
          Text(selectedCategoryId != null ? 'Selected category ID: $selectedCategoryId' : ''),
        ],
      ),
    );

  }
}