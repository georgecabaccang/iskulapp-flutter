import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/forms/buttons/form_button.dart';
import 'package:school_erp/pages/common_widgets/forms/inputs/form_input.dart';

class FormModal extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String title;
  final List<FormInput> textFields;
  final List<FormButton> formButtons;

  const FormModal({
    super.key,
    required this.formKey,
    required this.title,
    required this.textFields,
    required this.formButtons,
  });

  @override
  createState() => _FormModal();
}

class _FormModal extends State<FormModal> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: FloatingActionButton(
        onPressed: () {
          _showAddPostDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddPostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.title),
          content: Form(
              key: widget.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.textFields,
              )),
          actions: widget.formButtons,
        );
      },
    );
  }
}
