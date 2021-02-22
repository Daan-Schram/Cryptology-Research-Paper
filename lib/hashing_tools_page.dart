import 'package:flutter/material.dart';
import 'constants.dart';
import 'widgets/category_card.dart';
import 'widgets/bottom_nav_bar.dart';

class HashingToolsPage extends StatelessWidget {
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
                      "Hashing Tools",
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .1,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.018,
                    ),
                    Text(
                      "At this page you will find some hashing tools.",
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
                        SmallCategoryCard(
                          title: "SHA-1",
                          press: (){
                            Navigator.pushNamed(context, "/SHA1");
                          },
                        ),
                        SmallCategoryCard(
                          title: "SHA-2",
                          press: (){
                            Navigator.pushNamed(context, "/SHA2");
                          },
                        ),
                        SmallCategoryCard(
                          title: "SHA-3",
                          press: (){
                            Navigator.pushNamed(context, "/SHA3");
                          },
                        ),
                        SmallCategoryCard(
                          title: "MD",
                          press: (){
                            Navigator.pushNamed(context, "/MD");
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