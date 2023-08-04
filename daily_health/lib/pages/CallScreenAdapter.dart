import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_health/pages/pickup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../Call.dart';

class CallScreenAdapter extends StatelessWidget {
  Widget widget;
  CallScreenAdapter({widget: Widget}) {
    this.widget = widget;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("call")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .snapshots(),
      builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data.data() != null) {
          Call call = Call.fromMap(snapshot.data.data());
          if (!Call.fromMap(snapshot.data.data()).hasCalled) {
            String name = "";
            print(call.channelname);
            FirebaseFirestore.instance
                .collection("users")
                .doc(call.callerId)
                .get()
                .then((value) {
              name = value["first name"] + " " + value["last name"];
              return PickupScreen(call: call, name: name);
            });
            return PickupScreen(call: call, name: name);
          } else {
            return widget;
          }
        } else {
          return widget;
        }
      },
    );
  }
}
