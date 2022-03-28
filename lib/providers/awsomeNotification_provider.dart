// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
//
// class AwesomeNotify extends ChangeNotifier{
//   initializeNotification() async {
//     await AwesomeNotifications().initialize(
//         'resource://drawable/playstore',
//         [
//           NotificationChannel(
//               channelGroupKey: 'basic_tests',
//               channelKey: 'basic_channel',
//               channelName: 'Basic notifications',
//               channelDescription: 'Notification channel for basic tests',
//               defaultColor: Color(0xFF9D50DD),
//               ledColor: Colors.white,
//               importance: NotificationImportance.High,
//             channelShowBadge: true,
//           ),
//         ],
//        );
//     notifyListeners();
//   }
//
//   allowedNotification(BuildContext context) async {
//     await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//                   title: Text('Allow Notification'),
//                   content: Text('Our app would like to send you notification'),
//                   actions: [
//                     TextButton(
//                         onPressed: () {Navigator.pop(context);},
//                         child: Text(
//                           'Don\'t Allow',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 18,
//                           ),
//                         ),),
//                     TextButton(
//                         onPressed: () { AwesomeNotifications().requestPermissionToSendNotifications().then((_) => Navigator.pop(context));},
//                         child: Text(
//                           'Allow',
//                           style: TextStyle(
//                             color: Colors.teal,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),),
//                   ],
//                 ));
//       }
//     });
//     notifyListeners();
//   }
// }
