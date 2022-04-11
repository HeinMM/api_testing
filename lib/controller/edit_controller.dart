import 'package:api_testing/controller/post_list_controller.dart';
import 'package:api_testing/data/api_service/post_api_service.dart';
import 'package:api_testing/data/model/edit_response.dart';
import 'package:api_testing/widgets/bottom_nav.dart';
import 'package:get/get.dart';

class EditContoller extends GetxController {
  final PostApiService _postApiService = Get.find();
  final PostListController _postListController = Get.find();
  Rx<EditState> editState = EditState().obs;
  void edit({required int id, required String title, required String body}) {
    editState.value = EditLoading();
    _postApiService.editPost(id: id, title: title, body: body).then((value) {
      editState.value = EditSuccess(value);
      Future.delayed(const Duration(seconds: 1)).then((value) {
        // Get.off();
        Get.offAll(const BottomNav());
        _postListController.getAllPost();
        editState.value = EditState();
      });
    }).catchError((err) {
      editState.value = EditError();
    });
    ;
  }
}

class EditState {}

class EditLoading extends EditState {}

class EditSuccess extends EditState {
  final EditResponse editResponse;

  EditSuccess(this.editResponse);
}

class EditError extends EditState {}
