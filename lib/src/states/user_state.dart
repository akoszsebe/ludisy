import 'dart:collection';

import 'package:ludisy/src/data/model/day_model.dart';
import 'package:ludisy/src/data/model/user_model.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/data/persitance/dao/user_dao.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:pedometer/pedometer.dart';

class UserState {
  UserState();

  final UserDao _userDao = locator<UserDao>();
  final Pedometer _pedometer = locator<Pedometer>();
  User _userModel = User();
  int _allSteps = 0;
  Map<int, DayQuickInfoModel> _dailyInfoMap = Map();

  Future<void> initState(String userId) async {
    _userModel = await _userDao.getUser(userId);
    if (_userModel != null) {
      print("init user - ${_userModel.toJson()}");
    } else {
      print("init user - null");
    }
    if (_userModel != null) {
      fillDailyInfoMap();
      _pedometer.pedometerStream.first.then((value) {
        _allSteps = value;
      });
    }
  }

  void fillDailyInfoMap() {
    var dateTime = DateTime.now();
    var morrning = DateTime(dateTime.year, dateTime.month, dateTime.day);
    var night =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59)
            .millisecondsSinceEpoch;
    var workoutsForCurrentDay = _userModel.workOuts
        .where((x) =>
            x.timeStamp >= morrning.millisecondsSinceEpoch &&
            x.timeStamp <= night)
        .toList();
    DayQuickInfoModel quickInfoModel = DayQuickInfoModel("step");
    var size = -1;
    workoutsForCurrentDay
        .where((element) => element.type == 0)
        .forEach((element) {
      size++;
      quickInfoModel.value += (element.data as Stairs).stairsCount;
      quickInfoModel.durationSec += element.duration;
    });
    if (size != -1) {
      quickInfoModel.avgValue = (quickInfoModel.value / size + 1);
    }
    _dailyInfoMap[0] = quickInfoModel;
  }

  DayQuickInfoModel getDayQuickInfoModelForType(int type) {
    return _dailyInfoMap.containsKey(type)
        ? _dailyInfoMap[type]
        : DayQuickInfoModel("");
  }

  User getUserData() {
    return _userModel;
  }

  Future<void> setUserData(User data) async {
    await _userDao.insertOrUpdateUser(data);
    _userModel = data;
  }

  int getAllSteps() {
    return _allSteps;
  }

  void addSteps(int steps) {
    _allSteps += steps;
  }

  Future<void> removeUserData(User user) async {
    _userModel = User();
  }
}
