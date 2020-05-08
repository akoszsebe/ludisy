import 'package:ludisy/src/data/model/day_model.dart';
import 'package:ludisy/src/data/model/user_model.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/data/persitance/dao/user_dao.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/util/assets.dart';

class UserState {
  UserState();

  final UserDao _userDao = locator<UserDao>();
  User _userModel = User();
  Map<int, DayQuickInfoModel> _dailyInfoMap = Map();
  final List<int> supportTypes = [0, 1];
  int _selelectedWorkoutIndex = 0;

  Future<void> initState(String userId) async {
    _userModel = await _userDao.getUser(userId);
    if (_userModel != null) {
      print("init user - ${_userModel.toJson()}");
    } else {
      print("init user - null");
    }
    if (_userModel != null) {
      fillDailyInfoMap();
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
    supportTypes.forEach((type) {
      DayQuickInfoModel quickInfoModel = DayQuickInfoModel("");
      switch (type) {
        case 0:
          quickInfoModel = DayQuickInfoModel("step");
          quickInfoModel.imageName = AppSVGAssets.stairing;
          break;
        case 1:
          quickInfoModel = DayQuickInfoModel("km");
          quickInfoModel.imageName = AppSVGAssets.biking;
          break;
      }
      var size = -1;
      workoutsForCurrentDay
          .where((element) => element.type == type)
          .forEach((element) {
        size++;
        quickInfoModel.value += (element.data as Stairs).stairsCount;
        quickInfoModel.durationSec += element.duration;
      });
      if (size != -1) {
        quickInfoModel.avgValue = (quickInfoModel.value / (size + 1));
      }

      _dailyInfoMap[type] = quickInfoModel;
    });
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

  void addWorkout(WorkOut workOut) {
    _userModel.workOuts.add(workOut);
    fillDailyInfoMap();
  }

  Future<void> removeUserData(User user) async {
    _userModel = User();
  }

  void setSelelectedWorkoutIndex(int index){
    _selelectedWorkoutIndex = index;
  }

  int getSelelectedWorkoutIndex(){
    return _selelectedWorkoutIndex;
  }
}
