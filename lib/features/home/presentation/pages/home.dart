import 'package:baatcheet/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:baatcheet/core/common/widgets/loader.dart';
import 'package:baatcheet/core/theme/app_pallete.dart';
import 'package:baatcheet/core/utils/show_snackbar.dart';
import 'package:baatcheet/features/home/domain/entities/channel.dart';
import 'package:baatcheet/features/home/presentation/bloc/home_bloc.dart';
import 'package:baatcheet/features/home/presentation/widgets/message_text_field.dart';
import 'package:baatcheet/features/home/presentation/widgets/new_channel_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController messageController = TextEditingController();
  TextEditingController newChannelController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeLoadAllChannels());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Home'),
              ),
              body: Loader());
        }
        if (state is ChannelsLoadedSuccessfully) {
          return Scaffold(
              appBar: AppBar(
                title: Text(state.selectedChannel.channelName),
              ),
              drawer: Drawer(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 4.0, right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      NewChannelTextField(
                        controller: newChannelController,
                        hintText: 'Create new channel',
                        onPressed: () {
                          context.read<HomeBloc>().add(HomeAddNewChannel(channelName: newChannelController.text.trim()));
                          newChannelController.clear();
                          Navigator.pop(context);
                        },
                      ),
                      const Divider(color: AppPalette.borderColor,),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.channelsList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.channelsList[index].channelName),
                            onTap: () {
                              context.read<HomeBloc>().add(
                                  HomeLoadChatsForChannel(
                                      selectedChannel:
                                          state.channelsList[index]));
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: state.selectedChannel.chat.isEmpty ? const Center(child: Text('No discussion to show in this channel'),) : ListView.builder(
                      reverse: true,
                      itemCount: state.selectedChannel.chat.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              state.selectedChannel.chat[index].senderMessage),
                        );
                      },
                    ),
                  ),
                  MessageTextField(
                    hintText: 'Enter your message',
                    controller: messageController,
                    onPressed: () {
                      final appUserState =
                          BlocProvider.of<AppUserCubit>(context).state;
                      if (appUserState is AppUserLoggedIn) {
                        final senderUid = appUserState.user.id;
                        context.read<HomeBloc>().add(HomeSendMessage(
                            message: Chat(
                                senderUid: senderUid,
                                senderMessage: messageController.text.trim(),
                                timeStamp: DateTime.now().toString()),
                            selectedChannel: state.selectedChannel));
                        messageController.clear();
                      }
                    },
                  )
                ],
              ));
        }
        if (state is HomeError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error page'),
            ),
            body: Center(
              child: Text('Error page: ${state.error}'),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error page'),
            ),
            body: const Center(
              child: Text('Error page:}'),
            ),
          );
        }
      },
    );
  }
}
