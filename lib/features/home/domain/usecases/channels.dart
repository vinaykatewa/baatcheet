import 'package:baatcheet/core/error/failures.dart';
import 'package:baatcheet/core/usecase/usecase.dart';
import 'package:baatcheet/features/home/data/models/chat_model.dart';
import 'package:baatcheet/features/home/domain/repositories/chat_repository.dart';
import 'package:fpdart/src/either.dart';

class ChannelsUseCase implements UseCase<List<ChatModel>, NoParams> {
  final ChatRepository chatRepository;

  ChannelsUseCase({required this.chatRepository});
  @override
  Future<Either<Failure, List<ChatModel>>> callMethod(NoParams params) async{
    return await chatRepository.getAllChatData();
  }
}
