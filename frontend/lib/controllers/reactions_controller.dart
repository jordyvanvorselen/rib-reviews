import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rib_reviews/models/reaction.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/repositories/reactions_repository.dart';
import 'package:rib_reviews/repositories/reviews_repository.dart';
import 'package:rib_reviews/repositories/users_repository.dart';
import 'package:rib_reviews/services/reaction_save_service.dart';

class ReactionsController with ChangeNotifier {
  final ReactionsRepository reactionsRepository;
  final UsersRepository usersRepository;
  final ReviewsRepository reviewsRepository;
  final ReactionSaveService reactionSaveService;

  List<Reaction> _reactions = [];
  List<Reaction> get reactions => _reactions;

  ReactionsController({
    required this.reactionsRepository,
    required this.usersRepository,
    required this.reviewsRepository,
    required this.reactionSaveService,
  });

  void toggleReaction(String emoji, Review review, User user) {
    Reaction? reaction = _reactions
        .firstWhereOrNull((r) => r.emoji == emoji && r.review.id == review.id);

    final index = _reactions.indexWhere((r) => r.id == reaction?.id);
    final reactionExists = index != -1;

    reaction ??= Reaction(
      id: '',
      emoji: emoji,
      users: [],
      review: review,
    );

    reaction.isPlacedBy(user)
        ? reaction.users.removeWhere((u) => u.id == user.id)
        : reaction.users.add(user);

    if (reaction.users.isEmpty) {
      fetchReactions();
    } else {
      reactionExists ? _reactions[index] = reaction : _reactions.add(reaction);
    }

    reactionSaveService.save(reaction);

    notifyListeners();
  }

  void fetchReactions() async {
    final users = await usersRepository.all();
    final reviews = await reviewsRepository.all(users);

    _reactions = await reactionsRepository.all(users, reviews);

    notifyListeners();
  }
}
