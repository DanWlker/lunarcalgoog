import 'package:lunar_calendar_converter/lunar_solar_converter.dart';

class LunSolConverter {
  static DateTime lunToSol(Lunar lunDate) {
    Solar solar = LunarSolarConverter.lunarToSolar(lunDate);
    return DateTime(solar.solarYear, solar.solarMonth, solar.solarDay);
  }

  static Lunar solTolun(DateTime solDate) {
    Solar solar = Solar(
      solarYear: solDate.year,
      solarMonth: solDate.month,
      solarDay: solDate.day,
    );
    return LunarSolarConverter.solarToLunar(solar);
  }

  static bool isLeapYear(int year) {
    if(year.toDouble() % 4 != 0)
      return false;
    else if (year.toDouble() % 100 != 0)
      return true;
    else if (year.toDouble() % 400 == 0)
      return true;
    else return false;
  }
}
