import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/ui/history/history_controller.dart';
import 'package:stairstepsport/src/ui/login/login_controller.dart';
import 'package:stairstepsport/src/ui/profile/profile_controller.dart';
import 'package:stairstepsport/src/ui/settings/settings_controller.dart';
import 'package:stairstepsport/src/ui/splash/splash_controller.dart';
import 'package:stairstepsport/src/ui/start/start_controller.dart';
import 'package:stairstepsport/src/ui/workout/workout_controller.dart';
import 'package:stairstepsport/src/ui/workoutdone/workoutdone_controller.dart';

final GetIt locator = GetIt.instance;

void setupLocator(AppDatabase appDatabase) {
  locator.registerLazySingleton(() => GoogleSignIn(scopes: ['email']));
  locator.registerLazySingleton<AppDatabase>(() => appDatabase);

  locator.registerFactory(() => HistoryController());
  locator.registerFactory(() => LoginController());
  locator.registerFactory(() => ProfileController());
  locator.registerFactory(() => SettingsController());
  locator.registerFactory(() => StartController());
  locator.registerFactory(() => WorkOutController());
  locator.registerFactory(() => WorkOutDoneController());
  locator.registerFactory(() => SplashController());
}
