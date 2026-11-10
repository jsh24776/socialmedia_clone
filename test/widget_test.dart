import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:socialmedia_clone/socialmedia.dart';

Future<void> scrollTo(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 12; attempt++) {
    if (finder.evaluate().isNotEmpty) {
      await tester.ensureVisible(finder.first);
      await tester.pumpAndSettle();
      return;
    }

    await tester.drag(find.byType(ListView).first, const Offset(0, -500));
    await tester.pumpAndSettle();
  }

  fail('Could not scroll to $finder');
}

void main() {
  testWidgets('social media feed scrolls to the final post', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Socialmedia()));

    await scrollTo(tester, find.text('Johnson Stewart'));

    expect(find.text('Johnson Stewart'), findsOneWidget);
  });

  testWidgets('comments can be added and are retained when reopening a post', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: Socialmedia()));

    await scrollTo(tester, find.text('Comment'));
    final firstCommentButton = find.text('Comment').first;
    await tester.tap(firstCommentButton);
    await tester.pumpAndSettle();

    await scrollTo(tester, find.byKey(const Key('comment-input')));
    await tester.enterText(
      find.byKey(const Key('comment-input')),
      'A new test comment',
    );
    await tester.tap(find.byKey(const Key('submit-comment')));
    await tester.pumpAndSettle();

    expect(find.text('A new test comment'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);

    tester.state<NavigatorState>(find.byType(Navigator)).pop();
    await tester.pumpAndSettle();
    await scrollTo(tester, find.text('25 Comments'));
    expect(find.text('25 Comments'), findsOneWidget);

    await scrollTo(tester, find.text('Comment'));
    final reopenedCommentButton = find.text('Comment').first;
    await tester.tap(reopenedCommentButton);
    await tester.pumpAndSettle();

    await scrollTo(tester, find.text('A new test comment'));
    expect(find.text('A new test comment'), findsOneWidget);
  });
}
