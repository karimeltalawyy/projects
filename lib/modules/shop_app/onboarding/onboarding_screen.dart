import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_one/modules/shop_app/login/shop_login.dart';
import 'package:test_one/shared/component/components/components.dart';
import 'package:test_one/shared/network/local/cache_helper.dart';
import 'package:test_one/shared/styles/colors/colors.dart';

class BoardingModel {
  final String title;
  final String subTitle;
  final String image;
  BoardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/OnBoardingOne.png',
      title: 'Find the item you\'ve been looking for.',
      subTitle: 'Find the item you\'ve been looking for.',
    ),
    BoardingModel(
      image: 'assets/images/OnBoardingTwo.png',
      title: 'Find the item you\'ve been looking for.',
      subTitle: 'Find the item you\'ve been looking for.',
    ),
    BoardingModel(
      image: 'assets/images/OnBoardingThree.png',
      title: 'Find the item you\'ve been looking for.',
      subTitle: 'Find the item you\'ve been looking for.',
    ),
  ];
  var boardingController = PageController();
  bool isLast = false;
  void submit() {
    CacheHelper.saveData(
      key: 'OnBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(
              function: submit,
              text: 'SKIP',
            ),
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
                  controller: boardingController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        print('Last');
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        print('not Last');
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardingController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 8.0,
                      dotWidth: 8.0,
                      expansionFactor: 3,
                      spacing: 4.0,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardingController.nextPage(
                          duration: const Duration(milliseconds: 650),
                          curve: Curves.easeInOutExpo,
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

Widget buildOnBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage('${model.image}'),
          height: 350,
          width: 350,
        ),
        Text(
          '${model.title}',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          '${model.subTitle}',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
