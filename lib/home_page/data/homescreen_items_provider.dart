
import 'package:demofirst/home_page/models/homepage_items_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../rest/rest_client_provider.dart';

final homeScreenItemsListProvider = FutureProvider<HomePageItems>((ref) async {
  final restClient = ref.read(restClientProvider);
  try {
    final response = await restClient.getAllItems();
    if (kDebugMode) {
      print("API Response: $response");
    }
    final allItems = HomePageItems.fromJson(response);
    return allItems;
  } catch (e, stackTrace) {
    if (kDebugMode) {
      print("Error occurred: $e");
      print("StackTrace: $stackTrace");
    }
    return HomePageItems(result: []);
  }
});
