import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profielwerkstuk_cryptologie/constants.dart';
import 'widgets/bottom_nav_bar.dart';
import 'package:ninja_prime/ninja_prime.dart';


class GCDPage extends StatefulWidget {

  const GCDPage({key}) : super(key: key);

  @override
  _GCDPageState createState() => _GCDPageState();
}

class _GCDPageState extends State<GCDPage> {

  String input1 = "";
  String input2 = "";

  String showText = "";
  String buttonText = "Calculate";

  String errorText = "";

  bool switchVal = false;
  bool bottomVisible = false;
  bool errorVisible = false;

  var regex = new RegExp(r'[a-zA-Z]');

  BigInt greatestCommonDivisor(BigInt a, BigInt b) => a.gcd(b);

  void gcdBrain() {
    BigInt a = BigInt.parse(input1.replaceAll(' ', '').replaceAll('\n', '').replaceAll(regex, ''));
    BigInt b = BigInt.parse(input2.replaceAll(' ', '').replaceAll('\n', '').replaceAll(regex, ''));
    setState(() {
      bottomVisible = true;
      errorVisible = false;
      showText = greatestCommonDivisor(a, b).toString();
    });
  }

  var _controller = TextEditingController();
  var _controller2 = TextEditingController();


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                      'GCD Calculator',
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .1,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .044,
                    ),
                    Text(
                      "This tool will calculate the GCD of two numbers, using the Euclidean algorithm.",
                      style: kNormalTextStyle,
                    ),
                    SizedBox(
                      height: size.height * .03,
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
                      maxLengthEnforced: true,
                      maxLength: 1000,
                      controller: _controller,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
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
                            WidgetsBinding.instance.addPostFrameCallback((_) => _controller.clear());
                            setState(() {
                              showText = "";
                              input1 = "";
                              bottomVisible = false;
                              errorVisible = false;
                            });
                          },
                        ),
                        labelText: 'Input 1',
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                      onChanged: (String textInput) {
                        setState(() {
                          input1 = textInput;
                          bottomVisible = false;
                          errorVisible = false;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      maxLengthEnforced: true,
                      maxLength: 1000,
                      controller: _controller2,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
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
                            WidgetsBinding.instance.addPostFrameCallback((_) => _controller2.clear());
                            setState(() {
                              showText = "";
                              input2 = "";
                              bottomVisible = false;
                              errorVisible = false;
                            });
                          },
                        ),
                        labelText: 'Input 2',
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                      onChanged: (String textInput) {
                        setState(() {
                          input2 = textInput;
                          bottomVisible = false;
                          errorVisible = false;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FlatButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: kBlueLightColor,
                      onPressed: () {
                        gcdBrain();
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
                        'GCD:',
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