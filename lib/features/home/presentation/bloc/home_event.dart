part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeLoadAllChannels extends HomeEvent {}

final class HomeLoadChatsForChannel extends HomeEvent {
  final Channel selectedChannel;
  HomeLoadChatsForChannel({required this.selectedChannel});
}

final class HomeSendMessage extends HomeEvent {
  final Chat message;
  final Channel selectedChannel;
  HomeSendMessage({required this.selectedChannel, required this.message});
}
final class HomeAddNewChannel extends HomeEvent {
  final String channelName;

  HomeAddNewChannel({required this.channelName});
}
