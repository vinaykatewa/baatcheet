import 'package:baatcheet/core/error/failures.dart';
import 'package:baatcheet/core/usecase/usecase.dart';
import 'package:baatcheet/features/home/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class SendMessage implements UseCase<int, SendMessageParam> {
  final ChatRepository chatRepository;

  SendMessage({required this.chatRepository});
  @override
  Future<Either<Failure, int>> callMethod(
      SendMessageParam sendMessageParam) async {
    return await chatRepository.sendMessage(
        channelName: sendMessageParam.channelName,
        senderUid: sendMessageParam.senderUid,
        senderMessage: sendMessageParam.senderMessage);
  }
}

class SendMessageParam {
  final String channelName;
  final String senderUid;
  final String senderMessage;

  SendMessageParam(
      {required this.channelName,
      required this.senderUid,
      required this.senderMessage});
}
