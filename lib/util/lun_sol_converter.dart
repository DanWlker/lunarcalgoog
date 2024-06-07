import 'package:lunar/lunar.dart';

class LunSolConverter {
  static DateTime lunToSol(Lunar lunDate) {
    final solar = LunarSolarConverter.lunarToSolar(lunDate);
    print('$solar ${lunDate.isLeap}');
    return DateTime(solar.solarYear, solar.solarMonth, solar.solarDay);
  }

  static Lunar solTolun(DateTime solDate) {
    final solar = Solar(
      solarYear: solDate.year,
      solarMonth: solDate.month,
      solarDay: solDate.day,
    );
    return LunarSolarConverter.solarToLunar(solar);
  }
}
