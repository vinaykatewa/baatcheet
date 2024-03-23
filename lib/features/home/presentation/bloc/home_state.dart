part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

class ChannelsLoadedSuccessfully extends HomeState {
  final List<Channel> channelsList;
  final Channel selectedChannel;

  ChannelsLoadedSuccessfully({
    required this.channelsList,
    required this.selectedChannel,
  });

  ChannelsLoadedSuccessfully copyWith({
    List<Channel>? channelsList,
    Channel? selectedChannel,
  }) {
    return ChannelsLoadedSuccessfully(
      channelsList: channelsList ?? this.channelsList,
      selectedChannel: selectedChannel ?? this.selectedChannel,
    );
  }
}

final class HomeError extends HomeState {
  final String error;
  HomeError({required this.error});
}

