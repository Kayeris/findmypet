import 'dart:io';
import 'package:gcloud/storage.dart';
import "package:googleapis_auth/auth_io.dart" as auth;

import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

/*

to make it easy, you can call it like this 

    UploadHelper imageUrl =
              await UploadHelper.getImageUrl().whenComplete(() {
            print("do xyz");
          });
*/
class UploadHelper {
  final String downloadLink;
  final String name;
  UploadHelper(this.downloadLink, this.name);

  static Future<UploadHelper> getImageUrl() async {
    File _image;
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print("success ");
    } else {
      print('No image selected.');
    }

    String result = await rootBundle.loadString('assets/my-project.json');

    var credentials = new auth.ServiceAccountCredentials.fromJson(result);

    List<String> scopes = []..addAll(Storage.SCOPES);
    var client = await auth.clientViaServiceAccount(credentials, scopes);

    var storage = new Storage(client, 'findMyPet');
    final b = storage.bucket('pet_image_bucket');

    final stream = http.ByteStream(Stream.castFrom(_image.openRead()));
    final byte = await stream.toBytes();
    ObjectInfo r = await b.writeBytes(_image.path.split("/").last, byte);
    return UploadHelper(r.downloadLink.toString(), r.name);
  }
}
