import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profielwerkstuk_cryptologie/constants.dart';
import 'package:share/share.dart';
import 'widgets/bottom_nav_bar.dart';
import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'dart:math';

class HmacSha1 extends StatefulWidget {

  const HmacSha1({key}) : super(key: key);

  @override
  _HmacSha1State createState() => _HmacSha1State();
}

class _HmacSha1State extends State<HmacSha1> {

  String plaintext = "";
  String key = "";
  String nonce = "";
  String showText = "";
  String mode = "";
  String buttonText = "Encrypt";

  String errorText = "";

  bool switchVal = false;
  bool bottomVisible = false;
  bool errorVisible = false;

  var _controller = TextEditingController();
  var _controllerNumber = TextEditingController();

  share(BuildContext context){
    final RenderBox box = context.findRenderObject();
    Share.share(showText, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> hmacBrain() async {
    if (key == "" || plaintext == ""){
      showText = "";
      bottomVisible = false;
    }
    else {
      final message = utf8.encode(plaintext);
      final secretKey = SecretKey(utf8.encode(key));

      final mac = await Hmac(sha1).calculateMac(
        message,
        secretKey:secretKey,
      );
      setState(() {
        errorVisible = false;
        showText = base64.encode(mac.bytes);
        bottomVisible = true;
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
                      "HMAC-SHA-1",
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .1,
                      ),
                    ),
                    Text(
                      "MAC Functions",
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .07,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Text(
                      "This function takes an input and uses SHA-1 to generate a MAC.",
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
                      height: size.height * .35,
                    ),
                    Text(
                      'Enter input and key:',
                      style: kHeadStyle,
                    ),
                    SizedBox(
                      height: 15,
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
                          bottomVisible = false;
                        });
                        hmacBrain();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _controllerNumber,
                      maxLines: null,
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
                            WidgetsBinding.instance.addPostFrameCallback((_) => _controllerNumber.clear());
                            setState(() {
                              showText = "";
                              key = "";
                              bottomVisible = false;
                            });
                          },
                        ),
                        labelText: 'Key',
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                      onChanged: (String keyInput) {
                        setState(() {
                          if (keyInput == ""){
                            key = "";
                          }
                          else{
                            key = keyInput;
                          }
                          bottomVisible = false;
                        });
                        hmacBrain();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: errorVisible,
                      child: SizedBox(
                        height: 25,
                      ),
                    ),
                    Visibility(
                      visible: errorVisible,
                      child: Text(
                        "$errorText",
                        style: kNormalTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.red[600],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: Text(
                        'Output:',
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
                        '$showText',
                        style: kSmallNormalTextStyle,
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: SizedBox(
                        height: 40,
                      ),
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            height: 50,
                            minWidth: size.width * .43,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: kBlueLightColor,
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: showText));
                              _showSnackBarCopyButton();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.copy_rounded,
                                ),
                                Text(
                                  "  COPY",
                                  style: kNormalTextStyle,
                                ),
                              ],
                            ),
                          ),
                          FlatButton(
                            height: 50,
                            minWidth: size.width * .43,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: kBlueLightColor,
                            onPressed: () {
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
                                ),
                                Text(
                                  "  SHARE",
                                  style: kNormalTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
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