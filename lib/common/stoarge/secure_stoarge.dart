import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) => FlutterSecureStorage());