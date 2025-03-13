import 'dart:typed_data';

abstract class StorageRepo {
  // upload profile image on mobile platform
  Future<String?> uploadProfileImageMobile(String path, String filename);
  // upload profile image on web platform
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String filename);
}