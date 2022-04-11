import 'package:api_testing/controller/edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditScreen extends StatefulWidget {
  int id;
  String title;
  String body;

  EditScreen(
      {Key? key, required this.id, required this.title, required this.body})
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final EditContoller _editContoller = Get.put(EditContoller());
  final GlobalKey<FormState> _key = GlobalKey();

  String? _title, _body;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _body = widget.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('edit'.tr),//편집
      ),
      body: Obx(() {
        EditState editState = _editContoller.editState.value;
        if (editState is EditLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (editState is EditError) {
          return const Center(
            child: Text('Somthing wrong'),
          );
        } else if (editState is EditSuccess) {
          return Center(
            child: Text(editState.editResponse.result ?? ''),
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
                    initialValue: _title,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter title';
                      }
                    },
                  ),
                  const Divider(),
                  const Text('Enter Body'),
                  TextFormField(
                    initialValue: _body,
                    maxLines: 5,
                    minLines: 3,
                    onSaved: (body) {//test
                      _body = body;

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter body';
                      }
                    },
                  ),
                  const Divider(),
                  ElevatedButton(
                      onPressed: () async {
                        if (_key.currentState != null &&
                            _key.currentState!.validate()) {
                          _key.currentState!.save();
                          _editContoller.edit(
                              id: widget.id,
                              title: _title ?? '',
                              body: _body ?? '');
                        }
                      },
                      child:  Text("edit".tr)),
                ],
              ),
            ));
      }),
    );
  }
}
