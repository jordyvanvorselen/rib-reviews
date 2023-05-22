import 'package:rib_reviews/models/reaction.dart';
import 'package:rib_reviews/utils/api.dart';

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
