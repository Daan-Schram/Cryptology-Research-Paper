import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profielwerkstuk_cryptologie/constants.dart';
import 'widgets/bottom_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                      "Information",
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
                      "If you found any bugs, want to ask us a question, or give us a tip, do not hesitate to email us:",
                      style: kNormalTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      height: 35,
                      minWidth: size.width,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: kOrangeColor,
                      onPressed: () => _launchURL('daanschram.developer@gmail.com', 'Report Cryptology App', ''),
                      child: Text(
                        "Send an E-Mail",
                        style: TextStyle(
                          color: kTextColor,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome to our App! We are Daan and Mats, and we created this app as part of our school research paper. This is a paper that we need to make at the end of our secondary school. \n\nOur goal is to educate people what cryptology is and what it consists of.",
                      style: kNormalTextStyle,
                    ),
                    SizedBox(
                      height: 10,
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