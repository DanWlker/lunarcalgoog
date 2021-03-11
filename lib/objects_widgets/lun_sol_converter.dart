import 'package:lunar_calendar_converter/lunar_solar_converter.dart';

class LunSolConverter {
  static DateTime lunToSol(Lunar lunDate) {
    Solar solar = LunarSolarConverter.lunarToSolar(lunDate);
    print("${solar} ${lunDate.isLeap}");
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
}
