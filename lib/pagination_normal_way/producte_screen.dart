import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List prodects = [];
  int skip = 0;
  int limit = 20;
  bool isLoadedMoor = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getProducts();
    _scrollController.addListener(() async {
      if (isLoadedMoor) return;
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoadedMoor = true;
        });

        skip = skip + limit;
        await getProducts();

        setState(() {
          isLoadedMoor = false;
        });
      }
    });
  }

  getProducts() async {
    var url =
        Uri.parse('https://dummyjson.com/products?limit=$limit&skip=$skip');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['products'] as List;

      setState(() {
        prodects.addAll(data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: ListView.builder(
        controller: _scrollController,
        itemCount: isLoadedMoor ? prodects.length + 1 : prodects.length,
        itemBuilder: (context, index) {
          if (index >= prodects.length) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    prodects[index]['thumbnail'],
                  ),
                ),
                title: Text(prodects[index]['title']),
                subtitle: Text(
                  prodects[index]['description'],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
