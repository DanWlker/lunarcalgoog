import 'package:lunar/lunar.dart';

class LunSolConverter {
  static DateTime lunToSol(Lunar lunDate) {
    final solar = lunDate.getSolar();
    return DateTime(
      solar.getYear(),
      solar.getMonth(),
      solar.getDay(),
      solar.getHour(),
      solar.getMinute(),
      solar.getSecond(),
    );
  }

  static Lunar solTolun(DateTime solDate) {
    final solar = Solar.fromDate(solDate.toLocal());
    return Lunar.fromSolar(solar);
  }
}
