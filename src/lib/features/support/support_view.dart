import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/support/support_cubit.dart';
import 'package:my_app/features/support/support_state.dart';
import 'package:my_app/shared/app_colors.dart';
import 'package:my_app/shared/text_style.dart';

class SupportView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SupportCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Support', style: heading2Style(context)),
          backgroundColor: kcSurfaceColor,
          elevation: 0,
        ),
        body: BlocConsumer<SupportCubit, SupportState>(
          listener: (context, state) {
            if (state is SupportError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: kcErrorColor,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    color: kcBackgroundColor,
                    child: ListView.builder(
                      itemCount: context.read<SupportCubit>().messages.length,
                      itemBuilder: (context, index) {
                        final message =
                            context.read<SupportCubit>().messages[index];
                        return _buildMessageBubble(message, context);
                      },
                    ),
                  ),
                ),
                if (state is SupportLoading)
                  const LinearProgressIndicator(
                    color: kcPrimaryColor,
                    backgroundColor: kcBackgroundColor,
                  ),
                _buildInputArea(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message message, BuildContext context) {
    final isUser = message.sender == MessageSender.user;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? kcPrimaryColor : kcSurfaceColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: bodyStyle(context).copyWith(
                  color: isUser ? Colors.white : kcPrimaryTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: kcSurfaceColor,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                hintStyle: bodyStyle(context).copyWith(
                  color: kcSecondaryTextColor,
                ),
                filled: true,
                fillColor: kcBackgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  context.read<SupportCubit>().sendMessage(value);
                  _controller.clear();
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: kcPrimaryColor),
            onPressed: () {
              if (_controller.text.trim().isNotEmpty) {
                context.read<SupportCubit>().sendMessage(_controller.text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final MessageSender sender;
  final DateTime timestamp;

  Message({
    required this.text,
    required this.sender,
    required this.timestamp,
  });
}

enum MessageSender { user, bot }
