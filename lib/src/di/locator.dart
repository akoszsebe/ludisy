import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ludisy/src/data/auth.dart';
import 'package:ludisy/src/data/persitance/dao/user_dao.dart';
import 'package:ludisy/src/data/persitance/dao/workout_dao.dart';
import 'package:ludisy/src/states/ui_state.dart';
import 'package:ludisy/src/states/user_state.dart';
import 'package:ludisy/src/ui/history/history_controller.dart';
import 'package:ludisy/src/ui/login/login_controller.dart';
import 'package:ludisy/src/ui/profile/profile_controller.dart';
import 'package:ludisy/src/ui/settings/settings_controller.dart';
import 'package:ludisy/src/ui/splash/splash_controller.dart';
import 'package:ludisy/src/ui/start/start_controller.dart';
import 'package:ludisy/src/ui/workout/rollerskating/rollerskating_workout_controller.dart';
import 'package:ludisy/src/ui/workout/stairing/stairing_workout_controller.dart';
import 'package:ludisy/src/ui/workout/biking/biking_workout_controller.dart';
import 'package:ludisy/src/ui/workoutsummary/biking/biking_workoutsummary_controller.dart';
import 'package:ludisy/src/ui/workoutsummary/rollerskating/rollerskating_workoutsummary_controller.dart';
import 'package:ludisy/src/ui/workoutsummary/stairing/stairing_workoutsummary_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ludisy/src/util/style/map_style.dart';
import 'package:pedometer/pedometer.dart';
import 'package:location/location.dart';

final GetIt locator = GetIt.instance;

void setupLocator(FirebaseApp firebaseApp) {
  // Services
  locator.registerLazySingleton(() => GoogleSignIn(scopes: ['email']));
  locator.registerLazySingleton(() => FirebaseAuth.fromApp(firebaseApp));
  locator.registerLazySingleton(() => Auth());
  locator.registerLazySingleton(() => provideFirebase(firebaseApp));
  locator.registerFactory<DatabaseReference>(() => provideUserRef(),
      instanceName: "userFirebaseDao");
  locator.registerLazySingleton<UserDao>(() => UserDaoImpl());
  locator.registerLazySingleton<WorkOutDao>(() => WorkOutDaoImpl());
  locator.registerLazySingleton(() => Pedometer());
  locator.registerLazySingleton(() => Location());
  locator.registerLazySingleton(() => AppMapStyle());
  // States
  locator.registerLazySingleton(() => UserState());
  locator.registerLazySingleton(() => UiState());
  // Controllers
  locator.registerFactory(() => HistoryController());
  locator.registerFactory(() => LoginController());
  locator.registerFactory(() => ProfileController());
  locator.registerFactory(() => SettingsController());
  locator.registerFactory(() => StartController());
  locator.registerFactory(() => StairingWorkoutController());
  locator.registerFactory(() => StairingWorkoutSummaryController());
  locator.registerFactory(() => BikingWorkoutController());
  locator.registerFactory(() => BikingWorkoutSummaryController());
  locator.registerFactory(() => SplashController());
  locator.registerFactory(() => RollerSkatingWorkoutController());
  locator.registerFactory(() => RollerSkatingWorkoutSummaryController());
}

DatabaseReference provideUserRef() {
  var userRef = locator<FirebaseDatabase>().reference().child('user');
  userRef.keepSynced(true);
  return userRef;
}

FirebaseDatabase provideFirebase(FirebaseApp firebaseApp) {
  var database = FirebaseDatabase(app: firebaseApp);
  database.setPersistenceEnabled(true);
  database.setPersistenceCacheSizeBytes(80000000);
  return database;
}
