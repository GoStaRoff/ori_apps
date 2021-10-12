import 'dart:math' as Math;

double calculateDistanceMeters(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = Math.cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * Math.asin(Math.sqrt(a)) * 1000;
}

double calculateAngle(y1, y2, x1, x2) =>
    180 + Math.atan2(y2 - y1, x2 - x1) * (180 / Math.pi);
