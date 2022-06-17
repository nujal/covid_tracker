import 'dart:convert';

import 'package:covid_api/models/world_stats_model.dart';
import 'package:covid_api/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class StatsServices {
  Future<WorldStatsModel?> fetchWorldStatsRecords() async {
    try {
      final Response response = await get(Uri.parse(AppUrl.worldStatsApi));
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var data = jsonDecode(response.body);
        print(data);
        return WorldStatsModel.fromJson(data);
      } else {
        print('no data');
        return null;
      }

      //   // return WorldStatsModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> fetchCountriesList() async {
    var data;
    final Response response = await get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('error');
    }
  }
}
