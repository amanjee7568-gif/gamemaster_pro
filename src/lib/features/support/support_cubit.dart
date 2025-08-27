import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/support/support_state.dart';
import 'package:my_app/services/openai_service.dart';
import 'package:my_app/services/telegram_service.dart';

class SupportCubit extends Cubit<SupportState> {
  final List<Message> messages = [];
  final TelegramService _telegramService = TelegramService();
  final OpenAiService _openAiService = OpenAiService();

  SupportCubit() : super(SupportInitial());

  void sendMessage(String text) async {
    // Add user message to chat
    final userMessage = Message(
      text: text,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );
    messages.add(userMessage);
    emit(SupportLoading());

    try {
      // Send message to Telegram bot
      await _telegramService.sendMessage(text);

      // Get response from OpenAI
      final aiResponse = await _openAiService.generateResponse(text);

      // Add bot response to chat
      final botMessage = Message(
        text: aiResponse,
        sender: MessageSender.bot,
        timestamp: DateTime.now(),
      );
      messages.add(botMessage);

      emit(SupportLoaded());
    } catch (e) {
      emit(SupportError('Failed to get response. Please try again.'));
    }
  }
}
