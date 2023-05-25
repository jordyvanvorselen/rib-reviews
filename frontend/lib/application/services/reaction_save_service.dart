import 'package:rib_reviews/data/api.dart';
import 'package:rib_reviews/domain/models/reaction.dart';

class ReactionSaveService {
  API apiClient;

  ReactionSaveService({required this.apiClient});

  Future<Reaction> save(Reaction reaction) async {
    try {
      (await apiClient.put('/reactions', reaction.toJson()).run())
          .getOrElse((l) => throw l);

      return reaction;
    } on Exception catch (_) {
      return Future.error("Could not save reaction.");
    }
  }
}
