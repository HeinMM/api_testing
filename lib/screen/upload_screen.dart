import 'dart:io';

import 'package:api_testing/controller/upload_controller.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final UploadController _uploadController = Get.put(UploadController());
  final GlobalKey<FormState> _key = GlobalKey();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _title, _body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('upload'.tr),
        centerTitle: true,
      ),
      body: Obx(() {
        UploadState uploadState = _uploadController.uploadState.value;
        if (uploadState is UploadLoading) {
          return  Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Uploading ... ${(_uploadController.percentage*100).toInt()}'),
               const Divider(),
                CircularProgressIndicator(value: (_uploadController.percentage*100),)
              ],
            ),
          );
        } else if (uploadState is UploadError) {
          return const Center(
            child: Text('Somthing wrong'),
          );
        } else if (uploadState is UploadSuccess) {
          return Center(
            child: Text(uploadState.uploadResponse.result ?? ''),
          );
        }
        return Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('Enter Title'),
                  TextFormField(
                    onSaved: (title) {
                      _title = title;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter title';
                      }
                    },
                  ),
                  const Divider(),
                  const Text('Enter Body'),
                  TextFormField(
                    maxLines: 5,
                    minLines: 3,
                    onSaved: (body) {
                      _body = body;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter body';
                      }
                    },
                  ),
                  const Divider(),
                  IconButton(
                      onPressed: () async {
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          setState(() {
                            _image = File(image.path);
                          });
                        }
                      },
                      icon: const Icon(Icons.photo)),
                  (_image == null)
                      ? const SizedBox()
                      : Image.file(
                          _image!,
                          height: 200,
                        ),
                  ElevatedButton(
                      onPressed: () async {
                        d.MultipartFile? multipartFile;
                        d.FormData? formData;
                        if (_image != null) {
                          multipartFile = await d.MultipartFile.fromFile(
                              _image!.path,
                              filename: 'image.png');
                        }
                        if (_key.currentState != null &&
                            _key.currentState!.validate()) {
                          if (multipartFile != null) {
                            formData =
                                d.FormData.fromMap({'photo': multipartFile});
                          }

                          _key.currentState!.save();
                          _uploadController.upload(
                              title: _title ?? '',
                              body: _body ?? '',
                              photo: formData ?? null);
                        }
                      },
                      child:  Text("upload".tr)),
                ],
              ),
            ));
      }),
    );
  }
}
