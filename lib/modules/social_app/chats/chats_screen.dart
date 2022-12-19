import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/social_app/cubit/cubit.dart';
import 'package:test_one/layout/social_app/cubit/states.dart';
import 'package:test_one/models/social_app/social_user_model.dart';
import 'package:test_one/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:test_one/shared/component/components/components.dart';

import '../../../shared/styles/colors/colors.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users!.length > 0,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(SocialCubit.get(context).users![index], context),
            separatorBuilder: (context, index) => buildMyDivider(),
            itemCount: SocialCubit.get(context).users!.length,
          ),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
        onDoubleTap: () {
          print('tapped');
          navigateTo(
              context,
              ChatDetailsScreen(
                userModel: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: InkWell(
            onTap: () {
              navigateTo(context,ChatDetailsScreen());
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                const SizedBox(width: 12),
                Text(
                  '${model.name}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      );
}
