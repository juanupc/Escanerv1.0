import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ocr/Screen/recognization_page.dart';

/// Recorta la imagen en `path` y devuelve la ruta de la imagen recortada.
/// Si no se recorta ninguna imagen, devuelve una cadena vacía.
Future<String> imageCropperView(String? path, BuildContext context) async {
  try {
    if (path == null) {
      log("Error: La ruta de la imagen es nula.");
      return '';
    }

    final croppedImageFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.original,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Imagen',
            toolbarColor: Colors.lightGreen,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Imagen',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    if (croppedImageFile != null) {
      log("Imagen recortada exitosamente");
      return croppedImageFile.path;
    } else {
      log("Ninguna imagen fue recortada");
      return '';
    }
  } catch (e) {
    log("Error al recortar la imagen: $e");
    return '';
  }
}
