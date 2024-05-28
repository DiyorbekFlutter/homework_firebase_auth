import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homework_firebase_auth/path_provider_service.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


Future<bool> deleteProfileImageDialog(BuildContext context, String path) async {
  bool deleted = false;
  await Future.delayed(const Duration(milliseconds: 250));
  if(!context.mounted) return deleted;
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                CircleAvatar(foregroundImage: Image.file(File(path)).image),
                const SizedBox(width: 15),
                const Expanded(
                  child: Text("Profile rasmini o'chirish",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Text("Profile rasmi o'chirilsinmi?"),
            const SizedBox(height: 15),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ZoomTapAnimation(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Bekor qilish",
                      style: TextStyle(
                        color: Color(0xff5793C3),
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                  ZoomTapAnimation(
                    onTap: () async {
                      File(path).delete();
                      StorageService.put('');
                      deleted = true;
                      Navigator.pop(context);
                    },
                    child: const Text(
                        "Rasmni o'chirish",
                        style: TextStyle(
                            color: Color(0xffCE4342),
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                ]
            ),
            const SizedBox(height: 15),
          ],
        ),
      )
  );

  return deleted;
}