import 'package:api_testing/controller/post_list_controller.dart';
import 'package:api_testing/data/api_service/post_api_service.dart';
import 'package:api_testing/data/model/upload_respose.dart';
import 'package:api_testing/widgets/bottom_nav.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;

class UploadController extends GetxController {
  final PostApiService _postApiService = Get.find();
  final PostListController _postListController = Get.find();
  Rx<UploadState> uploadState = UploadState().obs;
  RxDouble percentage = 0.0.obs;
  void upload(
      {required String title,
      required String body,
      required d.FormData? photo}) {
    uploadState.value = UploadLoading();
    _postApiService
        .uploadPost(
            title: title,
            body: body,
            photo: photo,
            uploadProgress: (send, data) {
              double per = send / data;
              percentage.value = per;
            })
        .then((uploadRespose) {
      uploadState.value = UploadSuccess(uploadRespose);
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Get.off(const BottomNav());

        _postListController.getAllPost();
        uploadState.value = UploadState();
      });
    }).catchError((err) {
      uploadState.value = UploadError();
    });
  }
}

class UploadState {}

class UploadLoading extends UploadState {}

class UploadSuccess extends UploadState {
  final UploadResponse uploadResponse;

  UploadSuccess(this.uploadResponse);
}

class UploadError extends UploadState {}
