import 'package:flutter/material.dart';

const Color appColor = Color(0xff1BB6B6);
const Color accentColor = Color(0xffe74c3c);
const Color hintColor = Color(0xff2d3436);
const Color focusColor = Color(0xffb2bec3);
const Color textColor = Color(0xff000000);
const Color scaffoldBackgroundColor = Color(0xfff9f9f9);

const Color greenColor = Color(0xff00EC26);
const Color blueColor = Color(0xff6BEFEF);

const bool testing = true;

Map<int, Color> color = {
  50: Color.fromRGBO(255, 92, 87, .1),
  100: Color.fromRGBO(255, 92, 87, .2),
  200: Color.fromRGBO(255, 92, 87, .3),
  300: Color.fromRGBO(255, 92, 87, .4),
  400: Color.fromRGBO(255, 92, 87, .5),
  500: Color.fromRGBO(255, 92, 87, .6),
  600: Color.fromRGBO(255, 92, 87, .7),
  700: Color.fromRGBO(255, 92, 87, .8),
  800: Color.fromRGBO(255, 92, 87, .9),
  900: Color.fromRGBO(255, 92, 87, 1),
};

MaterialColor materialAppColor = MaterialColor(0xff1BB6B6, color);

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  counterText: "",
  border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green, width: 2.0)),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0)),
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: appColor, width: 2.0)),
);

var button = ElevatedButton(
  child: Text("Rock & Roll"),
  style: ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(10, 10, 10, 10)),
      backgroundColor: MaterialStateProperty.all(Colors.red),
      textStyle: MaterialStateProperty.all(TextStyle(color: Colors.yellow))),
  onPressed: () {},
);

InputDecoration inputDecoration = InputDecoration(
  hintText: 'Value',
  counterText: "",
  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
);
var defalutSizedBox = SizedBox(
  height: 15,
);
var randomColorsList = [
  Colors.redAccent,
  Colors.green,
  Colors.grey,
  Colors.blue,
  Colors.green,
  Colors.blueGrey,
  Colors.lightGreen,
  Colors.yellow,
];

ThemeData themeData = ThemeData(
  fontFamily: 'OpenSans',
  primaryColor: appColor,
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  accentColor: accentColor,
  hintColor: hintColor,
  focusColor: focusColor,
  iconTheme: IconThemeData(color: accentColor),
  buttonTheme: ButtonThemeData(
    buttonColor: appColor,
  ),
  textTheme: TextTheme(
    headline6: TextStyle(fontSize: 22.0, color: textColor),
    headline5: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.w700, color: textColor),
    headline4: TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.w700, color: textColor),
    headline3: TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: textColor),
    headline2: TextStyle(
        fontSize: 26.0, fontWeight: FontWeight.w300, color: textColor),
    subtitle2: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w500, color: textColor),
    subtitle1: TextStyle(
        fontSize: 17.0, fontWeight: FontWeight.w700, color: textColor),
    bodyText1: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: textColor),
    bodyText2: TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.w400, color: textColor),
    caption: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w300, color: textColor),
  ),
);

generalButton(String name, Function onPressed, {Color bgColor = appColor}) {
  return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      child: ElevatedButton(
        child: Text(name),
        style: ButtonStyle(
            padding:
                MaterialStateProperty.all(EdgeInsets.fromLTRB(10, 10, 10, 10)),
            backgroundColor: MaterialStateProperty.all(bgColor),
            textStyle: MaterialStateProperty.all(
                TextStyle(color: Colors.white, fontSize: 15))),
        onPressed: onPressed,
      ));
}

Widget buttonCard(String title) {
  return Card(
    elevation: 2,
    color: appColor,
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      trailing:
          IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: null),
    ),
  );
}

Widget buttonCardArrowWithFunction(String title, Function onPressed,
    {bool showDialog = false}) {
  return InkWell(
    onTap: onPressed,
    child: Card(
      elevation: 2,
      color: appColor,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        trailing:
            IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: null),
      ),
    ),
  );
}
