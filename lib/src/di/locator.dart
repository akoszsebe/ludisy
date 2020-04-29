import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ludisy/src/data/persitance/dao/user_dao.dart';
import 'package:ludisy/src/data/persitance/dao/workout_dao.dart';
import 'package:ludisy/src/data/persitance/database.dart';
import 'package:ludisy/src/states/user_state.dart';
import 'package:ludisy/src/ui/history/history_controller.dart';
import 'package:ludisy/src/ui/login/login_controller.dart';
import 'package:ludisy/src/ui/profile/profile_controller.dart';
import 'package:ludisy/src/ui/settings/settings_controller.dart';
import 'package:ludisy/src/ui/splash/splash_controller.dart';
import 'package:ludisy/src/ui/start/start_controller.dart';
import 'package:ludisy/src/ui/workout/workout_controller.dart';
import 'package:ludisy/src/ui/workoutdone/workoutdone_controller.dart';

final GetIt locator = GetIt.instance;

void setupLocator(String databasePath) {
  // Services
  locator.registerLazySingleton(() => GoogleSignIn(scopes: ['email']));
  locator.registerLazySingleton<AppDatabase>(() => AppDatabaseImpl(databasePath));
  locator.registerLazySingleton<UserDao>(() => UserDaoImpl());
  locator.registerLazySingleton<WorkOutDao>(() => WorkOutDaoImpl());
  // States
  locator.registerLazySingleton(() => UserState());
  // Controllers
  locator.registerFactory(() => HistoryController());
  locator.registerFactory(() => LoginController());
  locator.registerFactory(() => ProfileController());
  locator.registerFactory(() => SettingsController());
  locator.registerFactory(() => StartController());
  locator.registerFactory(() => WorkOutController());
  locator.registerFactory(() => WorkOutDoneController());
  locator.registerFactory(() => SplashController());
}
