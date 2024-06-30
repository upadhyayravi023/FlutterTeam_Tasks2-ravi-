import 'dart:async';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:collection/collection.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'gemini_service.dart';

class MessageService {
  final GeminiService _geminiService = GeminiService();

  Future<void> sendTextMessage({
    required ChatMessage chatMessage,
    required List<ChatMessage> messages,
    required Function(ChatMessage) setMessageState,
    required ChatUser currentUser,
    required ChatUser geminiUser,
  }) async {
    setMessageState(chatMessage);
    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        XFile? xFile = XFile(chatMessage.medias!.firstWhereOrNull((media) => media.type == MediaType.image)?.url ?? '');
        if (xFile != null) {
          images = [
            await xFile.readAsBytes(),
          ];
        }
      }
      final response = await _geminiService.generateContent(question, images);
      ChatMessage? responseMessage = messages.firstWhereOrNull(
        (message) => message.user == geminiUser,
      );
      if (responseMessage != null) {
        responseMessage = messages.removeAt(0);
        responseMessage.text = response;
        setMessageState(responseMessage);
      } else {
        responseMessage = ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: response,
        );
        setMessageState(responseMessage);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendImageMessage({
    required XFile file,
    required Function(ChatMessage) sendTextMessage,
    required ChatUser currentUser,
    required Function(ChatMessage) setMessageState,
  }) async {
    final chatMessage = ChatMessage(
      user: currentUser,
      createdAt: DateTime.now(),
      text: "Describe the above picture!",
      medias: [
        ChatMedia(
          url: file.path,
          fileName: "",
          type: MediaType.image,
        ),
      ],
    );
    sendTextMessage(chatMessage);
  }
}
