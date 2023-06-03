// ignore_for_file: constant_identifier_names, unused_field

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'products.dart';

class Services {
  static const ROOT = 'http://192.168.1.5/crud/api/products/';
  static const DELETE = 'http://192.168.1.5/crud/api/products/delete/';
  static const ADD = 'http://192.168.1.5/crud/api/products/store';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_PRODUCT_ACTION = 'ADD_PRODUCT';
  static const _UPDATE_PRODUCT_ACTION = 'UPDATE_PRODUCT';
  static const _DELETE_PRODUCT_ACTION = 'DELETE_PRODUCT';


  static Future<List<Product>> getProduct() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_ALL_ACTION;
      final response = await http.get(Uri.parse(ROOT));
      if (kDebugMode) {
        print('getProducts Response: ${response.body}');
      }
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (kDebugMode) {
        print(200 == response.statusCode);
      }
      if (200 == response.statusCode) {
        List<Product> list = parseResponse(response.body);
        if (kDebugMode) {
          print(list);
        }
        return list;
      } else {
        return <Product>[];
      }
    } catch (e) {
      return <Product>[];
    }
  }

  static List<Product> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    if (kDebugMode) {
      print(parsed);
    }
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }


  static Future<bool> addProduct(String name, String qty, String price, String description) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _ADD_PRODUCT_ACTION;
      map['name'] = name;
      map['qty'] = qty;
      map['price'] = price;
      map['description'] = description;
      final response = await http.post(Uri.parse(ADD), body: map);
      if (kDebugMode) {
        print('addProduct Response: ${response.body}');
      }
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  static Future<bool> updateProduct(String id, String name,
      String qty,String price, String description) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _UPDATE_PRODUCT_ACTION;
      map['id'] = id;
      map['name'] = name;
      map['qty'] = qty;
      map['price'] = price;
      map['description'] = description;
      final response = await http.put(Uri.parse(ROOT + id), body: map);
      if (kDebugMode) {
        print('updateProduct Response: ${response.body}');
      }
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  static Future<bool> deleteProduct(String id) async {
    try {
      final response = await http.delete(Uri.parse(DELETE + id));
      if (kDebugMode) {
        print('deleteProduct Response: ${response.body}');
      }
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}