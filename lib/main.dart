import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/app/bootstrap/bootstrap.dart';

void main() {
  bootstrap(() => const ProviderScope(child: TemplateApp()));
}
