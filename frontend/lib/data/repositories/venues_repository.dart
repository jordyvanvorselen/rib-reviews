import 'package:rib_reviews/data/api.dart';
import 'package:rib_reviews/domain/models/venue.dart';

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
      return Future.error("Could not fetch venues from the server.");
    }
  }
}
