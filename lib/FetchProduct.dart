import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning/Api.dart';
import 'package:http/http.dart' as http;

// class ProductScreen extends StatefulWidget {
//   @override
//   _ProductScreenState createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
//   late Future<List<Product>> _products;

//   @override
//   void initState() {
//     super.initState();
//     _products = fetchProducts();
//   }

//   Future<List<Product>> fetchProducts() async {
//     final response = await http.get(Uri.parse('https://dummyjson.com/products'));
//     if (response.statusCode == 200) {
//       List<dynamic> json = jsonDecode(response.body)['products'];
//       return json.map((data) => Product.fromJson(data)).toList();
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Product List')),
//       body: FutureBuilder<List<Product>>(
//         future: _products,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No products found'));
//           } else {
//             final products = snapshot.data!;
//             return ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return Card(
//                   margin: EdgeInsets.all(8.0),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           product.title,
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 8),
//                         Image.network(
//                           product.thumbnail,
//                           height: 100,
//                           errorBuilder: (context, error, stackTrace) =>
//                               Icon(Icons.image_not_supported),
//                         ),
//                         SizedBox(height: 8),
//                         Text('Price: \$${product.price.toStringAsFixed(2)}'),
//                         Text('Category: ${product.category}'),
//                         Text('Stock: ${product.stock}'),
//                         Text('Availability: ${product.availabilityStatus}'),
//                         SizedBox(height: 8),
//                         Text(product.description),
//                         SizedBox(height: 16),
//                         Text(
//                           'Reviews:',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         for (var review in product.reviews)
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Rating: ${review.rating}'),
//                                 Text('Comment: ${review.comment}'),
//                                 Text(
//                                     'Reviewer: ${review.reviewerName} (${review.reviewerEmail})'),
//                               ],
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// https://dummyjson.com/products

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _products = fetchproduct();
  }

  Future<List<Product>> fetchproduct() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      List<dynamic> jsondata = jsonDecode(response.body)['products'];
      return jsondata.map((data) => Product.fromJson(data)).toList();
    } else {
      throw Exception("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Image.network(
                          product.thumbnail,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported),
                        ),
                        const SizedBox(height: 8),
                        Text('Price: \$${product.price.toStringAsFixed(2)}'),
                        Text('Category: ${product.category}'),
                        Text('Stock: ${product.stock}'),
                        Text('Availability: ${product.availabilityStatus}'),
                        const SizedBox(height: 8),
                        Text(product.description),
                        const SizedBox(height: 16),
                        const Text(
                          'Reviews:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        for (var review in product.reviews)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rating: ${review.rating}'),
                                Text('Comment: ${review.comment}'),
                                Text(
                                    'Reviewer: ${review.reviewerName} (${review.reviewerEmail})'),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
