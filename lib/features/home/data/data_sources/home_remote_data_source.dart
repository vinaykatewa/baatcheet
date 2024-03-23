import 'dart:convert';
import 'package:baatcheet/core/error/exceptions.dart';
import 'package:baatcheet/features/home/data/models/chat_model.dart';
import 'package:http/http.dart' as http;

abstract interface class HomeRemoteDataSource {
  Future<List<ChatModel>> getAllChatData();
  Future<int> submitMessage({
    required String channelName,
    required String senderUid,
    required String senderMessage,
  });
}

class HomeRemoteDataSourceImplementation implements HomeRemoteDataSource {
  @override
  Future<List<ChatModel>> getAllChatData() async {
    try {
      var request = http.Request(
          'GET', Uri.parse('https://baatcheet-9xmv.onrender.com/getchannels'));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        List<dynamic> jsonData = jsonDecode(data);
        return jsonData.map((json) => ChatModel.fromJson(json)).toList();
        // [{_id: 65fbe8fd8c22f448cba888ad, channelName: General, __v: 0, chat: [{senderUid: useruid1, senderMessage: hi , timeStamp: 2024-03-21T07:59:58.746Z, _id: 65fbe8fea7c2fb7cf2186d6e}, {senderUid: useruid1, senderMessage: hi this is a message, timeStamp: 2024-03-21T08:00:23.248Z, _id: 65fbe917a7c2fb7cf2186d71}, {senderUid: useruid1, senderMessage: hello, timeStamp: 2024-03-21T08:05:14.326Z, _id: 65fbea3aa7c2fb7cf2186d86}], createdAt: 2024-03-21T07:59:58.750Z, updatedAt: 2024-03-21T08:05:14.327Z}, {_id: 65fbe9248c22f448cba8c255, channelName: Funnny, __v: 0, chat: [{senderUid: useruid1, senderMessage: hi this is a message, timeStamp: 2024-03-21T08:00:37.388Z, _id: 65fbe925a7c2fb7cf2186d75}, {senderUid: useruid1, senderMessage: hello, timeStamp: 2024-03-21T08:00:46.290Z, _id: 65fbe92ea7c2fb7cf2186d78}], createdAt: 2024-03-21T08:00:37.389Z, updatedAt: 2024-03-21T08:00:46.291Z}]
      } else {
        throw ServerException(
            'We got a problem with the api while getting the channels data');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> submitMessage({
    required String channelName,
    required String senderUid,
    required String senderMessage,
  }) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST', Uri.parse('https://baatcheet-9xmv.onrender.com/sendMessage'));
      request.body = json.encode({
        "channelName": channelName,
        "senderUid": senderUid,
        "senderMessage": senderMessage
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return 1;
      } else {
        throw ServerException(
            'We got a problem with the api while sending the message');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
