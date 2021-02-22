import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profielwerkstuk_cryptologie/constants.dart';
import 'package:profielwerkstuk_cryptologie/widgets/bottom_nav_bar.dart';
import 'widgets/category_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: size.height * .4,
              decoration: BoxDecoration(
                color: kOrangeColor,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){
                              Navigator.pushReplacementNamed(context, "/home");
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                color: Color(0xFFF2BEA1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Cryptology",
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: size.height * .28,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CategoryCardWithSecondLine(
                                icon: Icons.lock_rounded,
                                title: "Historic",
                                optionalTitle: "Ciphers",
                                press: () {
                                  Navigator.pushNamed(context, "/historic");
                                }
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CategoryCardWithSecondLine(
                              icon: Icons.timeline_rounded,
                              title: "Modern",
                              optionalTitle: "Ciphers",
                              press: (){
                                Navigator.pushNamed(context, "/modern");
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CategoryCard(
                              icon: Icons.analytics,
                              title: "Cryptanalysis",
                              press: (){
                                Navigator.pushNamed(context, "/cryptanalysis");
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CategoryCardWithSecondLine(
                              icon: Icons.security,
                              title: "Hashing",
                              optionalTitle: "Tools",
                              press: (){
                                Navigator.pushNamed(context, "/hashing");
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CategoryCardWithSecondLine(
                              icon: Icons.code_rounded,
                              title: "MAC",
                              optionalTitle: "Tools",
                              press: (){
                                Navigator.pushNamed(context, "/mac");
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CategoryCardWithSecondLine(
                              icon: Icons.qr_code,
                              title: "Encoding",
                              optionalTitle: "Tools",
                              press: (){
                                Navigator.pushNamed(context, "/encoding");
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CategoryCardWithSecondLine(
                              icon: Icons.school,
                              title: "Mathematics",
                              optionalTitle: "Tools",
                              press: (){
                                Navigator.pushNamed(context, "/mathematics");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    /*
                    SmallCategoryCardHome(
                      title: "Secure Encryption Tools",
                      press: (){
                        Navigator.pushNamed(context, "/secure encryption");
                      },
                      icon: Icons.enhanced_encryption_rounded,
                    ),
                    */
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