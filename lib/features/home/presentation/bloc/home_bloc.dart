import 'dart:async';

import 'package:baatcheet/core/usecase/usecase.dart';
import 'package:baatcheet/features/home/domain/entities/channel.dart';
import 'package:baatcheet/features/home/domain/usecases/channels.dart';
import 'package:baatcheet/features/home/domain/usecases/send_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ChannelsUseCase _channelsUseCase;
  final SendMessage _sendMessage;
  HomeBloc(
      {required ChannelsUseCase channelsUseCase,
      required SendMessage sendMessage})
      : _channelsUseCase = channelsUseCase,
        _sendMessage = sendMessage,
        super(HomeInitial()) {
    on<HomeLoadAllChannels>(loadAllChannels);
    on<HomeLoadChatsForChannel>(loadChatForTheChannel);
    on<HomeSendMessage>(homeSendMessage);
    on<HomeAddNewChannel>(homeAddNewChannel);

  }

  FutureOr<void> loadAllChannels(
      HomeLoadAllChannels event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final res = await _channelsUseCase.callMethod(NoParams());
    res.fold(
        (l) => emit(HomeError(error: l.message)),
        (r) => emit(ChannelsLoadedSuccessfully(
            channelsList: r, selectedChannel: r.first)));
  }

  FutureOr<void> loadChatForTheChannel(
      HomeLoadChatsForChannel event, Emitter<HomeState> emit) {
    final currentState = state as ChannelsLoadedSuccessfully;
    emit(currentState.copyWith(selectedChannel: event.selectedChannel));
  }

  FutureOr<void> homeSendMessage(
      HomeSendMessage event, Emitter<HomeState> emit) async {
    final currentState = state as ChannelsLoadedSuccessfully;
    final updatedMessageList =
        List<Chat>.from(currentState.selectedChannel.chat)..add(event.message);
    final res = await _sendMessage.callMethod(SendMessageParam(
        channelName: currentState.selectedChannel.channelName,
        senderUid: event.message.senderUid,
        senderMessage: event.message.senderMessage));
    res.fold((l) => null, (r) => {
    emit(currentState.copyWith(
        selectedChannel: Channel(
            channelName: currentState.selectedChannel.channelName,
            chat: updatedMessageList)))
    });
  }

  FutureOr<void> homeAddNewChannel(HomeAddNewChannel event, Emitter<HomeState> emit) {
    final currentState = state as ChannelsLoadedSuccessfully;
    final newChannel = Channel(channelName: event.channelName, chat: []);
    final updatedChannelList = List<Channel>.from(currentState.channelsList)..add(newChannel);
    emit(currentState.copyWith(channelsList: updatedChannelList, selectedChannel: newChannel));
  }
}
