import 'package:api_testing/controller/post_list_controller.dart';
import 'package:api_testing/data/model/post_list_model.dart';
import 'package:api_testing/widgets/post_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final PostListController _postListController = Get.put(PostListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text('posts'.tr),//게시
          centerTitle: true,
        ),
        body: Obx(() {
          PostListState state = _postListController.postListState.value;
          if (state is PostListLoading) {
            return ListView(
              children: [
                for (var i = 0; i < 10; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Shimmer.fromColors(
                      child: Container(
                        height: 30,
                        color: Colors.blueGrey.shade50,
                      ),
                      baseColor: Colors.blueGrey.shade50,
                      highlightColor: Colors.white60,
                    ),
                  )
              ],
            );
          } else if (state is PostListSuccess) {
            List<PostListModel> postList = state.postLists;
            return PostList(
              posts: postList,
            );
          } else if (state is PostListError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return const Center();
        }));
  }
}
