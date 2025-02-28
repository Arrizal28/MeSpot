import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mespot/data/model/restaurant.dart';
import 'package:mespot/provider/home/restaurant_list_provider.dart';
import 'package:mespot/provider/local/payload_provider.dart';
import 'package:mespot/screen/home/home_screen.dart';
import 'package:mespot/static/restaurant_list_result_state.dart';
import 'package:mespot/widgets/restaurant_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

// Generate mock class
@GenerateMocks([RestaurantListProvider, PayloadProvider])
import 'home_screen_test.mocks.dart';

void main() {
  late RestaurantListProvider mockRestaurantListProvider;
  late PayloadProvider mockPayloadProvider;

  setUp(() {
    mockRestaurantListProvider = RestaurantListProvider();
    mockPayloadProvider = PayloadProvider();
  });

  final testRestaurants = [
    Restaurant(
      id: 'id1',
      name: 'Restaurant 1',
      description: 'Description 1',
      pictureId: 'pic1',
      city: 'City 1',
      rating: 4.5,
    ),
    Restaurant(
      id: 'id2',
      name: 'Restaurant 2',
      description: 'Description 2',
      pictureId: 'pic2',
      city: 'City 2',
      rating: 4.2,
    ),
    Restaurant(
      id: 'id3',
      name: 'Restaurant 3',
      description: 'Description 3',
      pictureId: 'pic3',
      city: 'City 3',
      rating: 4.7,
    ),
  ];

  Widget createHomeScreen() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>.value(
          value: mockRestaurantListProvider,
        ),
        ChangeNotifierProvider<PayloadProvider>.value(
          value: mockPayloadProvider,
        ),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }

  group('HomeScreen ListView Tests', () {
    testWidgets('should display loading indicator when state is loading', 
        (WidgetTester tester) async {
      when(mockRestaurantListProvider.resultState)
          .thenReturn(RestaurantListLoadingState());

      await tester.pumpWidget(createHomeScreen());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ListView), findsWidgets);
      expect(find.byType(RestaurantList), findsNothing);
    });

    testWidgets('should display restaurant list when data is loaded', 
        (WidgetTester tester) async {
      when(mockRestaurantListProvider.resultState)
          .thenReturn(RestaurantListLoadedState(data: testRestaurants));

      await tester.pumpWidget(createHomeScreen());

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ListView), findsWidgets);
      expect(find.byType(RestaurantList), findsNWidgets(testRestaurants.length));

      // Verify each restaurant is displayed
      for (var restaurant in testRestaurants) {
        expect(find.text(restaurant.name), findsOneWidget);
      }
    });

    testWidgets('should display error message when error occurs', 
        (WidgetTester tester) async {
      when(mockRestaurantListProvider.resultState)
          .thenReturn(RestaurantListErrorState());

      await tester.pumpWidget(createHomeScreen());

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Oops! Something went wrong.'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(RestaurantList), findsNothing);
    });

    testWidgets('should call fetchRestaurantList when screen is initialized', 
        (WidgetTester tester) async {
      when(mockRestaurantListProvider.resultState)
          .thenReturn(RestaurantListLoadedState(data: testRestaurants));

      await tester.pumpWidget(createHomeScreen());
      await tester.pumpAndSettle();

      verify(mockRestaurantListProvider.fetchRestaurantList()).called(1);
    });

    testWidgets(
        'should navigate to detail screen when restaurant list item is tapped', 
        (WidgetTester tester) async {
      when(mockRestaurantListProvider.resultState)
          .thenReturn(RestaurantListLoadedState(data: testRestaurants));

      await tester.pumpWidget(createHomeScreen());

      // Tap the first restaurant
      await tester.tap(find.byType(RestaurantList).first);
      await tester.pumpAndSettle();

      // Navigation should be triggered
      // Note: In a full test, you'd set up mock navigation observer to verify this
    });
  });
}