import 'dart:convert';
import 'dart:io';

class Converter{
  static String convertIntoBase64(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    return base64Encode(imageBytes);
  }
}