import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/infrastructure/api/api_handler.dart';

final categoryProvider = StateNotifierProvider<CategoryNotifier, List>((ref) {
  return CategoryNotifier();
});

class CategoryNotifier extends StateNotifier<List> {
  CategoryNotifier() : super([]);

  Future getCategory() async {
    final data = await ApiHandler().getCategory();
    state = data;
  }

  Future addCategory(String categoryname, WidgetRef ref) async {
    await ApiHandler().addCategory(categoryname, ref);
  }
}
