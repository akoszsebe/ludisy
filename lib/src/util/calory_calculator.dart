import 'package:ludisy/src/data/model/user_model.dart';

class CaloriCalculator {
  
  static double calculeteCalories(UserModel userData,int duration,int steps){
    return calculateEnergyExpenditure(
          userData.height.toDouble(),
          DateTime(userData.bithDate),
          userData.weight.toDouble(),
          userData.gender == "Male" ? 0 : 1,
          duration,
          steps,
          0.4);
  }

  ///
  /// Calculated the energy expenditure for an activity. Adapted from the following website https://sites.google.com/site/compendiumofphysicalactivities/corrected-mets
  ///
  /// @param height               The height in metres.
  /// @param age                  The date of birth.
  /// @param weight               The weight of the user.
  /// @param gender               The gender of the user.
  /// @param durationInSeconds    The duration of the activity in seconds.
  /// @param stepsTaken           The steps taken.
  /// @param strideLengthInMetres The stride length of the user
  /// @return The number of calories burnt (kCal)
  ///
  static double calculateEnergyExpenditure(
      double height,
      DateTime age,
      double weight,
      int gender,
      int durationInSeconds,
      int stepsTaken,
      double strideLengthInMetres) {
    var ageCalculated = _getAgeFromDateOfBirth(age);

    var harrisBenedictRmR = _convertKilocaloriesToMlKmin(
        _harrisBenedictRmr(
            gender, weight, ageCalculated, height),
        weight);

    var kmTravelled =
        _calculateDistanceTravelledInKM(stepsTaken, strideLengthInMetres);
    var hours = durationInSeconds / 3600;
    var speedInMph = _kmphTOmph(kmTravelled) / hours;
    var metValue = _getMetForActivity(speedInMph);

    var constant = 3.5;

    var correctedMets = metValue * (constant / harrisBenedictRmR);
    return correctedMets * hours * weight;
  }

  ///
  /// Gets a users age from a date. Only takes into account years.
  ///
  /// @param age The date of birth.
  /// @return The age in years.
  ///
  static int _getAgeFromDateOfBirth(DateTime dateOfBirth) {
    DateTime currentDate = DateTime.now();

    if (dateOfBirth.isAfter(currentDate)) {
      throw Exception("Can't be born in the future");
    }
    int currentYear = currentDate.year;
    int dateOfBirthYear = dateOfBirth.year;
    int age2 = currentYear - dateOfBirthYear;
    int currentMonth = currentDate.month;
    int dateOfBirthMonth = dateOfBirth.month;

    if (dateOfBirthMonth > currentMonth) {
      age2--;
    } else if (currentMonth == dateOfBirthMonth) {
      int currentDay = currentDate.month;
      int dateOfBirthDay = dateOfBirth.month;
      if (dateOfBirthDay > currentDay) {
        age2--;
      }
    }

    return age2;
  }

  static double _convertKilocaloriesToMlKmin(
      double kilocalories, double weightKgs) {
    double kcalMin = kilocalories / 1440;
    kcalMin /= 5;

    return ((kcalMin / (weightKgs)) * 1000);
  }

  static double _calculateDistanceTravelledInKM(
      int stepsTaken, double entityStrideLength) {
    return ((stepsTaken * entityStrideLength) / 1000);
  }

  ///
  /// Gets the MET value for an activity. Based on https://sites.google.com/site/compendiumofphysicalactivities/Activity-Categories/walking .
  ///
  /// @param speedInMph The speed in miles per hour
  /// @return The met value.
  ///
  static double _getMetForActivity(double speedInMph) {
    if (speedInMph < 2.0) {
      return 2.0;
    } else if (speedInMph == 2.0) {
      return 2.8;
    } else if (speedInMph > 2.0 && speedInMph <= 2.7) {
      return 3.0;
    } else if (speedInMph > 2.8 && speedInMph <= 3.3) {
      return 3.5;
    } else if (speedInMph > 3.4 && speedInMph <= 3.5) {
      return 4.3;
    } else if (speedInMph > 3.5 && speedInMph <= 4.0) {
      return 5.0;
    } else if (speedInMph > 4.0 && speedInMph <= 4.5) {
      return 7.0;
    } else if (speedInMph > 4.5 && speedInMph <= 5.0) {
      return 8.3;
    } else if (speedInMph > 5.0) {
      return 9.8;
    }
    return 0;
  }

  ///
  /// Calculates the Harris Benedict RMR value for an entity. Based on above calculation for Com
  ///
  /// @param gender   Users gender.
  /// @param weightKg Weight in Kg.
  /// @param age      Age in years.
  /// @param heightCm Height in CM.
  /// @return Harris benedictRMR value.
  ///
  static double _harrisBenedictRmr(
      int gender, double weightKg, int age, double heightCm) {
    if (gender == 1) {
      return 655.0955 +
          (1.8496 * heightCm) +
          (9.5634 * weightKg) -
          (4.6756 * age);
    } else {
      return 66.4730 +
          (5.0033 * heightCm) +
          (13.7516 * weightKg) -
          (6.7550 * age);
    }
  }

  static double _kmphTOmph(double kmph) {
    return 0.6214 * kmph;
  }
}
