class Venue {
  final String id;
  final String location;
  final String name;
  final String website;

  Venue(
      {required this.id,
      required this.location,
      required this.name,
      required this.website});

  factory Venue.fromJson(dynamic json) {
    return Venue(
      id: json['_id'],
      location: json['location'],
      name: json['name'],
      website: json['website'],
    );
  }
}
