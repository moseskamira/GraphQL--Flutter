import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../core/model/post.dart';
import '../../core/service/graphql_service.dart';
import '../widgets/custom_text_form_field.dart';

class UpdatePostPage extends StatefulWidget {
  final Post post;

  const UpdatePostPage({super.key, required this.post});

  @override
  State<UpdatePostPage> createState() => _UpdatePostPageState();
}

class _UpdatePostPageState extends State<UpdatePostPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Post postToUpdate = Post();

  @override
  void initState() {
    super.initState();
    postToUpdate = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Post'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Fill The Form Below'),
                  CustomTextFormField(
                    label: 'Title',
                    onSaved: (value) {
                      if (value != null && value!.isNotEmpty) {
                        postToUpdate.title = value.trim();
                      }
                    },
                    initialValue: postToUpdate.title ?? '',
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    label: 'Body',
                    onSaved: (value) {
                      if (value != null && value!.isNotEmpty) {
                        postToUpdate.body = value.trim();
                      }
                    },
                    initialValue: postToUpdate.body ?? '',
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.blue,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                'Cancel',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.black54,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _formKey.currentState!.save();
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            GraphQLService(
                              client: GraphQLProvider.of(context).value,
                            ).updateFetchedPost(
                              postToUpdate,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.blue,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                'Save',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.black54,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
