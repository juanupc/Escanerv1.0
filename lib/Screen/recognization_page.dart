import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizePage extends StatefulWidget {
  final String? path;

  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.path != null) {
      final InputImage inputImage = InputImage.fromFilePath(widget.path!);
      processImage(inputImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Placa Encontrada")),
      body: _isBusy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Placa Encontrada:",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Placa...",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> processImage(InputImage image) async {
    try {
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

      setState(() {
        _isBusy = true;
      });

      log(image.filePath ?? "No se proporcionó una ruta de imagen.");

      final RecognizedText recognizedText = await textRecognizer.processImage(image);

      // Dividir el texto en líneas
      final lines = recognizedText.text.split('\n');

      // Tomar la primera línea
      final firstLine = lines.isNotEmpty ? lines[0] : '';

      // Usar una expresión regular para filtrar caracteres especiales
      final filteredText = firstLine.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

      controller.text = filteredText;
    } catch (e) {
      log("Error al procesar la imagen: $e");
    } finally {
      // Finalizar el estado ocupado
      setState(() {
        _isBusy = false;
      });
    }
  }
}
