import 'package:api_testing/controller/post_list_controller.dart';
import 'package:api_testing/data/api_service/post_api_service.dart';
import 'package:api_testing/data/model/delete_response.dart';
import 'package:api_testing/widgets/bottom_nav.dart';
import 'package:get/get.dart';

class DeleteController extends GetxController {
  final PostApiService _postApiService = Get.find();
  final PostListController _postListController = Get.find();
  Rx<DeleteState> deleteState = DeleteState().obs;

  
  void delete({required int id}) {
    deleteState.value = DeleteLoading();
    _postApiService.deletePost(id: id).then((value) {
      deleteState.value = DeleteSuccess(value);
      Get.offAll(() => const BottomNav());
      _postListController.getAllPost();
      deleteState.value = DeleteError();
    }).catchError((err) {
      deleteState.value = DeleteError();
    });
  }
}

class DeleteState {}

class DeleteLoading extends DeleteState {}

class DeleteSuccess extends DeleteState {
  final DeleteResponse deleteResponse;

  DeleteSuccess(this.deleteResponse);
}

class DeleteError extends DeleteState {}
