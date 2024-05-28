import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:homework_firebase_auth/path_provider_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';


Future<String?> getImageFromPhone(BuildContext context, ImageSource imageSource) async {
  Navigator.pop(context);
  final ImagePicker picker = ImagePicker();
  final XFile? xFile = await picker.pickImage(source: imageSource);

  if(xFile != null){
    final Directory directory = await getApplicationDocumentsDirectory();
    await File(xFile.path).copy('${directory.path}/profileImage.png');
    StorageService.put(xFile.path);
    return "${await getApplicationDocumentsDirectory()}/profile_image.txt";
  }

  return null;
}