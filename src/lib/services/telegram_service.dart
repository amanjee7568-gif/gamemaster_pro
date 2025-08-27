import 'dart:convert';
import 'package:http/http.dart' as http;

class TelegramService {
  static const String _botToken = String.fromEnvironment('TELEGRAM_BOT_TOKEN');
  static const String _chatId = String.fromEnvironment('TELEGRAM_CHAT_ID');
  static const String _baseUrl = 'https://api.telegram.org/bot$_botToken';

  Future<void> sendMessage(String text) async {
    if (_botToken.isEmpty || _chatId.isEmpty) {
      throw Exception('Telegram bot token or chat ID not configured');
    }

    final url = Uri.parse('$_baseUrl/sendMessage');
    final body = {
      'chat_id': _chatId,
      'text': text,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send message to Telegram: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error sending message to Telegram: $e');
    }
  }

  Future<List<dynamic>> getMessages() async {
    if (_botToken.isEmpty || _chatId.isEmpty) {
      throw Exception('Telegram bot token or chat ID not configured');
    }

    final url = Uri.parse('$_baseUrl/getUpdates');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['result'] as List<dynamic>;
      } else {
        throw Exception(
            'Failed to fetch messages from Telegram: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching messages from Telegram: $e');
    }
  }
}
