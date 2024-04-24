import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:example_repo_layer/product_model/models/index.dart';

// TODO: add dio later
/// Provides raw data translated directly from API CRUD SQL, ONLY use this in repository
///
/// The number of methods should equals to the number of public endpoints provided for the resource
class ProductModelProvider {
  Future<ProductModel> getOne(String uri) async {
    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        // cast it to List first cause API returns as an arr
        List<dynamic> tmpList = jsonDecode(response.body);
        // getOne -> List.length == 1
        if (tmpList case [Object ele]) {
          final result = ProductModel.fromJson(ele as Map<String, dynamic>);
          return result;
        } else {
          throw Exception('Data is not a List with 1 element!');
        }
      } else {
        throw Exception('Status code is not 200!');
      }
    } catch (err) {
      log("Probably networking error: $err");
      rethrow;
    }
  }
}
