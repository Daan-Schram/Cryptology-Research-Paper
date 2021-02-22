import 'package:flutter/material.dart';
import 'widgets/bottom_nav_bar.dart';
import 'constants.dart';

class PaperPage extends StatefulWidget {
  @override
  _PaperPageState createState() => _PaperPageState();
}

class _PaperPageState extends State<PaperPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height * .3,
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
                              Navigator.pushReplacementNamed(context, '/home');
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
                      "Paper",
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
                    SizedBox(
                      height: size.height * .25,
                    ),
                    Text(
                      "To be able to read the school research paper we wrote next to creating this app, press the button below:",
                      style: kNormalTextStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      height: 80,
                      minWidth: size.width,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: kOrangeColor,
                      onPressed: () => Navigator.pushNamed(context, '/pdfviewer'),
                      child: Text(
                        "Read the paper",
                        style: TextStyle(
                          color: kTextColor,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                        ),
                      ),
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
