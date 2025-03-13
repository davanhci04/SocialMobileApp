import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled/features/storage/domain/storage_repo.dart';

class FirebaseStorageRepo implements StorageRepo{

  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<String?> uploadProfileImageMobile(String path, String filename) {
    return _uploadFile(path, filename, "profile_images");
  }

  @override
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String filename) {
    return _uploadFileBytes(fileBytes, filename, "profile_images");
  }

  /*

  HELPER METHODS - to upload files to storage

  */

  // mobile platforms (file)
  Future<String?> _uploadFile(String path, String filename, String folder) async{
    try {
      // get file
      final file = File(path);

      // fine place to store
      final storageRef = storage.ref().child('$folder/$filename');

      // upload
      final uploadTask = await storageRef.putFile(file);

      // get image download url
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  // web platforms (bytes)
  Future<String?> _uploadFileBytes(Uint8List fileBytes, String filename, String folder) async{
    try {

      // fine place to store
      final storageRef = storage.ref().child('$folder/$filename');

      // upload
      final uploadTask = await storageRef.putData(fileBytes);

      // get image download url
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }
}