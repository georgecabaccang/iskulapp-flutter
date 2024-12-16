import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/dropdowns/form_drop_down_list.dart';

class DropDownForm extends StatefulWidget {
    final List<FormDropDownList> dropDowns;

    const DropDownForm({
        super.key, 
        required this.dropDowns
    });

    @override
    createState() => _DropDownFormState();
}


class _DropDownFormState extends State<DropDownForm> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    late String selectedValue;

    @override
    Widget build(BuildContext context) {
        return Expanded(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                        children: widget.dropDowns,
                    ),
                )
            )
        );
    }
}