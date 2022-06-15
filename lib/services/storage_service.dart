import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService{

  final _storage = FirebaseStorage.instance;

  uploadBytes(String fileName, Uint8List image) async {
    Reference reference = _storage.ref('signatures/${fileName}_${DateTime.now().millisecondsSinceEpoch}.png');
    TaskSnapshot task = await reference.putData(image);
    String? url = await task.ref.getDownloadURL();

    return url;
  }

  uploadFile(String fileName,String taskID, File file, {bool isPdf = false}) async {
    Reference reference = _storage.ref(!isPdf ? 'images/$taskID/$fileName.png' : 'pdf/$taskID.pdf');
    TaskSnapshot task = await reference.putFile(file);
    String? url = await task.ref.getDownloadURL();

    return url;
  }

}