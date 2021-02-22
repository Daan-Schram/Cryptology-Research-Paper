import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profielwerkstuk_cryptologie/constants.dart';
import 'widgets/bottom_nav_bar.dart';


class PrimeFactorsPage extends StatefulWidget {

  const PrimeFactorsPage({key}) : super(key: key);

  @override
  _PrimeFactorsPageState createState() => _PrimeFactorsPageState();
}

class _PrimeFactorsPageState extends State<PrimeFactorsPage> {

  String plaintext = "";
  String showText = "";
  String buttonText = "Calculate";

  String errorText = "";

  bool switchVal = false;
  bool bottomVisible = false;
  bool errorVisible = false;

  var regex = new RegExp(r'[a-zA-Z]');

  /*
  factorsOfNegativeNumber(int value){
    var factors = Set<int>();
    final sign = -1;
    final limit = sqrt(value.abs()).toInt();
    for(var divisor = 1; divisor <= limit; divisor++){
      if(value % divisor == 0){
        factors.add(divisor);
        factors.add(divisor * sign);
        factors.add(value ~/ divisor);
        factors.add((value ~/ divisor) * sign);
      }
    }
    return factors;
  }

  factorsOfPositiveNumber(int value){
    var factors = Set<int>();
    final limit = sqrt(value.abs()).toInt();
    for(var divisor = 1; divisor <= limit; divisor++){
      if(value % divisor == 0){
        factors.add(divisor);
        factors.add(value ~/ divisor);
      }
    }
    return factors;
  }

  factor(int value){
    return value.isNegative ? factorsOfNegativeNumber(value): factorsOfPositiveNumber(value);
  }
  */

  List<int> factors(int number) {
    if (number < 2) {
      return [];
    }
    int factor = 2;
    List<int> lstFactors = [];

    while (number / factor != 1) {
      if (number % factor == 0) {
        lstFactors.add(factor);
        number = number ~/ factor;
        factor = 2;
      } else {
        factor++;
      }
    }
    lstFactors.add(factor);
    return lstFactors;
  }

  void primeBrain() {
    var number = int.parse(plaintext.replaceAll(' ', '').replaceAll('\n', '').replaceAll(regex, ''));
      List<int> listPrimes = factors(number);
      if (number > 1){
        setState(() {
          bottomVisible = true;
          errorVisible = false;
          showText = listPrimes.join(", ");
        });
      }
      else{
        setState(() {
          bottomVisible = false;
          errorVisible = true;
          errorText = "There are no prime factors for numbers lower than 2.";
        });
      }
  }

  var _controller = TextEditingController();


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
                      'Prime Factors',
                      style: kMainTitleStyle.copyWith(
                        fontSize: size.width * .1,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .044,
                    ),
                    Text(
                      "This tool will produce the prime factors from an input.",
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
                      maxLength: 9,
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
                              plaintext = "";
                              bottomVisible = false;
                              errorVisible = false;
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
                        'Prime factors of ${plaintext.replaceAll(' ', '').replaceAll('\n', '').replaceAll(regex, '')}:',
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