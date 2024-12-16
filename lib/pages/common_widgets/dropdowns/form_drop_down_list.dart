import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

class FormDropDownList extends StatelessWidget {
    final String? selectedValue;
    final List<String> options;
    final String label;
    final String hint;
    final String errorMessage;
    final void Function(String?) onChangedFn; 

    const FormDropDownList({
        super.key, 
        required this.selectedValue, 
        required this.options, 
        required this.label,
        required this.hint,
        required this.errorMessage,
        required this.onChangedFn,
    });

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormField<String>(
                builder: (state) {
                    return DropdownButtonFormField<String>(
                        value: selectedValue,
                        hint: Text(hint),
                        decoration: InputDecoration(
                            labelText: label,
                            labelStyle: TextStyle(
                                color: AppColors.secondaryFontColor, 
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.primaryColor, 
                                    width: 2.0, 
                                ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.greyColor, 
                                    width: 1.0,
                                ),
                            ),
                        ),
                        onChanged: (String? newValue) {
                            onChangedFn(newValue);
                        },
                        validator: (value) {
                            if (value == null || value.isEmpty) {
                                return errorMessage;
                            }
                            return null;
                        },
                        dropdownColor: AppColors.whiteColor,
                        items: options
                            .map((String option) {
                                    return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                    );
                                })
                            .toList(),
                    );
                },
            ),
        );
    }
}