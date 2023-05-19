import 'package:flutter/foundation.dart';
import 'package:rib_reviews/models/venue.dart';
import 'package:rib_reviews/utils/api.dart';

class VenuesRepository {
  API apiClient;

  VenuesRepository({required this.apiClient});

  Future<List<Venue>> all() async {
    try {
      final venuesResponse =
          (await apiClient.get('/venues').run()).getOrElse((l) => throw l);

      List<Venue> venues = venuesResponse.data
          .map<Venue>((json) => Venue.fromJson(json))
          .toList();

      return venues;
    } on Exception catch (_) {
      debugPrint(_.toString());
      return Future.error("Could not fetch venues from the server.");
    }
  }
}
