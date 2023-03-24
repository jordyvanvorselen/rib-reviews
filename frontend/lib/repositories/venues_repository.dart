import 'dart:convert';

import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/venue.dart';
import 'package:rib_reviews/utils/api.dart';

class VenuesRepository {
  API apiClient;

  VenuesRepository({required this.apiClient});

  Future<List<Venue>> all() async {
    try {
      final venuesUrl = Env.apiPath("/venues");
      final venuesResponse = await apiClient.get(venuesUrl);

      List<Venue> venues = jsonDecode(venuesResponse)
          .map<Venue>((json) => Venue.fromJson(json))
          .toList();

      return venues;
    } on Exception catch (_) {
      return Future.error("Could not fetch venues from the server.");
    }
  }
}
