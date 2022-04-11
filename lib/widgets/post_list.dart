
import 'package:api_testing/data/model/post_list_model.dart';
import 'package:api_testing/screen/blog_post_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostList extends StatelessWidget {
  final List<PostListModel>? posts;
  const PostList({this.posts, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: posts!.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.to(BlogPostDetail(
                  id: posts![index].id ?? 0, title: posts![index].title ?? "",));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: (Text(posts![index].title ?? ''))),
              ),
            ),
          );
        });
  }
}
