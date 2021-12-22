import 'package:dio/dio.dart';
import 'package:google_map_clone/models/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionRepository {
  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json?";
  Dio? _dio;
  DirectionRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirection(
      {required LatLng origin, required LatLng destination}) async {
    final response = await _dio!.get(_baseUrl, queryParameters: {
      "origin": "${origin.latitude}, ${origin.longitude}",
      "destination": "${destination.latitude}, ${destination.longitude}",
      "key": apiKey,
    });
    print(response);
    return null;
  }
}

const apiKey = "AIzaSyBR1JH1cJwQzPY_QJi-Lrrc6Qnvh9vAmUU";
