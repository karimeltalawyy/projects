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
  required Function? validate,
  required String? label,
  required String? hint,
  required IconData? prefix,
  IconData? sufix,
}) =>
    TextFormField(
      controller: controller,
      onChanged: ((value) {
        onChanged!(value);
      }),
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      keyboardType: type,
      validator: (s) {
        validate!(s);
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: Icon(sufix),
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