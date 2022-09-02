import 'package:flutter/material.dart';

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
        validate(s);
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

Widget buildTaskItem() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            child: Text('2:30 PM'),
          ),
          const SizedBox(width: 22),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Task title',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text(
                '31 April 2022',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
