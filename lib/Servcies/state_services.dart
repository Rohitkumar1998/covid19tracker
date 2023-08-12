import 'dart:convert';

import 'package:covid19tracker/Model/world_states_model.dart';
import 'package:covid19tracker/utilities/App.dart';
import 'package:http/http.dart' as http;

class StateServies {
  Future<WorldStatesModel> fetchWordStatesRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListAPi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.contriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
