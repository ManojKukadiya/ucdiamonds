import 'package:flutter/material.dart';
import 'package:ucdiamonds/admin/views/admin_homescreen.dart';
import 'package:ucdiamonds/models/transaction_model.dart';
import 'package:ucdiamonds/screens/edit_profile.dart';
import 'package:ucdiamonds/screens/give_away.dart';
import 'package:ucdiamonds/screens/scrach_card.dart';
import 'screens/add_coins.dart';
import 'screens/captcha_screen.dart';
import 'screens/my_spin_wheel.dart';
import 'screens/redeem_points.dart';
import 'screens/redeem_points_list.dart';
import 'screens/redeem_points_request.dart';
import 'screens/settings.dart';
import 'screens/congrats.dart';
import 'screens/daily_bonus.dart';
import 'screens/google_auth.dart';
import 'screens/home.dart';
import 'screens/refer_earn.dart';
import 'screens/splash_screen.dart';
import 'screens/tasks.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case '/Home':
        return MaterialPageRoute(builder: (_) => Home());

      case '/Tasks':
        return MaterialPageRoute(builder: (_) => Tasks());

      case '/GoogleAuth':
        return MaterialPageRoute(builder: (_) => GoogleAuth());

      case '/MySpinWheel':
        return MaterialPageRoute(builder: (_) => MySpinWheel());

      case '/Captcha':
        return MaterialPageRoute(builder: (_) => CaptchScreen());
      case '/Congrats':
        return MaterialPageRoute(
            builder: (_) => Congrats(
                  points: args as int,
                ));

      case '/Settings':
        return MaterialPageRoute(builder: (_) => Settings());
      case '/EditProfile':
        return MaterialPageRoute(builder: (_) => EditProfile());

      case '/DailyBonus':
        return MaterialPageRoute(builder: (_) => DailyBonus());
      case '/ReferEarn':
        return MaterialPageRoute(builder: (_) => ReferEarn());

      case '/RedeemPoints':
        return MaterialPageRoute(builder: (_) => RedeemPoints());
      case '/Admin':
        return MaterialPageRoute(builder: (_) => AdminHomeScreen());
      case '/RedeemPointsList':
        return MaterialPageRoute(
            builder: (_) => RedeemPointsList(
                  redeemWays: args as RedeemWays,
                ));
      case '/RedeemPointRequest':
        return MaterialPageRoute(
            builder: (_) => RedeemPointRequest(
                  points: (args as List)[0],
                  des: (args as List)[1],
                ));

      case '/AddCoins':
        return MaterialPageRoute(
            builder: (_) => AddCoins(
                  coins: (args as List)[0] as int,
                  tranasctionType: (args as List)[1] as TranasctionType,
                ));


        case '/GiveAway':
        return MaterialPageRoute(
            builder: (_) => GiveAway());
      case '/Scratch' :
        return MaterialPageRoute(
            builder: (_) => ScratchCard());
              

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                    body: Center(
                  child: Text(
                    "Screen not found",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                )));
    }
  }
}
