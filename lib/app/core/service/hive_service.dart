import 'package:hive_ce_flutter/hive_flutter.dart';
import '../../features/user_list/data/models/user_model.dart';

class HiveService {
  static const String _usersBoxName = 'usersListBox';
  late final Box<UserModel> _usersBox;

  HiveService._();

  /// Initialize Hive and open boxes
  static Future<HiveService> init() async {
    // Initialize Hive only once
    await Hive.initFlutter();

    // Register adapter if not already registered
    if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
      Hive.registerAdapter(UserModelAdapter());
    }

    final service = HiveService._();
    service._usersBox = await Hive.openBox<UserModel>(_usersBoxName);
    return service;
  }

  Box<UserModel> get usersBox => _usersBox;

  /// Cache list of users
  Future<void> cacheUsersList(List<UserModel> users) async {
    if (users.isEmpty) return;

    final Map<dynamic, UserModel> usersMap = {
      for (var user in users) user.id: user,
    };
    await _usersBox.putAll(usersMap);
  }

  /// Get cached users
  List<UserModel> getCachedUsersList() {
    return _usersBox.values.toList();
  }

  /// Clear cache
  Future<void> clearCache() async {
    await _usersBox.clear();
  }
}
