import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/social_app/cubit/cubit.dart';
import 'package:test_one/layout/social_app/cubit/states.dart';
import 'package:test_one/models/social_app/post_model.dart';
import 'package:test_one/shared/styles/colors/colors.dart';

import '../../../shared/styles/icon/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:SocialCubit.get(context).posts!.length >0,
          fallback: (context) => const Center(child: CircularProgressIndicator()),
          builder: (context) =>
              SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(8.0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 6.0,
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          const Image(
                            image: NetworkImage(
                              'https://img.freepik.com/free-photo/smiling-man-posing-through-torn-paper_273609-31843.jpg?w=996&t=st=1667044186~exp=1667044786~hmac=e1243e7a58df2ea582418909e7c160c08722d061e779e01aaa948574f157c847',
                            ),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Communicate',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  'with Friends',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts![index],context),
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                      itemCount: SocialCubit.get(context).posts!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              ),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context) =>
      Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      '${model.image}',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children:  [
                            Text(
                              '${model.name}',
                              style: const TextStyle(height: 1.3),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.check_circle_rounded,
                              color: defaultColor,
                              size: 14,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 16,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[200],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 6),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 10),
              //           child: Container(
              //             height: 20,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               height: 20,
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#uiuxdesign',
              //                 style:
              //                     Theme.of(context).textTheme.caption!.copyWith(
              //                           color: defaultColor,
              //                         ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 10),
              //           child: Container(
              //             height: 20,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               height: 20,
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#uiuxdesign',
              //                 style:
              //                     Theme.of(context).textTheme.caption!.copyWith(
              //                           color: defaultColor,
              //                         ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(model.postImage!='')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15.0),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(8.0),
                    image:  DecorationImage(
                      image: NetworkImage(
                        '${model.postImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.heart,
                                size: 22,
                                color: defaultColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '0 likes',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                IconBroken.chatCircle,
                                size: 22,
                                color: Colors.orangeAccent,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '0 comments',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[200],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           CircleAvatar(
                            radius: 14,
                            backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).model!.image}',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Write a comment....',
                            style:
                            Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.heart,
                          size: 22,
                          color: defaultColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Like',
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          IconBroken.upload,
                          size: 22,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Share',
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
