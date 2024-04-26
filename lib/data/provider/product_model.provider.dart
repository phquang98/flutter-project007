import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:example_repo_layer/product_model/models/index.dart';

// TODO: add dio later
// ? write a wrapper class, Wrapper = Resource | ErrorResource instead here ?
// ? Handle error using placeholder data, good ???

/// Provides raw data translated directly from API CRUD SQL, ONLY use this in repository
///
/// The number of methods should equals to the number of public endpoints provided for the resource
class ProductModelProvider {
  Future<List<ProductModel>> getAll(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> tmpList = jsonDecode(response.body);
        List<ProductModel> resourceClt = [];

        for (dynamic element in tmpList) {
          if (element
              case {
                "productModelID": int _,
                "name": String _,
                "catalogDescription": String? _,
                "rowguid": String _,
                "modifiedDate": String _,
              } when element is Map<String, dynamic>) {
            ProductModel tmpRecord = ProductModel.fromJson(element);
            // NOTE: don't know how to cast List<dynamic> -> List<CustomType>, temp solution
            resourceClt = [...resourceClt, tmpRecord];
          }
        }
        return resourceClt;

        // // NOTE: this does not work for some reason ?
        // tmpList.map((element) {
        //   if (element
        //       case {
        //         "productModelID": int _,
        //         "name": String _,
        //         "catalogDescription": String? _,
        //         "rowguid": String _,
        //         "modifiedDate": String _,
        //       }) {
        //     ProductModel tmpRecord =
        //         ProductModel.fromJson(element as Map<String, dynamic>);
        //     // NOTE: don't know how to cast List<dynamic> -> List<CustomType>, temp solution
        //     resourceClt = [...resourceClt, tmpRecord];
        //     log("dmm: $tmpRecord");
        //     return tmpRecord;
        //   }
        // });
      }
      return [];
    } catch (err) {
      return [];
    }
  }

  Future<ProductModel> getOne(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // cast it to List first cause API returns as an arr
        List<dynamic> tmpList = jsonDecode(response.body);
        // getOne -> List.length == 1
        if (tmpList case [Object ele]) {
          final result = ProductModel.fromJson(ele as Map<String, dynamic>);
          return result;
        } else {
          final failedResult = {
            "productModelID": 0,
            "name": "Data is not a List with 1 element!",
            "rowguid": "",
            "modifiedDate": ""
          };
          return ProductModel.fromJson(failedResult);
        }
      } else {
        final failedResult = {
          "productModelID": -1,
          "name": "Status code is not 200!",
          "rowguid": "",
          "modifiedDate": ""
        };
        return ProductModel.fromJson(failedResult);
      }
    } catch (err) {
      final failedResult = {
        "productModelID": -2,
        "name": "$err",
        "rowguid": "",
        "modifiedDate": ""
      };
      return ProductModel.fromJson(failedResult);
    }
  }

  Future<int> postOne(String url, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return 0;
      }

      return -1;
    } catch (err) {
      return -1;
    }
  }

  // Future<int> putOne(String url, Map<String, dynamic> data) async {
  //   try {
  //     final response = await http.put(
  //       Uri.parse(url),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(data),
  //     );

  //     if (response.statusCode == 200) {
  //       return 0;
  //     }

  //     return -1;
  //   } catch (err) {
  //     return -1;
  //   }
  // }
}
