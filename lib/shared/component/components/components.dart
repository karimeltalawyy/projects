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
  Function? suffixPressed,
  required Function? validate,
  required String? label,
  required String? hint,
  required IconData? prefix,
  IconData? sufix,
  bool isPassword = false,
}) =>
    TextFormField(
      obscureText: isPassword,
      controller: controller,
      onChanged: ((s) {
        onChanged ?? (s);
      }),
      onFieldSubmitted: (s) {
        onSubmit ?? (s);
      },
      keyboardType: type,
      validator: (s) {
        validate ?? (s);
        return null;
      },
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
// (String? value) {
//         if (value!.isEmpty) {
//           return 'Email conot be empty';
//         }
//         return null;
//       },