import 'dart:io';
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled/features/storage/domain/storage_repo.dart';

class FirebaseStorageRepo implements StorageRepo {
  final storage = Supabase.instance.client.storage;

  @override
  Future<String?> uploadPostImageMobile(String path, String fileName) {
    return _uploadFile(path, fileName, 'post_images');
  }

  @override
  Future<String?> uploadPostImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadFileBytes(fileBytes, fileName, 'post_images');
  }

  @override
  Future<String?> uploadProfileImageMobile(String path, String fileName) {
    return _uploadFile(path, fileName, 'profile_images');
  }

  @override
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadFileBytes(fileBytes, fileName, 'profile_images');
  }

// mobile platforms (file)
  Future<String?> _uploadFile(String path, String filename, String folder) async {
    try {
      // Lấy file
      final file = File(path);
      final pathNew = '$folder/$filename';

      // Upload file
      await storage.from('images').upload(pathNew, file);

      // Lấy URL công khai
      final downloadUrl = storage.from('images').getPublicUrl(pathNew);

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

// web platforms (bytes)
  Future<String?> _uploadFileBytes(Uint8List fileBytes, String filename, String folder) async {
    try {
      // Đường dẫn lưu trữ trong bucket
      final pathNew = '$folder/$filename';

      await storage.from('images').uploadBinary(pathNew, fileBytes);
      // Lấy URL công khai
      final downloadUrl = storage.from('images').getPublicUrl(pathNew);

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }
}
