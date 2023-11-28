import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String?> getFilePath() async {
  Directory? downloadDirectory;
  try {
    downloadDirectory = await getDownloadsDirectory();
    downloadDirectory ??= await getApplicationDocumentsDirectory();
  } catch (err) {
    print("Cannot save file");
  }
  return downloadDirectory?.path;
}

Future<File> getLocalFile(String filename) async {
  final path = await getFilePath();
  return File('$path/$filename');
}

Future<File> writeString(String filename, String contents) async {
  final file = await getLocalFile(filename);
  return file.writeAsString(contents);
}