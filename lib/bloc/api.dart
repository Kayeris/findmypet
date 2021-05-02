import 'dart:convert';

import 'package:findmypet/bloc/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class API extends GetxController {
  List<ProfileModel> searchList = [];
  Future<void> search() async {
    String url =
        "https://us-central1-findmypet-312403.cloudfunctions.net/api/search";
    final response = await http.get(url);

    searchList = ((json.decode(response.body) as List)
        .map((i) => ProfileModel.fromJson(i))
        .toList());
    update();
  }

  Future<String> getTag(String end) async {
    String url = "https://petify-uo2evf6gfq-uc.a.run.app/petify?img=$end";
    final response = await http.get(url);

    print(response.body.toString());

    var res = json.decode(response.body);
    String animal = res["animal"][0];
    String prediction = res["prediction"][0];

    update();
    return "#" + animal + " #" + prediction;
  }

  Future<void> viewPost(String id) async {}
}
