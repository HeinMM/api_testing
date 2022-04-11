import 'package:api_testing/controller/blog_post_controller.dart';
import 'package:api_testing/controller/delete_controller.dart';
import 'package:api_testing/data/api_service/post_api_service.dart';
import 'package:api_testing/data/model/blog_post.dart';
import 'package:api_testing/screen/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BlogPostDetail extends StatefulWidget {
  final int id;
  final String title;

  const BlogPostDetail({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  State<BlogPostDetail> createState() => _BlogPostDetailState();
}

class _BlogPostDetailState extends State<BlogPostDetail> {
  final BlogPostContoller _blogPostContoller = Get.put(BlogPostContoller());
  final DeleteController _deleteController = Get.put(DeleteController());

  @override
  void initState() {
    super.initState();
    _blogPostContoller.getPost(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Obx(() {
        BlogPostState blogPostState = _blogPostContoller.blogpPostState.value;
        // DeleteState deleteState = _deleteController.deleteState.value;
        if (blogPostState is BlogPostSuccess) {
          BlogPost post = blogPostState.blogpost;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(post.title ?? '')),
              ),
              const Divider(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(post.body ?? ''),
                ),
              ),
              const Divider(),
              (post.photo == null)
                  ? const SizedBox()
                  : Image.network(
                      "${PostApiService.baseUrl}/${post.photo}",
                      height: 300,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(EditScreen(
                          id: widget.id,
                          title: widget.title,
                          body: post.body ?? ''));
                    },
                    child:  Text('edit'.tr),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _deleteController.delete(id: widget.id);
                    },
                    child:  Text('delete'.tr),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ],
              )
            ],
          );
        }
        if (blogPostState is BlogPostError) {
          return const Center(
            child: Text('Error'),
          );
        }
        if (blogPostState is BlogPostLoading) {
          return Shimmer.fromColors(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: Colors.blueGrey.shade50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      color: Colors.blueGrey.shade50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      color: Colors.blueGrey.shade50,
                    ),
                  ],
                ),
              ),
              baseColor: Colors.blueGrey.shade50,
              highlightColor: Colors.white60);
        }
        return const SizedBox();
      }),
    );
  }
}
