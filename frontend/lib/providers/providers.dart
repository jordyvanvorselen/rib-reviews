import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rib_reviews/controllers/events_controller.dart';
import 'package:rib_reviews/controllers/reactions_controller.dart';
import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/repositories/events_repository.dart';
import 'package:rib_reviews/repositories/reactions_repository.dart';
import 'package:rib_reviews/repositories/reviews_repository.dart';
import 'package:rib_reviews/repositories/users_repository.dart';
import 'package:rib_reviews/repositories/venues_repository.dart';
import 'package:rib_reviews/services/reaction_save_service.dart';
import 'package:rib_reviews/services/review_save_service.dart';
import 'package:rib_reviews/services/user_save_service.dart';
import 'package:rib_reviews/utils/api.dart';

class Providers {
  static final secureStorageProvider = Provider<FlutterSecureStorage>(
    (ref) => const FlutterSecureStorage(),
  );

  static final httpClientProvider = Provider<Dio>(
    (ref) => Dio(BaseOptions(
      baseUrl: Env.apiPath().toString(),
      contentType: 'application/json',
    )),
  );

  static final apiClientProvider = Provider<API>(
    (ref) => API(
      storage: ref.watch(secureStorageProvider),
      client: ref.watch(httpClientProvider),
    ),
  );

  static final eventsController = ChangeNotifierProvider<EventsController>(
    (ref) => EventsController(
        ref.watch(venuesRepositoryProvider),
        ref.watch(usersRepositoryProvider),
        ref.watch(reviewsRepositoryProvider),
        ref.watch(eventsRepositoryProvider)),
  );

  static final reactionsController =
      ChangeNotifierProvider<ReactionsController>(
    (ref) => ReactionsController(
      ref.watch(reactionsRepositoryProvider),
      ref.watch(usersRepositoryProvider),
      ref.watch(reviewsRepositoryProvider),
      ref.watch(reactionsSaveServiceProvider),
    ),
  );

  static final reactionsRepositoryProvider = Provider<ReactionsRepository>(
    (ref) => ReactionsRepository(apiClient: ref.watch(apiClientProvider)),
  );

  static final eventsRepositoryProvider = Provider<EventsRepository>(
    (ref) => EventsRepository(apiClient: ref.watch(apiClientProvider)),
  );

  static final reviewsRepositoryProvider = Provider<ReviewsRepository>(
    (ref) => ReviewsRepository(apiClient: ref.watch(apiClientProvider)),
  );

  static final usersRepositoryProvider = Provider<UsersRepository>(
    (ref) => UsersRepository(apiClient: ref.watch(apiClientProvider)),
  );

  static final venuesRepositoryProvider = Provider<VenuesRepository>(
    (ref) => VenuesRepository(apiClient: ref.watch(apiClientProvider)),
  );

  static final userSaveServiceProvider = Provider<UserSaveService>(
    (ref) => UserSaveService(apiClient: ref.watch(apiClientProvider)),
  );

  static final reactionsSaveServiceProvider = Provider<ReactionSaveService>(
    (ref) => ReactionSaveService(apiClient: ref.watch(apiClientProvider)),
  );

  static final reviewSaveServiceProvider = Provider<ReviewSaveService>(
    (ref) => ReviewSaveService(apiClient: ref.watch(apiClientProvider)),
  );
}
