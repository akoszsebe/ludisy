import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/data/persitance/dao/workout_dao.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';


class BikingWorkoutController extends ControllerMVC {
  final UserState userState = locator<UserState>();
  final WorkOutDao _workOutDao = locator<WorkOutDao>();
  
}
