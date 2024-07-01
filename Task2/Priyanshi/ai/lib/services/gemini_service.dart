import 'dart:typed_data';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  final Gemini _gemini = Gemini.instance;

  Future<String> generateContent(String question, List<Uint8List>? images) async {
    try {
      final event = await _gemini.streamGenerateContent(
        question,
        images: images,
      ).first;
      return event.content?.parts?.fold(
        "", (previous, current) => "$previous ${current.text}",
      ) ?? "";
    } catch (e) {
      print(e);
      return "";
    }
  }
}
