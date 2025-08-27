import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAiService {
  static const String _apiKey = String.fromEnvironment('OPENAI_API_KEY');
  static const String _baseUrl = 'https://api.openai.com/v1/chat/completions';

  Future<String> generateResponse(String prompt) async {
    if (_apiKey.isEmpty) {
      throw Exception('OpenAI API key not configured');
    }

    final messages = [
      {
        'role': 'system',
        'content':
            'You are a helpful customer support assistant for a gaming platform. '
                'Answer questions about games, platform features, technical issues, and provide general assistance. '
                'Be friendly, concise, and accurate in your responses.'
      },
      {'role': 'user', 'content': prompt}
    ];

    final body = {
      'model': 'gpt-4o',
      'messages': messages,
      'max_tokens': 500,
      'temperature': 0.7,
    };

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else if (response.statusCode == 401) {
        throw Exception('Invalid OpenAI API key');
      } else if (response.statusCode == 429) {
        throw Exception('OpenAI API rate limit exceeded');
      } else {
        throw Exception('OpenAI API error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error generating response from OpenAI: $e');
    }
  }
}
