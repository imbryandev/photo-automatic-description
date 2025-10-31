import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_description_app/widgets/description_view.dart';
import 'package:image_picker/image_picker.dart';
import '../services/image_service.dart';
import '../widgets/image_preview.dart';
import '../widgets/loading_overlay.dart';
import '../models/image_description.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final ImageService _imageService = ImageService();
  String? _description;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _description = null;
      });
    }
  }

  Future<void> _analyzeImage() async {
    if (_selectedImage == null) return;

    setState(() => _isLoading = true);

    try {
      final ImageDescription result =
          await _imageService.describeImage(_selectedImage!);

      setState(() => _description = result.description);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error analizando la imagen: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('AI Image Describer 🌐'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ImagePreview(imageFile: _selectedImage),
                ),
                const SizedBox(height: 20),
                if (_description != null) DescriptionView(description: _description),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Seleccionar Imagen'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _analyzeImage,
                        icon: const Icon(Icons.cloud),
                        label: const Text('Analizar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_isLoading) const LoadingOverlay(),
      ],
    );
  }
}
