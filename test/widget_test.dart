import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mespot/widgets/mespot_search_text_field.dart';
import 'package:mespot/provider/search/search_restaurant_provider.dart';
import 'package:mespot/static/search_restaurant_result_state.dart';
import 'package:provider/provider.dart';

class MockSearchRestaurantProvider extends Mock
    implements SearchRestaurantProvider {}

void main() {
  late MockSearchRestaurantProvider mockSearchRestaurantProvider;

  setUp(() {
    mockSearchRestaurantProvider = MockSearchRestaurantProvider();
  });

  testWidgets('MespotSearchTextField displays TextField',
      (WidgetTester tester) async {
    when(() => mockSearchRestaurantProvider.resultState)
        .thenReturn(SearchRestaurantNoneState());

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<SearchRestaurantProvider>.value(
            value: mockSearchRestaurantProvider,
            child: const MespotSearchTextField(),
          ),
        ),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text("Search..."), findsOneWidget);
  });

  testWidgets('MespotSearchTextField shows initial message',
      (WidgetTester tester) async {
    when(() => mockSearchRestaurantProvider.resultState)
        .thenReturn(SearchRestaurantNoneState());

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<SearchRestaurantProvider>.value(
            value: mockSearchRestaurantProvider,
            child: const MespotSearchTextField(),
          ),
        ),
      ),
    );

    expect(find.text("Search for anything..."), findsOneWidget);
  });

  testWidgets('MespotSearchTextField shows error message',
      (WidgetTester tester) async {
    when(() => mockSearchRestaurantProvider.resultState)
        .thenReturn(SearchRestaurantErrorState("Error message"));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<SearchRestaurantProvider>.value(
            value: mockSearchRestaurantProvider,
            child: const MespotSearchTextField(),
          ),
        ),
      ),
    );

    expect(find.text("Oops! Something went wrong."), findsOneWidget);
  });

  testWidgets('MespotSearchTextField shows no restaurants found',
      (WidgetTester tester) async {
    when(() => mockSearchRestaurantProvider.resultState)
        .thenReturn(SearchRestaurantLoadedState([]));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<SearchRestaurantProvider>.value(
            value: mockSearchRestaurantProvider,
            child: const MespotSearchTextField(),
          ),
        ),
      ),
    );

    expect(find.text("No restaurants found."), findsOneWidget);
  });
}
