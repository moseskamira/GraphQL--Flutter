import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graph_ql/presentation/bloc/cubits/posts_cubit.dart';
import 'package:graph_ql/presentation/bloc/cubits/posts_cubit_states.dart';

import '../../data/models/post.dart';
import '../widgets/custom_text_form_field.dart';

class UpdatePostPage extends StatefulWidget {
  final Post post;

  const UpdatePostPage({super.key, required this.post});

  @override
  State<UpdatePostPage> createState() => _UpdatePostPageState();
}

class _UpdatePostPageState extends State<UpdatePostPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Post postToUpdate;

  @override
  void initState() {
    super.initState();
    postToUpdate = widget.post;
  }

  Future<void> _deletePost() async {
    if (postToUpdate.id == null) return;
    context.read<PostsCubit>().deletePost(postToUpdate.id!);
  }

  Future<void> _updatePost() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    context.read<PostsCubit>().updatePost(postToUpdate);
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    Color? color,
    required PostsCubitStates state,
  }) {
    return ElevatedButton(
      onPressed: state is PostUpdateLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.white,
        side: const BorderSide(color: Colors.blue, width: 1),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.black87),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Post'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: BlocConsumer<PostsCubit, PostsCubitStates>(
              listener: (BuildContext context, PostsCubitStates state) {
                if (state is PostUpdateSuccess) {}
                if (state is PostDeleteSuccess) {}
                if (state is PostUpdateError || state is PostDeleteError) {
                  final message = (state as dynamic).errorMessage;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error: $message"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is PostUpdateLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Fill The Form Below',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      label: 'Title',
                      initialValue: postToUpdate.title ?? '',
                      onSaved: (value) => postToUpdate.title = value?.trim(),
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      label: 'Body',
                      initialValue: postToUpdate.body ?? '',
                      onSaved: (value) => postToUpdate.body = value?.trim(),
                    ),
                    const SizedBox(height: 20),
                    state is PostUpdateLoading || state is PostDeleteLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildButton(
                                  text: "Delete",
                                  onPressed: _deletePost,
                                  color: Colors.red,
                                  state: state),
                              _buildButton(
                                  text: "Save",
                                  onPressed: _updatePost,
                                  state: state),
                            ],
                          ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
