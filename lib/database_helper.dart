import 'package:hive_flutter/hive_flutter.dart';

class User {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String createdAt;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'created_at': createdAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
      createdAt: map['created_at'] as String? ?? '',
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static const _boxName = 'users_box';
  static bool _initialized = false;

  Box get _box => Hive.box(_boxName);

  Future<void> init() async {
    if (_initialized) return;
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
    _initialized = true;

    // Seed akun default jika box kosong
    if (_box.isEmpty) {
      await _box.put('admin@sepatu.com', {
        'id': 1,
        'name': 'Admin',
        'email': 'admin@sepatu.com',
        'phone': '081234567890',
        'password': 'admin123',
        'created_at': DateTime.now().toIso8601String(),
      });
    }
  }

  // CREATE
  Future<void> insertUser(User user) async {
    if (_box.containsKey(user.email)) {
      throw Exception('EMAIL_DUPLICATE');
    }
    final id = _box.length + 1;
    await _box.put(user.email, {
      'id': id,
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'password': user.password,
      'created_at': user.createdAt,
    });
  }

  // READ ALL
  List<User> getAllUsers() {
    return _box.values
        .map((m) => User.fromMap(Map<String, dynamic>.from(m as Map)))
        .toList();
  }

  // READ by email
  User? getUserByEmail(String email) {
    final data = _box.get(email);
    if (data == null) return null;
    return User.fromMap(Map<String, dynamic>.from(data as Map));
  }

  // LOGIN check
  User? login(String email, String password) {
    final user = getUserByEmail(email);
    if (user == null || user.password != password) return null;
    return user;
  }

  // UPDATE
  Future<void> updateUser(User user) async {
    await _box.put(user.email, user.toMap());
  }

  // DELETE
  Future<void> deleteUser(String email) async {
    await _box.delete(email);
  }

  int getUserCount() => _box.length;
}
