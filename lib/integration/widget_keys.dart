import 'package:flutter/foundation.dart';

class WidgetKeys {
  static const Key loginHomePage = Key('loginHomePage');
  static const Key itemName = Key('itemName');
  static const Key saveButton = Key('saveButton');
  static const Key listView = Key('listView');

  // Method to generate keys for list items
  static Key itemKey(int index) => Key(index.toString());
}
