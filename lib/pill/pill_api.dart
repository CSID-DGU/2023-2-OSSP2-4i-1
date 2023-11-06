import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yakmoya/pill/pill_model.dart';
import 'package:http/http.dart' as http;


class PillsAPI{
  static Future<List<Pill>> getPills(String query) async {
    final url = Uri.parse('https://~~~');

    final resp = await http.get(url);
    if(resp.statusCode == 200){
      final List pills = json.decode(resp.body);
      return pills.map((json) => Pill.fromJson(json)).toList();
    }else{
      throw Exception();
    }

  }

}