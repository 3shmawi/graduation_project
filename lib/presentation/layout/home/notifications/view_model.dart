import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation/domain/model/notification.dart';
import 'package:donation/presentation/auth/auth_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class HandleNotification {
  final _fireStore = FirebaseFirestore.instance;

  Stream<List<NotificationModel>> getNotifications() {
    return _fireStore
        .collection("users")
        .doc(AuthCtrl.usrId)
        .collection('notifications')
        .orderBy("created_at", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => NotificationModel.fromJson(doc.data()))
          .toList();
    });
  }

  Stream<bool> isNotificationOpened() {
    return _fireStore
        .collection("users")
        .doc(AuthCtrl.usrId)
        .snapshots()
        .map((snapshot) {
      return snapshot.data()!["opened"];
    });
  }

  void sendNotification(NotificationModel notification) async {
    _fireStore
        .collection("users")
        .doc(notification.to!.id)
        .collection("notifications")
        .doc(notification.id)
        .set(notification.toJson(), SetOptions(merge: true));
    _fireStore.collection("users").doc(notification.from!.id).set(
      {"opened": false},
      SetOptions(merge: true),
    );

    sendFCMMessage(
      notification.to!.id,
      "New Message From donation app",
      notification.title,
    );
  }

  Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "donation-4de07",
      "private_key_id": "b243cf744c9500c2543b1cd98972c956d1eb95f8",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCx5iWOsKiqrEUv\nK6rMTu7EraLx78b1XoY1xyOFurMwzqhFETPOps+rSEAAjrjCFTzirpVChyFM/RsP\nXH3bzp29A5kmRVPAKL8p4zQJ3k5PPiou9A58L9HOFcOMHORbojiDf76BVVn0i17K\nvv+/A2VU0Pp0JU1ib5lppm1SNcrpvBMlEosAlbDDhVEyolnHUNpaGBDev6N1TpHl\nij5po7vaoAC0KznTWwuI4kTLBnCc22LRDxRjWYm1CXMkULml+pnbheqVSv3Pgypb\nW3Bk28kqSU5RXcoQXexCjU7N8YYYtAi4umvrZ/Wn2voGFEZVzNS4IHTZLw1vP+X5\nENt+1hvZAgMBAAECggEAAoxuYo9NlUdbROAaZeumEEeAB3kEx8hbQhs4my536XW2\nc6nZzQa3AChMcW2aAD7LZOB1JzM2IwsXt4Y+z9azjA0IhUO2PdEfnvcgLFmE0+4L\nLunEaNtLBUmqx9+0lkr6Rgj/Fs19GMuj16H5mjgPXDITunT72TKJ1zmBBK3cWrGW\nw/bxbrUtQXGm75F1tSdRwQcuDQ4uNtbnHf1QwVO98sjIG+ipznc3/qSNLf5yw+Yt\nWEjzbO82leZ3BXe6lStcv+xDZJX7i1oWc4FfBBmKcIP+dgUEj4B8Ahgcl5eIdBZe\nfhq7Z0MKBwvXqntFkCOTZG3GydamuCBaDM3JF5unQQKBgQD1/vfke18gOhyGvHsJ\nkgQb9q/sGtnNOWWEhM03zz3xjM6JAneKJu2dyrrlz73hyIUnDokm/YDDsX/zo+vR\nr1slCcVcr7Gqk9o7liCxhg+1gBRGvN9iYZuHJ4gbOQ7I1fzS40WEWcXwTluFU7Br\nMNE28DGhRur2zll4ghqMecFaQQKBgQC5IjrabBkXrapDf+VSJ3RfrZ/QcnGSvll4\nkLZHW09j+oYjbBj9yp5Qo6iPrJ5GaOv/Tmw9QJcFcjEkLTJYxd1W8+Zv4GJQLTTm\nBQxABSAdmhHcqljSxGPYUeVZ1fNkyBBidMTlY6LUAfkkyQnUa5mMzmWU7cvTnPYO\nzpEteg5rmQKBgQCjgwjvXHoMh9PyU1JNODt3AvBItkhTu3UZMtTd5ek8p+WY+ITQ\n1bNYEStOGloSvCCVp3nO6u4uJcvw/OKBDFg/NFF1nGsyAPksZkvw9DV45VuU8XJi\niJLCsaosvi5vnJ1i6CKLKMkDRHJdGxXHCjnmlJ3In8UKrHqYOZLAESZOgQKBgBiI\ntb3uZ2Dg7dhmIZDCk8R+MNih4fUtbpPwsYdBTYMVVyNoluNDL7nGBneLy6nPC79Y\nuDVh0uGw4VxG9Q4Yop18UwRuevjfFMyKzLXLOBdULJvOo1jDF+w55igCl2+6p5k0\nmkc/7fski8zZK4lP/RhQ3dtfrAxOF7mcnFanfzO5AoGAGfnwpRBIDD12X1/yNYCW\nX8mPDGC2PfQEBwvMNJLZx1kW+FePHc1kmwCjQU5E3pTy1Vjto1UEBGvdCoeyy09F\n1Fjjb8nPgRfw2ifhSJbTibJqRjsBJ0jefAFyDsAUveC19+zIu6rqTmtsAvVsxQ/A\nsPzFaxHf7WybBVVu9BzwGF0=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-w1cip@donation-4de07.iam.gserviceaccount.com",
      "client_id": "101919373884639790471",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-w1cip%40donation-4de07.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    // Obtain the access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    // Close the HTTP client
    client.close();

    // Return the access token
    return credentials.accessToken.data;
  }

  Future<void> sendFCMMessage(String topic, String title, String body) async {
    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: "aaa@yahoo.com", password: "12345678");
    final String serverKey = await getAccessToken(); // Your FCM server key
    const String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/donation-4de07/messages:send';
    final currentFCMToken = await FirebaseMessaging.instance.getToken();
    print("fcmkey : $currentFCMToken");
    final Map<String, dynamic> message = {
      'message': {
        'topic': topic, // Token of the device you want to send the message to
        'notification': {'body': body, 'title': title},
        'data': {
          'current_user_fcm_token': currentFCMToken,
          // Include the current user's FCM token in data payload
        },
      }
    };

    final http.Response response = await http.post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('FCM message sent successfully');
    } else {
      print('Failed to send FCM message: ${response.statusCode}');
    }
  }
}
