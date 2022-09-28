import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:test_one/shared/styles/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../modules/news_app/webview/webview_screen.dart';

Widget defaultButton({
  Color? backgroundColor = defaultColor,
  double? width = double.infinity,
  bool isUpperCase = true,
  double radius = 8.0,
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
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required String text,
  required Function function,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text),
    );

Widget defaultFormFeild({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  Function? suffixPressed,
  required Function validate,
  required String? label,
  required String? hint,
  required IconData? prefix,
  IconData? sufix,
  bool isPassword = false,
  bool isClickable = true,
}) =>
    TextFormField(
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

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebviewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(12),

                // color: Colors.deepOrange,

                image: DecorationImage(
                  image: NetworkImage(
                    '${article['urlToImage']}',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildMydivider() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: Colors.grey[200],
        height: 1,
        width: double.infinity,
      ),
    );

Widget articleBuilderItem(list, context) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => buildMydivider(),
        itemCount: 10,
      ),
      fallback: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
