import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../cubit/cubit.dart';

Widget defaultButton({
  Color? backgroundColor = Colors.redAccent,
  double? width = double.infinity,
  bool isUpperCase = true,
  double radius = 12.0,
  required String text,
  required Function function,
}) =>
    Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            radius,
          )),
      width: width,
      height: 40,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );

Widget defaultFormFeild({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  Function? suffixPressed,
  AutovalidateMode? autoValidate,
  required Function validate,
  required String? label,
  required String? hint,
  required IconData? prefix,
  IconData? sufix,
  bool isPassword = false,
  bool isClickable = true,
}) =>
    TextFormField(
      autovalidateMode: autoValidate,
      obscureText: isPassword,
      controller: controller,
      onChanged: ((s) {
        onChanged ?? (s);
      }),
      onTap: () {
        onTap!();
      },
      onFieldSubmitted: (s) {
        onSubmit ?? (s);
      },
      keyboardType: type,
      validator: (s) {
        return validate(s);
      },
      enabled: isClickable,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: sufix != null
            ? IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  suffixPressed!();
                },
              )
            : null,
        hintText: hint,
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );

Widget taskBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          // print('task status ${tasks[index]['status']}');
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index) => Container(
          width: double.infinity,
          color: Colors.grey[300],
          height: 1.0,
        ),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.signal_wifi_statusbar_null, color: Colors.grey),
            Text(
              'No tasks yet, please add some tasks',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text('${model['time']}'),
            ),
            const SizedBox(width: 22),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 22),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'Done',
                  id: model['id'],
                );
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'Archive',
                  id: model['id'],
                );
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.black12,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );
