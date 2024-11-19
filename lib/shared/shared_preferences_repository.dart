import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/shared/shared_preferences_keys.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  SharedPreferencesAsync prefs = SharedPreferencesAsync();
  //final List<String> _items = [];
  bool writeActive = false;

  @override
  Future<void> addItem(String item) async {
    writeActive = true;
    List<String>? myItems = await prefs.getStringList(tasklist_key);
    myItems ??= [];

    if (item.isNotEmpty && !myItems.contains(item)) {
      myItems.add(item);

      log("Add item $item Start Write");

      await prefs.setStringList(tasklist_key, myItems);
      log("Stopp write");
    }
    writeActive = false;
  }

  @override
  Future<void> deleteItem(int index) async {
    writeActive = true;
    List<String>? myItems = await prefs.getStringList(tasklist_key);
    myItems ??= [];
    if (0 <= index && index < myItems.length) {
      log("Deleted Item at index: $index");
      myItems.removeAt(index);
      await prefs.setStringList(tasklist_key, myItems);
    }
    writeActive = false;
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    writeActive = true;
    List<String>? myItems = await prefs.getStringList(tasklist_key);
    myItems ??= [];
    if (newItem.isNotEmpty && !myItems.contains(newItem)) {
      log("Edit Item: ${myItems[index]} -> $newItem at index: $index");
      myItems[index] = newItem;
      prefs.setStringList(tasklist_key, myItems);
    }
    writeActive = false;
  }

  @override
  Future<List<String>> getItems() async {
    while (writeActive) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    List<String>? myItems = await prefs.getStringList(tasklist_key);
    log("getItems myItems.length: ${myItems!.length}");

    myItems ??= [];
    //makes the same as:
    // if (myItems == null) {
    //   myItems = [];
    // }
    return myItems;
  }

  @override
  Future<int> get itemCount async {
    List<String>? myItems = await prefs.getStringList(tasklist_key);
    myItems ??= [];

    return myItems.length;
  }
}
