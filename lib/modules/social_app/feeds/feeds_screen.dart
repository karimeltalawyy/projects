import 'package:flutter/material.dart';
import 'package:test_one/shared/styles/colors/colors.dart';

import '../../../shared/styles/icon/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Communicate with Friends',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(itemBuilder: (context,index)=>buildPostItem(context),
          separatorBuilder: (context,index)=>const SizedBox(height: 8),
          itemCount: 10,
          shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),

        ],
      ),
    );
  }
  Widget buildPostItem(context)=>Card(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  'https://img.freepik.com/free-photo/jubilant-overjoyed-african-american-woman-celebrates-victory-achieves-success-exclaims-with-tiumph-wears-sweater-tilts-head-poses-pink-wall-being-happy-winner-yeah-i-did-it_273609-42616.jpg?w=996&t=st=1667044143~exp=1667044743~hmac=5080c295999d7c1b2ae7c229ce0d3d0e9c7e6b20ed9a53e7cee799bbea73c721',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Karim Eltalawy',
                          style: TextStyle(height: 1.3),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.check_circle_rounded,
                          color: defaultColor,
                          size: 14,
                        ),
                      ],
                    ),
                    Text(
                      'October,29,2022 at 2:00 PM',
                      style: Theme.of(context)
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
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10),
                    child: Container(
                      height: 20,
                      child: MaterialButton(
                        onPressed: () {},
                        height: 20,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#uiuxdesign',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                            color: defaultColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10),
                    child: Container(
                      height: 20,
                      child: MaterialButton(
                        onPressed: () {},
                        height: 20,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#uiuxdesign',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                            color: defaultColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(8.0),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://img.freepik.com/free-photo/smiling-man-posing-through-torn-paper_273609-31843.jpg?w=996&t=st=1667044186~exp=1667044786~hmac=e1243e7a58df2ea582418909e7c160c08722d061e779e01aaa948574f157c847',
                ),
                fit: BoxFit.cover,
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
                            '12K likes',
                            style: Theme.of(context)
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
                            '500 comments',
                            style: Theme.of(context)
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
                      const CircleAvatar(
                        radius: 14,
                        backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/jubilant-overjoyed-african-american-woman-celebrates-victory-achieves-success-exclaims-with-tiumph-wears-sweater-tilts-head-poses-pink-wall-being-happy-winner-yeah-i-did-it_273609-42616.jpg?w=996&t=st=1667044143~exp=1667044743~hmac=5080c295999d7c1b2ae7c229ce0d3d0e9c7e6b20ed9a53e7cee799bbea73c721',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Write a comment....',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(),
                      ),
                    ],
                  ),
                  onTap: (){},
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
                      style: Theme.of(context)
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
                      style: Theme.of(context)
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
