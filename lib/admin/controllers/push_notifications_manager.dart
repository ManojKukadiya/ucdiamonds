import 'dart:convert';

import 'package:http/http.dart' as http;

class PushNotificationsManager {
  sendNotificationToTopic(String title, String message) async {
    try {
      var url = 'https://fcm.googleapis.com/fcm/send';
      var header = {
        "Content-Type": "application/json",
        "Authorization":
            "key=AAAAZcEZFLY:APA91bHstOkb8obrXyRUseS2UHZ-FfoVfLxsR4cPjmvKGUzRGiIl4Pzc0eWVcP7TXC2Jf_HnHl0X0Vz4ahjyeZur2E5yMLWdq4V40z4jJ1MftuWHXn8knxmIBdgF39h259S_b_ZI_UBR",
      };
      var request = {
        "notification": {"body": message, "title": title},
        "priority": "high",
        "to": "/topics/All",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "status": "done",
          "sound": 'default',
          "body": message,
          "title": title
        },
      };

      var response = await http.post(Uri.parse(url),
          headers: header, body: json.encode(request));

      if (response != null) {
        print(response.statusCode.toString() +
            " response : " +
            response.body.toString());
      } else {
        print("response is null");
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
