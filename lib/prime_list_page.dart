import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profielwerkstuk_cryptologie/constants.dart';
import 'widgets/bottom_nav_bar.dart';
import 'package:ninja_prime/ninja_prime.dart';


class PrimeListPage extends StatefulWidget {

  const PrimeListPage({key}) : super(key: key);

  @override
  _PrimeListPageState createState() => _PrimeListPageState();
}

class _PrimeListPageState extends State<PrimeListPage> {

  String lowerLimit = "";
  String upperLimit = "";

  String showText = "";
  String buttonText = "Calculate";

  String errorText = "";

  bool switchVal = false;
  bool bottomVisible = false;
  bool errorVisible = false;

  var regex = new RegExp(r'[a-zA-Z]');

  generatePrimes(lowerLimit, upperLimit){
    var listPrimes = List<int>();
    for (var index = lowerLimit; index <= upperLimit; index++){
      if (BigInt.from(index).isPrime()){
        listPrimes.add(index);
      }
    }
    return listPrimes;
  }

  void primeBrain() {
    var lower = int.parse(lowerLimit.replaceAll(' ', '').replaceAll('\n', '').replaceAll(regex, ''));
    var upper = int.parse(upperLimit.replaceAll(' ', '').replaceAll('\n', '').replaceAll(regex, ''));
    /*
    if (lower < 0){
      setState(() {
        bottomVisible = false;
        errorVisible = true;
        errorText = "$lower is not a valid lower limit. Try to enter a number larger than 0.";
      });
    }
    else if (upper < 0){
      setState(() {
        bottomVisible = false;
        errorVisible = true;
        errorText = "$upper is not a valid upper limit. Try to enter a number larger than 0.";
      });
    }
     */
    if (lower > upper){
      setState(() {
        bottomVisible = false;
        errorVisible = true;
        errorText = "$upper is larger than $lower. Enter values, so that upper limit is larger than lower limit.";
      });
    }
    if (lower == upper){
      setState(() {
        bottomVisible = false;
        errorVisible = true;
        errorText = "Upper Limit is the same as Lower Limit. Enter values, so that upper limit is larger than lower limit.";
      });
    }
    else{
      List<int> listPrimes = generatePrimes(lower, upper);
      setState(() {
        bottomVisible = true;
        errorVisible = false;
        showText = listPrimes.join(", ");
      });
    }
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
                      'Prime List',
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .1,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .044,
                    ),
                    Text(
                      "This tool will produce a list of primes, between the limits you enter.",
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
                      maxLength: 5,
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
                              lowerLimit = "";
                              bottomVisible = false;
                              errorVisible = false;
                            });
                          },
                        ),
                        labelText: 'Lower Limit',
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                      onChanged: (String textInput) {
                        setState(() {
                          lowerLimit = textInput;
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
                      maxLength: 5,
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
                              upperLimit = "";
                              bottomVisible = false;
                              errorVisible = false;
                            });
                          },
                        ),
                        labelText: 'Upper Limit',
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                      onChanged: (String textInput) {
                        setState(() {
                          upperLimit = textInput;
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
                        primeBrain();
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
                        'All primes in between ${lowerLimit.replaceAll(' ', '').replaceAll('\n', '').replaceAll(regex, '')} and ${upperLimit.replaceAll(' ', '').replaceAll('\n', '').replaceAll(regex, '')}:',
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