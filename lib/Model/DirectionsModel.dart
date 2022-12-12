import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinepoint;
  final String totaleDistance;
  final String totaleDuration;
  const Directions(
      {required this.bounds,
      required this.polylinepoint,
      required this.totaleDistance,
      required this.totaleDuration});
  static Directions? fromMap(Map<String, dynamic> map) {
    if ((map['routes'] as List).isEmpty) return null;
    final data = Map<String, dynamic>.from(map['routes'][0]);
    final northeast = data['bounds']['northeast'];
    final northwest = data['bounds']['northwest'];
    final bounds = LatLngBounds(
      southwest: LatLng(northwest['lat'], northwest['lng']),
      northeast: LatLng(northeast['lat'], northeast['lng']),
    );
    String distance = '';
    String duration = '';
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }
    return Directions(
      bounds: bounds,
      polylinepoint:
          PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totaleDistance: distance,
      totaleDuration: duration,
    );
  }
}
