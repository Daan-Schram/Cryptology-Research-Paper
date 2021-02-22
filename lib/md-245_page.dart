import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hex/hex.dart';
import 'package:pointycastle/digests/md2.dart';
import 'package:pointycastle/digests/md4.dart';
import 'package:pointycastle/digests/md5.dart';
import 'package:profielwerkstuk_cryptologie/constants.dart';
import 'package:share/share.dart';
import 'widgets/bottom_nav_bar.dart';

class MDPage extends StatefulWidget {

  const MDPage({Key key}) : super(key: key);

  @override
  _MDPageState createState() => _MDPageState();
}

class _MDPageState extends State<MDPage> {

  String plaintext = "";
  String showText = "";

  String showText2 = "";
  String showText4 = "";
  String showText5 = "";

  bool bottomVisible = false;

  var _controller = TextEditingController();

  share(BuildContext context){
    final RenderBox box = context.findRenderObject();
    Share.share(showText, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void mdBrain() {
    if (plaintext != ""){
      setState(() {

        var bytes2 = utf8.encode(plaintext);
        final d = new MD2Digest();
        var digest2 = d.process(bytes2);
        showText2 = HEX.encode(digest2);

        var bytes4 = utf8.encode(plaintext);
        final e = new MD4Digest();
        var digest4 = e.process(bytes4);
        showText4 = HEX.encode(digest4);

        var bytes5 = utf8.encode(plaintext);
        final f = new MD5Digest();
        var digest5 = f.process(bytes5);
        showText5 = HEX.encode(digest5);

        bottomVisible = true;
      });
    }
    else{
      setState(() {
        showText2 = "";
        showText4 = "";
        showText5 = "";
        bottomVisible = false;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showSnackBarCopyButton() {
    String message = "";
    if (showText == ""){
      message = "There is no text to copy";
    }
    else {
      message = "Text copied";
    }
    final snackBar = SnackBar(
      content: Text(
        message,
        style: kNormalTextStyle,
      ),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _showSnackBarShareButton() {
    String message = "There is no text to share";
    final snackBar = SnackBar(
      content: Text(
        message,
        style: kNormalTextStyle,
      ),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
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
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackButton(),
                    Text(
                      "MD2, MD4 & MD5",
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .1,
                      ),
                    ),
                    Text(
                      "Hashing Functions",
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .07,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Text(
                      "These functions takes an input and calculate hashes of different lengths.",
                      style: kNormalTextStyle,
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
                  children: <Widget>[
                    SizedBox(
                      height: size.height * .36,
                    ),
                    TextField(
                      controller: _controller,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      style: kSmallNormalTextStyle,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[500],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kTextColor,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        isDense: true,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          color: Colors.grey[500],
                          iconSize: 20,
                          onPressed: (){
                            WidgetsBinding.instance.addPostFrameCallback((_) => _controller.clear());
                            setState(() {
                              showText = "";
                              plaintext = "";
                              bottomVisible = false;
                            });
                          },
                        ),
                        labelText: 'Input',
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                      onChanged: (String textInput) {
                        setState(() {
                          plaintext = textInput;
                          mdBrain();
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: Text(
                        'MD2:',
                        style: kHeadStyle,
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: SizedBox(
                        height: 15,
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: Text(
                        '$showText2',
                        style: kSmallNormalTextStyle,
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FlatButton(
                            height: 30,
                            minWidth: size.width * .25,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: kBlueLightColor,
                            onPressed: () {
                              showText = showText2;
                              Clipboard.setData(ClipboardData(text: showText2));
                              _showSnackBarCopyButton();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.copy_rounded,
                                  size: 20,
                                ),
                                Text(
                                  "  COPY",
                                  style: TextStyle(
                                    color: kTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FlatButton(
                            height: 30,
                            minWidth: size.width * .25,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: kBlueLightColor,
                            onPressed: () {
                              showText = showText2;
                              if (showText == ""){
                                _showSnackBarShareButton();
                              }
                              else {
                                share(context);
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.share_outlined,
                                  size: 20,
                                ),
                                Text(
                                  "  SHARE",
                                  style: TextStyle(
                                    color: kTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: SizedBox(
                        height: 25,
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: Text(
                        'MD4:',
                        style: kHeadStyle,
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: SizedBox(
                        height: 15,
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: Text(
                        '$showText4',
                        style: kSmallNormalTextStyle,
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FlatButton(
                            height: 30,
                            minWidth: size.width * .25,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: kBlueLightColor,
                            onPressed: () {
                              showText = showText4;
                              Clipboard.setData(ClipboardData(text: showText4));
                              _showSnackBarCopyButton();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.copy_rounded,
                                  size: 20,
                                ),
                                Text(
                                  "  COPY",
                                  style: TextStyle(
                                    color: kTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FlatButton(
                            height: 30,
                            minWidth: size.width * .25,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: kBlueLightColor,
                            onPressed: () {
                              showText = showText4;
                              if (showText == ""){
                                _showSnackBarShareButton();
                              }
                              else {
                                share(context);
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.share_outlined,
                                  size: 20,
                                ),
                                Text(
                                  "  SHARE",
                                  style: TextStyle(
                                    color: kTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: SizedBox(
                        height: 25,
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: Text(
                        'MD5:',
                        style: kHeadStyle,
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: SizedBox(
                        height: 15,
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: Text(
                        '$showText5',
                        style: kSmallNormalTextStyle,
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FlatButton(
                            height: 30,
                            minWidth: size.width * .25,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: kBlueLightColor,
                            onPressed: () {
                              showText = showText5;
                              Clipboard.setData(ClipboardData(text: showText5));
                              _showSnackBarCopyButton();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.copy_rounded,
                                  size: 20,
                                ),
                                Text(
                                  "  COPY",
                                  style: TextStyle(
                                    color: kTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FlatButton(
                            height: 30,
                            minWidth: size.width * .25,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: kBlueLightColor,
                            onPressed: () {
                              showText = showText5;
                              if (showText == ""){
                                _showSnackBarShareButton();
                              }
                              else {
                                share(context);
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.share_outlined,
                                  size: 20,
                                ),
                                Text(
                                  "  SHARE",
                                  style: TextStyle(
                                    color: kTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: SizedBox(
                        height: 25,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
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