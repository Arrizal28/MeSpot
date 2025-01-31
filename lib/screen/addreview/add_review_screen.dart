import 'package:flutter/material.dart';
import 'package:mespot/provider/detail/add_review_provider.dart';
import 'package:mespot/provider/detail/restaurant_detail_provider.dart';
import 'package:mespot/static/add_review_result_state.dart';
import 'package:provider/provider.dart';

class AddReviewScreen extends StatefulWidget {
  final String restaurantId;
  const AddReviewScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() async {
    final addReviewProvider = context.read<AddReviewProvider>();

    await addReviewProvider.fetchAddReview(
      widget.restaurantId,
      _nameController.text,
      _reviewController.text,
    );

    if (addReviewProvider.resultState is AddReviewLoadedState) {
      _nameController.clear();
      _reviewController.clear();

      if (mounted) {
        context
            .read<RestaurantDetailProvider>()
            .fetchRestaurantDetail(widget.restaurantId);

        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add review"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 26,
            ),
            Form(
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
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text("Kirim riview"),
                  ),
                  Consumer<AddReviewProvider>(
                    builder: (context, value, child) {
                      return switch (value.resultState) {
                        AddReviewLoadedState() => (() {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      const Text('Berhasil menambahkan review'),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                  action: SnackBarAction(
                                    label: 'Tutup',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    },
                                  ),
                                ),
                              );
                            });
                            return const SizedBox();
                          })(),
                        AddReviewErrorState() => (() {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      const Text('Gagal menambahkan review'),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  action: SnackBarAction(
                                    label: 'Tutup',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    },
                                  ),
                                ),
                              );
                            });
                            return const SizedBox();
                          })(),
                        _ => const SizedBox()
                      };
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
