import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/social_app/cubit/states.dart';
import 'package:test_one/models/social_app/social_user_model.dart';
import 'package:test_one/shared/cubit/cubit.dart';
import 'package:test_one/shared/styles/colors/colors.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../models/social_app/message_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? userModel;

  ChatDetailsScreen({
    this.userModel,
  });

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: userModel!.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage('${userModel!.image}'),
                    ),
                    const SizedBox(width: 12),
                    Text('${userModel!.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length>0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var message =
                                SocialCubit.get(context).messages[index];
                            if (SocialCubit.get(context).model!.uId ==
                                message.senderId) {
                              return buildMyMessage(message);
                            } else {
                              return buildSenderMessage(message);
                            }
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: defaultColor.withOpacity(.2),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your message..',
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: defaultColor,
                              ),
                              child: MaterialButton(
                                minWidth: 1,
                                onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: userModel!.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                },
                                child: const Icon(
                                  Icons.send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildSenderMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          child: Text('${messageModel.text}'),
        ),
      );

  Widget buildMyMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(.4),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          child: Text('${messageModel.text}'),
        ),
      );
}
