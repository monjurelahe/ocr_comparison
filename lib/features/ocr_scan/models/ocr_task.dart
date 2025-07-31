import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRTask extends StatefulWidget {
  const OCRTask({super.key});

  @override
  _OCRTaskState createState() => _OCRTaskState();
}

class _OCRTaskState extends State<OCRTask> {
  String _ocrResult = 'Scan result will appear here...';
  File? _selectedImage;

  Future<File?> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) return File(pickedFile.path);
    return null;
  }

  // Method 1: Full text using MLKit (standard method)
  Future<void> _useMLKitStandard() async {
    final imageFile = await _pickImage();
    if (imageFile == null) return;

    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();

    setState(() {
      _selectedImage = imageFile;
      _ocrResult = "[MLKit Full Result]\n\n${recognizedText.text}";
    });
  }

  /// Method 2: Extract only block-wise text
  Future<void> _useBlockWiseOCR() async {
    final imageFile = await _pickImage();
    if (imageFile == null) return;

    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();

    final buffer = StringBuffer();
    for (var block in recognizedText.blocks) {
      buffer.writeln(block.text);
    }

    setState(() {
      _selectedImage = imageFile;
      _ocrResult = "[Block-wise Result]\n\n${buffer.toString()}";
    });
  }

  /// Method 3: Extract only
  Future<void> _useFilteredLineOCR() async {
    final imageFile = await _pickImage();
    if (imageFile == null) return;

    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();

    final buffer = StringBuffer();
    for (var block in recognizedText.blocks) {
      for (var line in block.lines) {
        if (line.text.trim().length > 10) {
          buffer.writeln(line.text);
        }
      }
    }

    setState(() {
      _selectedImage = imageFile;
      _ocrResult = "[Filtered Line Result]\n\n${buffer.toString()}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OCR Scanner Page'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_selectedImage != null)
              Image.file(_selectedImage!, height: 200),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_ocrResult, style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _useMLKitStandard,
                    child: Text('MLKit Full'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _useBlockWiseOCR,
                    child: Text('Block-wise OCR'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _useFilteredLineOCR,
                    child: Text('Filtered OCR'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 21),
          ],
        ),
      ),
    );
  }
}
