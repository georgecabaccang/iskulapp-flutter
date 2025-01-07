import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

class CustomRangePicker {
    static Future<DateTimeRange?> showPicker(BuildContext context) async {
        final DateTimeRange? result = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2000, 1, 1),
            lastDate: DateTime.now(),
            currentDate: DateTime.now(),
            saveText: 'Done',
            builder: (context, child) {
                return Theme(
                    data: ThemeData(
                        colorScheme: ColorScheme.light(
                            primary: AppColors.primaryColor,
                            surface: AppColors.whiteColor,
                            onSurface: AppColors.primaryColor,
                        ),
                        textTheme: TextTheme(
                            bodyMedium: TextStyle(color: Colors.black),
                        ),
                        datePickerTheme: DatePickerThemeData(
                            rangeSelectionBackgroundColor: AppColors.primaryColor.withOpacity(0.2),
                            rangePickerBackgroundColor: AppColors.whiteColor,
                            rangePickerHeaderBackgroundColor: AppColors.primaryColor,
                            rangePickerHeaderForegroundColor: AppColors.whiteColor,
                        ),
                    ),
                    child: child!,
                );
            },
        );

        return result;
    }
}
