import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/image_description.dart';

class ImageService {
  // ⚠️ Cambia esta URL por la de tu backend desplegado
  final String _baseUrl = 'https://tu-backend.onrender.com/describe';

  Future<ImageDescription> describeImage(File image) async {
    final request = http.MultipartRequest('POST', Uri.parse(_baseUrl))
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
