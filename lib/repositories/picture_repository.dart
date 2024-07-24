import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:surf_flutter_summer_school_24/models/picture.dart';

class PictureRepository {
  final String apiUrl;

  PictureRepository({required this.apiUrl});

  Future<List<Picture>> fetchPictures() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Picture.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pictures');
    }
  }
}
