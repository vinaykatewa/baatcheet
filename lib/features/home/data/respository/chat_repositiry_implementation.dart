import 'package:baatcheet/core/error/exceptions.dart';
import 'package:baatcheet/core/error/failures.dart';
import 'package:baatcheet/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:baatcheet/features/home/data/models/chat_model.dart';
import 'package:baatcheet/features/home/domain/repositories/chat_repository.dart';
import 'package:fpdart/src/either.dart';

class ChatRepositoryImplementation implements ChatRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  ChatRepositoryImplementation({required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, List<ChatModel>>> getAllChatData() async {
    try {
      final res = await homeRemoteDataSource.getAllChatData();
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, int>> sendMessage({
    required String channelName,
    required String senderUid,
    required String senderMessage,
  }) async{
    try {
      final res = await homeRemoteDataSource.submitMessage(channelName: channelName, senderUid: senderUid, senderMessage: senderMessage);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
