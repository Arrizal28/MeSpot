import 'package:flutter_test/flutter_test.dart';
import 'package:mespot/data/model/restaurant.dart';

void main() {
  group('Restaurant Model Test', () {
    test('should create Restaurant object from JSON correctly', () {
      final Map<String, dynamic> jsonData = {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Lorem ipsum dolor sit amet",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2,
      };

      final result = Restaurant.fromJson(jsonData);

      expect(result.id, "rqdv5juczeskfw1e867");
      expect(result.name, "Melting Pot");
      expect(result.description, "Lorem ipsum dolor sit amet");
      expect(result.pictureId, "14");
      expect(result.city, "Medan");
      expect(result.rating, 4.2);
    });

    test('should convert Restaurant object to JSON correctly', () {
      final restaurant = Restaurant(
        id: "rqdv5juczeskfw1e867",
        name: "Melting Pot",
        description: "Lorem ipsum dolor sit amet",
        pictureId: "14",
        city: "Medan",
        rating: 4.2,
      );

      final result = restaurant.toJson();

      expect(result, {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Lorem ipsum dolor sit amet",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2,
      });
    });

    test('should throw FormatException when JSON is invalid', () {
      final Map<String, dynamic> invalidJson = {
        "id": "rqdv5juczeskfw1e867",
        "description": "Lorem ipsum dolor sit amet",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2,
      };

      expect(
        () => Restaurant.fromJson(invalidJson),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
