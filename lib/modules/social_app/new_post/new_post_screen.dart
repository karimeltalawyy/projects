import 'package:flutter/material.dart';

import '../../../shared/component/components/components.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: defaultAppBar(
          context: context,
          title: 'Add post',
        ),
      ),
    );
  }
}
