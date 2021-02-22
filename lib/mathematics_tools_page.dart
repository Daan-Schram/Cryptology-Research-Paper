import 'package:flutter/material.dart';
import 'constants.dart';
import 'widgets/category_card.dart';
import 'widgets/bottom_nav_bar.dart';

class MathematicsToolsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height * .4,
              decoration: BoxDecoration(
                color: kBlueLightColor,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackButton(),
                    Text(
                      "Mathematics Tools",
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .1,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.018,
                    ),
                    Text(
                      "At this page you will find some mathematics tools.",
                      style: kNormalTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * .29,
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        /*
                        SmallCategoryCard(
                          title: "Primality Test",
                          press: (){
                            Navigator.pushNamed(context, '/primetest');
                          },
                        ),
                         */
                        SmallCategoryCard(
                          title: "Primality Test",
                          press: (){
                            Navigator.pushNamed(context, '/millerrabintest');
                          },
                        ),
                        SmallCategoryCard(
                          title: "Prime List",
                          press: (){
                            Navigator.pushNamed(context, '/primelist');
                          },
                        ),
                        SmallCategoryCard(
                          title: "Prime Factors",
                          press: (){
                            Navigator.pushNamed(context, '/primefactors');
                          },
                        ),
                        SmallCategoryCard(
                          title: "GCD Calculator",
                          press: (){
                            Navigator.pushNamed(context, '/gcd');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: kBlueColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}