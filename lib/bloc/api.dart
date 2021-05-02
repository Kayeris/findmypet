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

  Future<void> viewPost(String id) async {}
}
