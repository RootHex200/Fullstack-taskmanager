import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/userdata/auth_data.dart';
import 'package:todo_app/infrastructure/api/api_handler.dart';

final authProvider = StateNotifierProvider((ref) {
  return authNotifier();
});

class authNotifier extends StateNotifier {
  authNotifier() : super([]);

  Future signin(AuthData authData) async {
    await ApiHandler().singin(authData);
  }

  Future singup(AuthData authData) async {
    await ApiHandler().singup(authData);
  }

}
