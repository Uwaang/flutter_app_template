import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/app/app.dart';

void main() {
  testWidgets('renders the boilerplate home content', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TemplateApp()));
    await tester.pumpAndSettle();

    expect(find.text('Template App'), findsWidgets);
    expect(
      find.text('Ship the next Flutter app without rebuilding the plumbing.'),
      findsOneWidget,
    );
  });
}
