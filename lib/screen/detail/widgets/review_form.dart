import 'package:flutter/material.dart';
import 'package:mespot/provider/detail/add_review_provider.dart';
import 'package:provider/provider.dart';

class ReviewForm extends StatefulWidget {
  final String restaurantId;
  final VoidCallback onReviewSubmitted;
  const ReviewForm(
      {super.key, required this.restaurantId, required this.onReviewSubmitted});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    final addReviewProvider = context.read<AddReviewProvider>();

    addReviewProvider.addReview(
      widget.restaurantId,
      _nameController.text,
      _reviewController.text,
    );

    if (addReviewProvider.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(context.read<AddReviewProvider>().error ??
                'Gagal menambahkan review')),
      );
      return;
    }
    _nameController.clear();
    _reviewController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _reviewController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Review',
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _submitReview();
                widget.onReviewSubmitted();
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Consumer<AddReviewProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                return const Text('Kirim Review');
              },
            ),
          ),
        ],
      ),
    );
  }
}
