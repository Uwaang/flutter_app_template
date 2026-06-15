import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_app_template/core/storage/key_value_store.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test(
    'SharedPreferencesKeyValueStore reads, writes, and removes values',
    () async {
      final preferences = await SharedPreferences.getInstance();
      final store = SharedPreferencesKeyValueStore(preferences);

      await store.setString('name', 'Client App');
      await store.setBool('enabled', true);

      expect(store.getString('name'), 'Client App');
      expect(store.getBool('enabled'), isTrue);

      await store.remove('name');

      expect(store.getString('name'), isNull);
    },
  );
}
