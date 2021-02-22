import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profielwerkstuk_cryptologie/constants.dart';
import 'cipher_brain.dart';
import 'package:share/share.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'widgets/bottom_nav_bar.dart';

class CaesarPage extends StatefulWidget {

  const CaesarPage({Key key}) : super(key: key);

  @override
  _CaesarPageState createState() => _CaesarPageState();
}

class _CaesarPageState extends State<CaesarPage> {

  String plaintext = "";
  int key = 0;
  String showText = "";

  bool switchVal = false;
  bool bottomVisible = false;

  var _controller = TextEditingController();
  var _controllerNumber = TextEditingController();

  share(BuildContext context){
    final RenderBox box = context.findRenderObject();
    Share.share(showText, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void caesarBrain() {
    CipherBrain brain = CipherBrain(text: plaintext, key: key);
    if (key == 0 || plaintext == ""){
      showText = "";
      bottomVisible = false;
    }
    else if (switchVal == false){
      showText = brain.encodeCaesar();
      bottomVisible = true;
    }
    else if (switchVal == true){
      showText = brain.decodeCaesar();
      bottomVisible = true;
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
                      "Caesar Cipher",
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .1,
                      ),
                    ),
                    Text(
                      "Historic Cipher",
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .07,
                      ),
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
                              }
                              if (value == 1){
                                switchVal = true;
                              }
                              caesarBrain();
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
                          caesarBrain();
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
                      keyboardType: TextInputType.number,
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
                              key = 0;
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
                        print(keyInput);
                        setState(() {
                          if (keyInput == ""){
                            key = 0;
                          }
                          else{
                            key = int.parse(keyInput);
                          }
                          caesarBrain();
                        });
                      },
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
                                  style: TextStyle(
                                    color: kTextColor,
                                  ),
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