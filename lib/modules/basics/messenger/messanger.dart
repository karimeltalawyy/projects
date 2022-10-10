import 'package:flutter/material.dart';

class MessengerDesign extends StatelessWidget {
  const MessengerDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 18,
        title: Row(
          children: const [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.europosters.eu/image/1300/posters/stranger-things-group-i99512.jpg'),
              radius: 22.0,
            ),
            SizedBox(width: 8),
            Text(
              'Chats',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              child: Icon(
                Icons.edit,
                size: 18,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              child: Icon(
                Icons.camera_alt,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: const [
                      Icon(Icons.search),
                      SizedBox(width: 8),
                      Text('Search something..'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 24),
              Container(
                height: 100.0,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) => buildStoryItem(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 24),
                ),
              ),
              const SizedBox(height: 34),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) => buildChatItem(),
                  separatorBuilder: ((context, index) =>
                      const SizedBox(height: 24))),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStoryItem() => Row(
        children: [
          Container(
            width: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: const [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://cdn.europosters.eu/image/1300/posters/stranger-things-group-i99512.jpg'),
                      radius: 25.0,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 6.0,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 5.0,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Karim khaled',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildChatItem() => Container(
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: const [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://cdn.europosters.eu/image/1300/posters/stranger-things-group-i99512.jpg'),
                      radius: 25.0,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 6.0,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 5.0,
                    ),
                  ],
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ibrahim mohamed ibrahium',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Hi I recently add you to the chat',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                  color: Colors.blue, shape: BoxShape.circle),
                            ),
                          ),
                          Text(
                            '24/7 10 PM',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
