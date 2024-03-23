class Channel {
  final String channelName;
  final List<Chat> chat;
  Channel({required this.channelName, required this.chat});
}

class Chat {
  final String senderUid;
  final String senderMessage;
  final String timeStamp;

  Chat(
      {required this.senderUid,
      required this.senderMessage,
      required this.timeStamp});
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      senderUid: json['senderUid'],
      senderMessage: json['senderMessage'],
      timeStamp: json['timeStamp'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'senderUid': senderUid,
      'senderMessage': senderMessage,
      'timeStamp': timeStamp,
    };
  }
}
