import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../core/model/post.dart';
import '../../core/service/graphql_service.dart';
import '../widgets/custom_text_form_field.dart';

class PostDetailsPage extends StatefulWidget {
  final String postId;

  const PostDetailsPage({super.key, required this.postId});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Post postToUpdate = Post();
  bool showEditPostForm = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: GraphQLService(client: GraphQLProvider.of(context).value)
            .postDetail(widget.postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No Data Found'));
          }
          Post post = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Post Title',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${post.title}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.blueGrey[800],
                        ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Post Body',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${post.body}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                  SizedBox(height: 20),
                  if (!showEditPostForm)
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showEditPostForm = !showEditPostForm;
                          });
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Edit Post',
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
                    ),
                  SizedBox(height: 20),
                  showEditPostForm
                      ? Form(
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
                                ),
                                SizedBox(height: 10),
                                CustomTextFormField(
                                  label: 'Body',
                                  onSaved: (value) {
                                    if (value != null && value!.isNotEmpty) {
                                      postToUpdate.body = value.trim();
                                    }
                                  },
                                ),
                                SizedBox(height: 20),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showEditPostForm =
                                                !showEditPostForm;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          postToUpdate.id = widget.postId;
                                          GraphQLService(
                                            client: GraphQLProvider.of(context)
                                                .value,
                                          ).updateFetchedPost(
                                            postToUpdate,
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
