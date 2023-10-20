import 'dart:developer';

import 'package:image_picker/image_picker.dart';

/// Recoge una imagen de la fuente especificada y devuelve su ruta.
/// Si no se selecciona una imagen, devuelve una cadena vacía.
Future<String> pickImage({ImageSource? source}) async {
  final picker = ImagePicker();
  late String path;

  try {
    final getImage = await picker.pickImage(source: source!);

    if (getImage != null) {
      path = getImage.path;
    } else {
      path = '';
    }
  } catch (e) {
    log("Error al seleccionar una imagen: $e");
    path = '';
  }

  return path;
}
