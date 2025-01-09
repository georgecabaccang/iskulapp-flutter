import 'package:flutter/material.dart';
import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/theme/colors.dart';

// NOTE: Implment EntityDisplayData to what class you're going to pass here as T.
class FormDropDownList<T extends EntityDisplayData> extends StatelessWidget {
    final T? selectedValue;
    final List<T> options;
    final String label;
    final String hint;
    final String errorMessage;
    final ValueChanged<T?> onChangedFn; 
    final bool isLoading;

    const FormDropDownList({
        super.key, 
        required this.selectedValue, 
        required this.options, 
        required this.label,
        required this.hint,
        required this.errorMessage,
        required this.onChangedFn,
        this.isLoading = false, 
    });

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.all(16.0),
            child: 
            isLoading ? Center(
                    child: CircularProgressIndicator(),
                ) :
                FormField<String>(
                    builder: (state) {
                        return DropdownButtonFormField<T>(
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
                            onChanged: (T? newValue) {
                                onChangedFn(newValue);
                            },
                            validator: (value) {
                                if (value == null) {
                                    return errorMessage;
                                }
                                return null;
                            },
                            dropdownColor: AppColors.whiteColor,
                            items: options
                                .map((T option) {
                                        return DropdownMenuItem(
                                            value: option,
                                            child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxWidth: 300.0,
                                                ),
                                                child: Text(
                                                    option.displayName,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                ),
                                            ),
                                        );
                                    })
                                .toList(),
                        );
                    },
                ),
        );
    }
}