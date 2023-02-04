import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'FavoriteIconButton tests: ',
    () {
      testWidgets(
        'onTap() callback is executed when tapping on button',
        (widgetTester) async {
          bool value = false;
          await widgetTester.pumpWidget(
            MaterialApp(
              locale: const Locale('en'),
              localizationsDelegates: const [
                ComponentLibraryLocalizations.delegate,
              ],
              home: Scaffold(
                body: FavoriteIconButton(
                  isFavorite: false,
                  onTap: () {
                    value = !value;
                  },
                ),
              ),
            ),
          );

          await widgetTester.tap(
            find.byType(FavoriteIconButton),
          );

          expect(value, true);
        },
      );
    },
  );
}
