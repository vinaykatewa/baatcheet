import 'package:baatcheet/core/error/failures.dart';
import 'package:baatcheet/features/home/data/models/chat_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ChatRepository {
  Future<Either<Failure, List<ChatModel>>> getAllChatData();
  Future<Either<Failure, int>> sendMessage({
    required String channelName,
    required String senderUid,
    required String senderMessage,
  });
}
