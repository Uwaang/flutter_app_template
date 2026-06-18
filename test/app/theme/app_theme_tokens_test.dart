import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_template/app/theme/app_radius.dart';
import 'package:flutter_app_template/app/theme/app_spacing.dart';

void main() {
  test('spacing tokens expose stable app layout increments', () {
    expect(AppSpacing.xs, 8);
    expect(AppSpacing.sm, 12);
    expect(AppSpacing.md, 16);
    expect(AppSpacing.lg, 24);
    expect(AppSpacing.screen.left, AppSpacing.lg);
    expect(AppSpacing.card.top, AppSpacing.lg);
  });

  test('radius tokens expose stable surface radii', () {
    expect(AppRadius.sm, 8);
    expect(AppRadius.md, 16);
    expect(AppRadius.lg, 24);
    expect(AppRadius.xl, 28);
    expect(AppRadius.large.topLeft.x, AppRadius.lg);
    expect(AppRadius.hero.topLeft.x, AppRadius.xl);
  });
}
