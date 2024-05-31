import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:digital_notebook/presentation/widgets/avatar.dart';
void main() {
  testWidgets('CircleAvatarWidget shows popup menu and navigates correctly', (WidgetTester tester) async {
    // Define a mock navigator observer to track navigation events
    final mockObserver = MockNavigatorObserver();

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: const Scaffold(
          body: CircleAvatarWidget(routeName: '/logoutRoute'),
        ),
        navigatorObservers: [mockObserver],
        routes: {
          '/updateProfile': (context) => const Scaffold(body: Text('Update Profile Page')),
          '/logoutRoute': (context) => const Scaffold(body: Text('Logout Page')),
        },
      ),
    );

    // Ensure the widget tree is printed to the console
    debugDumpApp();

    // Check if the PopupMenuButton is present
    final popupMenuButtonFinder = find.byType(PopupMenuButton<String>);
    print(popupMenuButtonFinder.evaluate().toList()); // Debugging statement

    // Ensure the PopupMenuButton is found before interacting
    expect(popupMenuButtonFinder, findsOneWidget);

    // Open the popup menu
    await tester.tap(popupMenuButtonFinder);
    await tester.pumpAndSettle();

    // Verify the menu items
    expect(find.text('Update Profile'), findsOneWidget);
    expect(find.text('Delete Account'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);

    // Test navigation to update profile
    await tester.tap(find.text('Update Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Update Profile Page'), findsOneWidget);

    // Rebuild the widget for logout test
    await tester.pumpWidget(
      MaterialApp(
        home: const Scaffold(
          body: CircleAvatarWidget(routeName: '/logoutRoute'),
        ),
        navigatorObservers: [mockObserver],
        routes: {
          '/updateProfile': (context) => const Scaffold(body: Text('Update Profile Page')),
          '/logoutRoute': (context) => const Scaffold(body: Text('Logout Page')),
        },
      ),
    );

    await tester.tap(popupMenuButtonFinder);
    await tester.pumpAndSettle();

    // Test navigation to logout
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(find.text('Logout Page'), findsOneWidget);
  });
}

// MockNavigatorObserver class to observe navigation
class MockNavigatorObserver extends NavigatorObserver {
  final List<Route> navigationHistory = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    navigationHistory.add(route);
  }
}
