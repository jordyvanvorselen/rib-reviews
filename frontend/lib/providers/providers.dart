import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rib_reviews/providers/events_provider.dart';
import 'package:rib_reviews/repositories/events_repository.dart';
import 'package:rib_reviews/services/review_save_service.dart';
import 'package:rib_reviews/services/user_save_service.dart';
import 'package:rib_reviews/utils/api.dart';

import '../repositories/reviews_repository.dart';
import '../repositories/users_repository.dart';
import '../repositories/venues_repository.dart';

class Providers {
  static final secureStorageProvider = Provider<FlutterSecureStorage>(
    (ref) => const FlutterSecureStorage(),
  );

  static final httpClientProvider = Provider<http.Client>(
    (ref) => http.Client(),
  );

  static final apiClientProvider = Provider<API>(
    (ref) => API(
      storage: ref.watch(secureStorageProvider),
      client: ref.watch(httpClientProvider),
    ),
  );

  static final eventsProvider = ChangeNotifierProvider<EventsProvider>(
    (ref) => EventsProvider(
        venuesRepository: ref.watch(venuesRepositoryProvider),
        usersRepository: ref.watch(usersRepositoryProvider),
        reviewsRepository: ref.watch(reviewsRepositoryProvider),
        eventsRepository: ref.watch(eventsRepositoryProvider)),
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

  static final reviewSaveServiceProvider = Provider<ReviewSaveService>(
    (ref) => ReviewSaveService(apiClient: ref.watch(apiClientProvider)),
  );
}
