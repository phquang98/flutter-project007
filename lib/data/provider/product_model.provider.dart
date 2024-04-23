import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:example_repo_layer/product_model/models/index.dart';

// TODO: add dio later

/// Provides raw data translated directly from API CRUD SQL, ONLY use this in repository
class ProductModelProvider {
  Future<ProductModel> getOne(String uri) async {
    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> tmpList = jsonDecode(
            response.body); // first cast it to List, cause BE returns as an arr
        // getOne -> list.length = 1
        final result =
            ProductModel.fromJson(tmpList[0] as Map<String, dynamic>);
        log("tell me why: ${result.name}");
        return result;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Status code is not 200!');
      }
    } catch (err) {
      log("Error: ${err}");
      rethrow;
    }
  }
}
