import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Kopynator extends ChangeNotifier {
  final String apiKey;
  final String baseUrl;
  String _locale;
  Map<String, String> _translations = {};

  static Kopynator? _instance;

  Kopynator._({
    required this.apiKey,
    this.baseUrl = "https://api.kopynator.com",
    String locale = "en",
  }) : _locale = locale;

  static Kopynator initialize({
    required String apiKey,
    String locale = "en",
  }) {
    _instance ??= Kopynator._(apiKey: apiKey, locale: locale);
    return _instance!;
  }

  static Kopynator get instance {
    if (_instance == null) {
      throw Exception("Kopynator SDK: must call initialize() before use");
    }
    return _instance!;
  }

  String get locale => _locale;
  Map<String, String> get translations => _translations;

  void setLocale(String newLocale) {
    _locale = newLocale;
    notifyListeners();
  }

  String t(String key, {String? defaultValue}) {
    return _translations[key] ?? defaultValue ?? key;
  }

  Future<bool> fetchTranslations() async {
    try {
      final url = Uri.parse("$baseUrl/tokens/fetch?token=$apiKey&langs=$_locale");
      final response = await http.get(
        url,
        headers: {
          'x-kopynator-version': '1.2.0',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _translations = data.map((key, value) => MapEntry(key, value.toString()));
        notifyListeners();
        return true;
      }
    } catch (e) {
      // Internal logging or silent fail for production stability
    }
    return false;
  }
}
