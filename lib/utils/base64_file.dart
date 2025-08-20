import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Base64Example(),
    );
  }
}

class Base64Example extends StatefulWidget {
  const Base64Example({super.key});

  @override
  State<Base64Example> createState() => _Base64ExampleState();
}

class _Base64ExampleState extends State<Base64Example> {
  String? base64String;
  File? outputFile;

  @override
  void initState() {
    super.initState();
    convertExample();
  }

  Future<void> convertExample() async {
    // Step 1: Load a sample file (you can use FilePicker or ImagePicker instead)
    final dir = await getTemporaryDirectory();
    final sampleFile = File('${dir.path}/sample.txt');
    await sampleFile.writeAsString('Hello, this is a sample file.');

    // Step 2: Convert file to base64
    final encoded = await fileToBase64(sampleFile);

    // Step 3: Convert base64 back to file
    final decodedFile = await base64ToFile(encoded, '${dir.path}/restored.txt');

    setState(() {
      base64String = encoded;
      outputFile = decodedFile;
    });
  }

  /// 🔁 File to Base64
  Future<String> fileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  /// 🔁 Base64 to File
  Future<File> base64ToFile(String base64Str, String outputPath) async {
    final bytes = base64Decode(base64Str);
    final file = File(outputPath);
    return await file.writeAsBytes(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File ↔️ Base64 Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: base64String == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("✅ Base64 String (shortened):"),
              Text(base64String!.substring(0, 100) + '...'),
              const SizedBox(height: 20),
              Text("📁 Restored File Path: ${outputFile?.path}"),
            ],
          ),
        ),
      ),
    );
  }
}
