import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_one/modules/shop_app/login/login_screen.dart';
import 'package:test_one/shared/component/components/components.dart';
import 'package:test_one/shared/styles/colors.dart';
import 'package:test_one/shared/styles/styles.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/Payment.png',
      body: 'your shop online easy and more secure',
      title: 'Take your shop online today.',
    ),
    BoardingModel(
      image: 'assets/images/Delivery.png',
      body: 'your shop online easy and more secure',
      title: 'Add products with easy steps.',
    ),
    BoardingModel(
      image: 'assets/images/newsletter.png',
      body: 'your shop online easy and more secure',
      title: 'Find the item you\'ve been looking for.',
    ),
  ];

  var boardingController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(text: 'Skip',function: (){
            navigateAndFinish(context,  ShopLoginScreen());
          }),
          // TextButton(onPressed: (){
          //
          // }, child: const Text('Skip')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(boarding[index]),
                itemCount: boarding.length,
                physics: const BouncingScrollPhysics(),
                controller: boardingController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    print('Last');
                  } else {
                    setState(() {
                      isLast = false;
                    });
                    print('not last');
                  }
                },
              ),
            ),
            // SizedBox(height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 6.0,
                    expansionFactor: 3,
                    dotWidth: 6.0,
                    spacing: 4,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      navigateAndFinish(context,  ShopLoginScreen());
                    } else {
                      boardingController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.easeInOutBack,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_sharp),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('${model.image}'),
            height: 300,
            width: 300,
          ),
          const SizedBox(height: 30),
          Text(
            '${model.title}',
            style: GoogleFonts.inter(
              textStyle: style,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 16.0, color: Colors.grey[500]),
          )
        ],
      );
}
