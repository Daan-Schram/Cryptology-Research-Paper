import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profielwerkstuk_cryptologie/constants.dart';
import 'package:share/share.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'widgets/bottom_nav_bar.dart';
import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'dart:math';

class AESPageCBC extends StatefulWidget {

  const AESPageCBC({key}) : super(key: key);

  @override
  _AESPageCBCState createState() => _AESPageCBCState();
}

class _AESPageCBCState extends State<AESPageCBC> {

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
  var _controllerNonce = TextEditingController();

  share(BuildContext context){
    final RenderBox box = context.findRenderObject();
    Share.share(showText, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  /*
  void aesBrain() {
    final _plainText = plaintext;
    final _key = encrypt.Key.fromUtf8(key);
    final _iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(_key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(_plainText, iv: _iv);

    setState(() {
      showText = encrypted.base64;
      bottomVisible = true;
    });
    print(showText);
  }
  */

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> aesBrain() async {
    final cipher = CipherWithAppendedMac(aesCbc, Hmac(sha256));
    final secretKey = SecretKey(utf8.encode(key));
    final nonce1 = Nonce(utf8.encode(nonce));

    if (key == "" || plaintext == "" || nonce == ""){
      showText = "";
      bottomVisible = false;
    }
    if(key.length != 16){
      setState(() {
        errorText = "The key you entered is not 16 characters!";
        bottomVisible = false;
        errorVisible = true;
      });
    }
    else if(nonce.length != 12){
      setState(() {
        errorText = "The nonce you entered is not 12 characters!";
        bottomVisible = false;
        errorVisible = true;
      });
    }
    else if (switchVal == false){
      final message = utf8.encode(plaintext);
      final encrypted = await cipher.encrypt(
        message,
        secretKey: secretKey,
        nonce: nonce1,
      );
      setState(() {
        errorVisible = false;
        showText = base64.encode(encrypted);
        bottomVisible = true;
      });
      print(showText);
    }
    else if (switchVal == true){
      final message = base64.decode(plaintext);
      final decrypted = await cipher.decrypt(
        message,
        secretKey: secretKey,
        nonce: nonce1,
      );
      setState(() {
        errorVisible = false;
        showText = utf8.decode(decrypted);
        bottomVisible = true;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showSnackBarCopyButton() {
    String message = "";
    if (showText == ""){
      message = "There is no ciphertext to copy";
    }
    else {
      message = "Ciphertext copied";
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
    String message = "There is no ciphertext to share";
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
                      'AES-CBC',
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .1,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .044,
                    ),
                    Text(
                      "AES-CBC + HMAC-SHA256",
                      style: kNormalTextStyle,
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ToggleSwitch(
                          minWidth: 150,
                          minHeight: 35,
                          activeBgColor: kBlueColor,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey[500],
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: 0,
                          labels: ['Encrypt', 'Decrypt'],
                          cornerRadius: 30,
                          onToggle: (int value) {
                            setState(() {
                              if (value == 0){
                                switchVal = false;
                                buttonText = "Encrypt";
                                bottomVisible = false;
                                errorVisible = false;
                              }
                              if (value == 1){
                                switchVal = true;
                                buttonText = "Decrypt";
                                bottomVisible = false;
                                errorVisible = false;
                              }
                            });
                          },
                        ),
                      ],
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
                      'Enter input, key (16 characters) and nonce (12 characters):',
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
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _controllerNonce,
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
                            WidgetsBinding.instance.addPostFrameCallback((_) => _controllerNonce.clear());
                            setState(() {
                              showText = "";
                              nonce = "";
                              bottomVisible = false;
                            });
                          },
                        ),
                        labelText: 'Nonce',
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                      onChanged: (String keyInput) {
                        setState(() {
                          if (keyInput == ""){
                            nonce = "";
                          }
                          else{
                            nonce = keyInput;
                          }
                          bottomVisible = false;
                        });
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    FlatButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: kBlueLightColor,
                      onPressed: () {
                        aesBrain();
                      },
                      child: Center(
                        child: Text(
                          "$buttonText",
                          style: kNormalTextStyle,
                        ),
                      ),
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