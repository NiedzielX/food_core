import 'package:flutter/foundation.dart';
import 'package:food_core/food_core/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';

enum UserStatusType {
  none, register, skip
}

@JsonSerializable()
class UserStatus {

  UserStatusType type;
  DateTime date;

  UserStatus({@required UserStatusType type, DateTime date}): type = type, date = new DateTime(date.year, date.month + Constants.monthAfterShowScreenRegister, date.day);

  bool checkDate() {
    if (type == UserStatusType.register) {
      return false;
    }
    if(type == UserStatusType.none) {
      return true;
    }
    var data2 = DateTime.now();
    if(type == UserStatusType.skip && date.isBefore(data2)) {
      return true;
    }
    return false;
  }

  factory UserStatus.fromJson(Map<String, dynamic> parsedJson) {
    UserStatus status = UserStatus(
        type: UserStatusType.values[parsedJson['type'] as int],
        date: DateTime.fromMillisecondsSinceEpoch(parsedJson['date'] as int)
    );
    return status;
  }

  Map<String, dynamic> toJson() => _$UserStatusToJson(this);

  Map<String, dynamic> _$UserStatusToJson(UserStatus status) => <String, dynamic>{
    'type': status.type.index,
    'date': status.date.millisecondsSinceEpoch
  };

}