import 'package:flutter/material.dart';
import '../constants.dart';

class BottomNavBar extends StatelessWidget {

  const BottomNavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavItem(
            title: "Paper",
            icon: Icons.file_present,
            press: (){
              Navigator.of(context).pushNamedAndRemoveUntil('/paper', (Route<dynamic> route) => false);
            },
          ),
          BottomNavItem(
            title: "Home",
            icon: Icons.home_outlined,
            press: (){
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
            },
          ),
          BottomNavItem(
            title: "Info",
            icon: Icons.info_outline_rounded,
            press: (){
              Navigator.of(context).pushNamedAndRemoveUntil('/info', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }

}


class BottomNavItem extends StatelessWidget {

  final String title;
  final IconData icon;
  final Function press;

  const BottomNavItem({
    Key key, this.title, this.icon, this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FlatButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          height: 50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: press,
          child: Column(
            children: [
              Icon(
                icon,
                color: kTextColor,
              ),
              Text(
                title,
                style: kHeadStyle.copyWith(
                  fontSize: 16,
                  color: kTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



/*
class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index){
        setState(() {
          _currentIndex = index;
          if (_currentIndex == 1){
            Navigator.pushNamed(context, '/home');
          }
          else if (_currentIndex == 2){
            Navigator.of(context).pushNamedAndRemoveUntil('/aboutus', (Route<dynamic> route) => false);
          }
        });
      },
      unselectedItemColor: Colors.blueGrey[300],
      selectedItemColor: kTextColor,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: kHeadStyle.copyWith(fontSize: 14),
      unselectedLabelStyle: kHeadStyle.copyWith(fontSize: 12),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_drive_file),
          label: "Paper",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_rounded),
          label: "About us",
        ),
      ],
    );
  }
}
*/
