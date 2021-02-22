import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profielwerkstuk_cryptologie/constants.dart';
//import 'package:share/share.dart';
import 'widgets/bottom_nav_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class QRCodePageResult extends StatefulWidget {

  final String text;

  const QRCodePageResult({Key key, @required this.text}) : super(key: key);

  @override
  _QRCodePageResultState createState() => _QRCodePageResultState();
}

class _QRCodePageResultState extends State<QRCodePageResult> {

  String plaintext = "";
  String showText;
  String buttonText = "Generate";

  bool bottomVisible = true;

  ScreenshotController screenshotController = ScreenshotController();

  Uint8List _imageFile;

  //var _controller = TextEditingController();

  /*
  share(BuildContext context){
    final RenderBox box = context.findRenderObject();
    Share.share(showText, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
  */

  void qrBrain(){
    if (plaintext == ""){
      setState(() {
        showText = "";
        bottomVisible = false;
      });
    }
    else{
      setState(() {
        showText = plaintext;
        bottomVisible = true;
      });
    }
  }

  /*
  Future<void> exportBrain() async{
    screenshotController.capture().then((Uint8List image) {
      setState(() {
        _imageFile = image;
      });
    }).catchError((onError) {
      print(onError);
    });
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(_imageFile),
        quality: 60,
        name: "qrcode");
    print(result);
  }

   */

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /*
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
  */

  @override
  Widget build(BuildContext context) {
    String qrText = widget.text;
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
                      'QR Code',
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .1,
                      ),
                    ),
                    Text(
                      'Result',
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .07,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Text(
                      "The generated QR Code is:",
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
                    SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: bottomVisible,
                      child: Screenshot(
                        controller: screenshotController,
                        child: Center(
                          child: QrImage(
                            data: '$qrText',
                            version: QrVersions.auto,
                            size: 350,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /*
                    Visibility(
                      visible: bottomVisible,
                      child: FlatButton(
                        height: 50,
                        minWidth: size.width * .43,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: kBlueLightColor,
                        onPressed: () {
                          exportBrain();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.download_rounded,
                            ),
                            Text(
                              "  EXPORT",
                              style: TextStyle(
                                color: kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                     */

                    /*
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
                    */
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