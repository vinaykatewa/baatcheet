import 'package:baatcheet/features/home/domain/entities/channel.dart';

class ChatModel extends Channel {
  ChatModel({required super.channelName, required super.chat});

  factory ChatModel.fromJson(Map<String, dynamic> map) {
    return ChatModel(
      channelName: map['channelName'],
      chat: (map['chat'] as List<dynamic>)
          .map((chatJson) => Chat.fromJson(chatJson as Map<String, dynamic>))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'channelName': channelName,
      'chat': chat.map((chat) => chat.toJson()).toList(),
    };
  }

  ChatModel copyWith({
    String? channelName,
    List<Chat>? chat,
  }) {
    return ChatModel(
      channelName: channelName ?? this.channelName,
      chat: chat ?? this.chat,
    );
  }
}