import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/image_description.dart';

class ImageService {
  final String _baseUrl = dotenv.env['BACKEND_URL'] ?? '';

  Future<ImageDescription> describeImage(File image) async {
    if (_baseUrl.isEmpty) {
      throw Exception('BACKEND_URL no está configurado en el .env');
    }

    final endpoint = '$_baseUrl/describe';

    final request = http.MultipartRequest('POST', Uri.parse(endpoint))
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Error en el servidor: ${response.statusCode}');
    }

    final respStr = await response.stream.bytesToString();
    final jsonResp = json.decode(respStr);

    return ImageDescription.fromJson(jsonResp);
  }
}
