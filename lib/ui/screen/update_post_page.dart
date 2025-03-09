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
  late Post postToUpdate;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    postToUpdate = widget.post;
  }

  Future<void> _deletePost() async {
    if (postToUpdate.id == null) return;
    setState(() => isLoading = true);
    try {
      bool response = await GraphQLService(
        client: GraphQLProvider.of(context).value,
      ).deleteSelectedPost(postToUpdate.id!);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response
              ? "Post deleted successfully!"
              : "Failed to delete post."),
          backgroundColor: response ? Colors.blue : Colors.red,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _updatePost() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => isLoading = true);
    try {
      await GraphQLService(
        client: GraphQLProvider.of(context).value,
      ).updateFetchedPost(postToUpdate);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Post updated successfully!"),
          backgroundColor: Colors.blue,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Fill The Form Below',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                isLoading
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
                              color: Colors.red),
                          _buildButton(
                            text: "Save",
                            onPressed: _updatePost,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
