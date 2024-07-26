import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:surf_flutter_summer_school_24/feature/gallery/models/picture.dart';

// ignore: unused_import
import "dart:developer" as devtools show log;

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

  Future<Picture> getUploadedPicture(String name) async {
    final uri = Uri.https(
      yandexBaseUrl,
      "/v1/disk/resources",
      {
        "path": "photos/$name",
        "fields": "name,sizes,modified",
      },
    );

    late Picture uploadedPicture;
    int attempts = 0;

    while (attempts < 5) {
      Future.delayed(const Duration(seconds: 1));
      try {
        final response = await http.get(
          uri,
          headers: {
            HttpHeaders.authorizationHeader: "OAuth $yaToken",
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body) as Map<String, dynamic>;

          var originalUrl = data['sizes'].firstWhere(
            (size) => size['name'] == 'ORIGINAL',
            orElse: () => null,
          );
          if (originalUrl != null) {
            uploadedPicture = Picture.fromJson(
              {
                'title': data['name'],
                'url': originalUrl['url'],
                'date': data['modified'],
              },
            );
            break;
          }
        } else {
          throw Exception('Failed to load JSON');
        }
      } catch (e) {
        attempts++;
      }
    }

    if (attempts == 5) {
      throw Exception('Failed to get uploaded picture after 5 attempts');
    }

    return uploadedPicture;
  }

// ----------------------------------------------
  Future<void> uploadImageToYandexCloud(
      EntityStateNotifier<List<Picture>> picturesState) async {
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

    List<Picture>? existingPics = picturesState.value.data;
    existingPics?.add(await getUploadedPicture(name));
    picturesState.content(existingPics!.toList());
  }

// -----------
  Future<void> deleteImage(
    String name,
    EntityStateNotifier<List<Picture>> picturesState,
  ) async {
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
    List<Picture>? existingPics = picturesState.value.data;
    existingPics?.removeWhere((element) => element.title == name);
    picturesState.content(existingPics!.toList());
  }
}
