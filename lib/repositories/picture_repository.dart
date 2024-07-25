import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:surf_flutter_summer_school_24/models/picture.dart';

class PictureRepository {
  final String yaToken;
  final String yandexBaseUrl = "cloud-api.yandex.net";

  PictureRepository({required this.yaToken});

// ----------------------------------------------

  Future<List<Picture>> getPictures() async {
    final uri = Uri.https(
      yandexBaseUrl,
      "/v1/disk/resources",
      {
        "path": "photos",
        "fields":
            "_embedded.items.name,_embedded.items.sizes,_embedded.items.modified",
        "sort": "_embedded.items.name",
        "limit": "100",
      },
    );

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: "OAuth $yaToken",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;

      List<Picture> transformedData = [];

      for (var item in data['_embedded']['items']) {
        var originalUrl = item['sizes'].firstWhere(
            (size) => size['name'] == 'ORIGINAL',
            orElse: () => null);
        if (originalUrl != null) {
          transformedData.add(
            Picture.fromJson(
              {
                'title': item['name'],
                'url': originalUrl['url'],
                'date': item['modified'],
              },
            ),
          );
        }
      }
      return transformedData;
    } else {
      throw Exception('Failed to load JSON');
    }
  }

// ----------------------------------------------
  Future<void> uploadImageToYandexCloud() async {
    // Получаем изображение
    final picker = ImagePicker();
    final imageFromGallery =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageFromGallery == null) return;

    // ### Получаем ссылку для загрузки

    final name = imageFromGallery.name;

    final uri = Uri.https(
      yandexBaseUrl,
      'v1/disk/resources/upload',
      {
        "path": "photos/$name",
      },
    );

    /// Токен авторизации, можно получить по ссылке https://yandex.ru/dev/disk/poligon/ выполнив вход

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'OAuth $yaToken',
      },
    );

    final body = response.body;
    final json = jsonDecode(body);
    json as Map<String, dynamic>;
    final linkToUpload = json['href'] as String;

    // ### Загружаем файл на сервер

    final dio = Dio();
    final file = File(imageFromGallery.path);
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
    });
    dio.put(linkToUpload, data: formData);
  }

  Future<void> deleteImage(String name) async {
    final uri = Uri.https(
      yandexBaseUrl,
      "/v1/disk/resources",
      {
        "path": "photos/$name",
      },
    );

    await http.delete(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: "OAuth $yaToken",
      },
    );
  }
}
