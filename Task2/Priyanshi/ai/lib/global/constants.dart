import 'package:flutter_dotenv/flutter_dotenv.dart';

final String apiUrl = dotenv.env['GEMINI_API_KEY'] ?? "";