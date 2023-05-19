import 'package:http_mock_adapter/http_mock_adapter.dart';

void initFakeApi(DioAdapter dioAdapter) {
  dioAdapter
    ..onGet(
      '/venues',
      (server) => server.reply(
        200,
        [
          {
            "_id": "1",
            "location": "Helmond",
            "name": "Mo-Jo",
            "website": "https://mo-jo.eu/en/"
          },
          {
            "_id": "2",
            "location": "Weert",
            "name": "De Slak",
            "website": "https://deslak.com/nederweert/"
          }
        ],
        delay: const Duration(seconds: 1),
      ),
    )
    ..onGet(
      '/reviews',
      (server) => server.reply(
        200,
        [
          {
            "_id": "1",
            "createdAt": "2023-05-19 14:42:04.994",
            "eventId": "1",
            "rating": 1.5,
            "text": "Test",
            "userId": "1"
          }
        ],
        delay: const Duration(seconds: 1),
      ),
    )
    ..onGet(
      '/events',
      (server) => server.reply(
        200,
        [
          {"_id": "1", "date": "2022-08-11 18:00:00", "venueId": "1"},
          {"_id": "2", "date": "2024-08-11 18:00:00", "venueId": "2"}
        ],
        delay: const Duration(seconds: 1),
      ),
    )
    ..onGet(
      '/users',
      (server) => server.reply(
        200,
        [
          {
            "_id": "1",
            "displayName": "Jordy van Vorselen",
            "email": "jordy.van.vorselen@kabisa.nl",
            "photoUrl":
                "https://lh3.googleusercontent.com/a/AGNmyxb2leu0Zt91Fx8M80myLas7B6YwdyICzTrm1uIo=s96-c"
          }
        ],
        delay: const Duration(seconds: 1),
      ),
    );
}
