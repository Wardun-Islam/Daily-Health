import 'dart:core';

class Call {
  String callerId;
  String reciverId;
  String token;
  String channelname;
  bool hasCalled;

  Call(this.callerId, this.reciverId, this.token, this.channelname,
      this.hasCalled);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> call = new Map<String, dynamic>();
    call['callerId'] = this.callerId;
    call['reciverId'] = this.reciverId;
    call['token'] = this.token;
    call['channelname'] = this.channelname;
    call['hasCalled'] = this.hasCalled;
    return call;
  }

  static Call fromMap(Map<String, dynamic> callMap) {
    final Call call = new Call(callMap['callerId'], callMap['reciverId'],
        callMap['token'], callMap['channelname'], callMap['hasCalled']);
    return call;
  }
}
