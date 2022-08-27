import 'package:flutter/material.dart';

class UserModel {
  final int id;
  final String name;
  final String phone;
  UserModel({required this.id, required this.name, required this.phone});
}

class UserScreen extends StatelessWidget {
  UserScreen({Key? key}) : super(key: key);

  List<UserModel> users = [
    UserModel(id: 1, name: 'karim', phone: '01207245632'),
    UserModel(id: 2, name: 'Ahmed', phone: '01207249082'),
    UserModel(id: 3, name: 'Ali', phone: '01201232134'),
    UserModel(id: 1, name: 'karim', phone: '01207245632'),
    UserModel(id: 2, name: 'Ahmed', phone: '01207249082'),
    UserModel(id: 3, name: 'Ali', phone: '01201232134'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Screen')),
      body: ListView.separated(
        itemCount: users.length,
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.grey[300],
        ),
      ),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(children: [
          CircleAvatar(
            radius: 25.0,
            child: Text(
              '${user.id}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          const SizedBox(width: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${user.name}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text(
                '${user.phone}',
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ],
          ),
        ]),
      );
}
