import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:example_repo_layer/product_model/models/index.dart';

// TODO: add dio later

class ProductModelProvider {
  Future<ProductModel> getOne(String uri) async {
    // concerns about json-related errors rather than network-related errors -> put this outside
    final response = await http.get(Uri.parse(uri));

    try {
      if (response.statusCode == 200) {
        List<dynamic> tmpList = jsonDecode(
            response.body); // first cast it to List, cause BE returns as an arr
        final result = ProductModel.fromJson(tmpList as Map<String, dynamic>);
        return result;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Status code is not 200!');
      }
    } catch (err) {
      rethrow;
    }
  }
}
