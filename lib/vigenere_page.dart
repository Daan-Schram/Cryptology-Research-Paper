import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profielwerkstuk_cryptologie/constants.dart';
import 'package:share/share.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'widgets/bottom_nav_bar.dart';

class VigenerePage extends StatefulWidget {

  const VigenerePage({Key key}) : super(key: key);

  @override
  _VigenerePageState createState() => _VigenerePageState();
}

class _VigenerePageState extends State<VigenerePage> {

  String plaintext = "";
  String key = "";
  String showText = "";

  bool switchVal = false;
  bool bottomVisible = false;

  var _controller = TextEditingController();
  var _controllerNumber = TextEditingController();

  share(BuildContext context){
    final RenderBox box = context.findRenderObject();
    Share.share(showText, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void vigenereBrain() {
    if (key == "" || plaintext == ""){
      showText = "";
      bottomVisible = false;
    }
    else if (switchVal == false){
      setState(() {
        bottomVisible = true;
        showText = encodeVigenere(plaintext, key);
      });
    }
    else if (switchVal == true) {
      setState(() {
        bottomVisible = true;
        showText = decodeVigenere(plaintext, key);
      });
    }
  }

  /*
  String encrypt(String input, String key) {
    String output = "";
    int j = 0;
    for (int i = 0; i < input.length; i++) {
      if (input[i].isNotEmpty) {
        if (input[i].toUpperCase() == input[i] && input[i].codeUnitAt(0) > 64 && input[i].codeUnitAt(0) < 91){
          output += String.fromCharCode((input.codeUnitAt(i) + key.codeUnitAt(j)) % 26 + 65);
        }
        else if (input[i].toUpperCase() != input[i] && input[i].codeUnitAt(0) > 96 && input[i].codeUnitAt(0) < 123){
          output += String.fromCharCode((input.codeUnitAt(i) + key.codeUnitAt(j)) % 26 + 97);
        }
      } else {
        output += input[i];
      }
      if (j < key.length - 1) {
        j++;
      } else {
        j = 0;
      }
    }
    return output;
  }

  int mod(int val, int mod) {
    return (val % mod + mod) % mod;
  }

  String decrypt(String input, String key) {
    String output = "";
    int j = 0;

    for (int i = 0; i < input.length; i++) {
      if (input[i].isNotEmpty) {
        output += String.fromCharCode(
            mod((input.codeUnitAt(i) - key.codeUnitAt(j)), 26) + 65);
      } else {
        output += input[i];
      }

      if (j < key.length - 1)
        j++;
      else
        j = 0;
    }
    return output;
  }
   */

  String encodeVigenere(String input, String key){
    List li = input.split("");
    String encText = "";
    int j = 0;
    key = key.toLowerCase();

    for (String letter in li) {
      int newValue = 0;
      String newLetter = "";

      if (letter.toUpperCase() == letter && letter.codeUnitAt(0) > 64 && letter.codeUnitAt(0) < 91) {
        int value = letter.codeUnitAt(0) - 65;
        int valueKey = key.codeUnitAt(j) - 97;
        newValue = (value + valueKey) % 26 + 65;
        newLetter = String.fromCharCode(newValue);
        if (j < key.length - 1) {
          j++;
        } else {
          j = 0;
        }
      }

      else if (letter.toUpperCase() != letter && letter.codeUnitAt(0) > 96 && letter.codeUnitAt(0) < 123) {
        int value = letter.codeUnitAt(0) - 97;
        int valueKey = key.codeUnitAt(j) - 97;
        newValue = (value + valueKey) % 26 + 97;
        newLetter = String.fromCharCode(newValue);
        if (j < key.length - 1) {
          j++;
        } else {
          j = 0;
        }
      }

      else {
        newLetter = letter;
      }
      encText += newLetter;
    }
    return encText;
  }

  String decodeVigenere(String input, String key){
    List li = input.split("");
    String decText = "";
    int j = 0;
    key = key.toLowerCase();

    for (String letter in li) {
      int newValue = 0;
      String newLetter = "";

      if (letter.toUpperCase() == letter && letter.codeUnitAt(0) > 64 && letter.codeUnitAt(0) < 91) {
        int value = letter.codeUnitAt(0) - 65;
        int valueKey = key.codeUnitAt(j) - 97;
        newValue = (value - valueKey) % 26 + 65;
        newLetter = String.fromCharCode(newValue);
        if (j < key.length - 1) {
          j++;
        } else {
          j = 0;
        }
      }

      else if (letter.toUpperCase() != letter && letter.codeUnitAt(0) > 96 && letter.codeUnitAt(0) < 123) {
        int value = letter.codeUnitAt(0) - 97;
        int valueKey = key.codeUnitAt(j) - 97;
        newValue = (value - valueKey) % 26 + 97;
        newLetter = String.fromCharCode(newValue);
        if (j < key.length - 1) {
          j++;
        } else {
          j = 0;
        }
      }

      else {
        newLetter = letter;
      }
      decText += newLetter;
    }
    return decText;
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
                      "Vigenère Cipher",
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
                              vigenereBrain();
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
                          vigenereBrain();
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
                          vigenereBrain();
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