import 'package:flutter/material.dart';
import 'package:school_erp/enums/filter_base_enum.dart';
import 'package:school_erp/theme/colors.dart';

enum AttendanceFilterEnum implements BaseEnum{
    all,
    absent,
    late,
    holiday;

    @override
    Color get color {
        switch (this) {
            case AttendanceFilterEnum.all:
                return Colors.white;
            case AttendanceFilterEnum.absent:
                return AppColors.dangerColor;
            case AttendanceFilterEnum.late:
                return AppColors.warningColor;
            case AttendanceFilterEnum.holiday:
                return AppColors.successColor;

        }
    }

    @override
    Color get borderColor {
        switch (this) {
            case AttendanceFilterEnum.all:
                return Colors.grey;
            case AttendanceFilterEnum.absent:
            case AttendanceFilterEnum.late:
            case AttendanceFilterEnum.holiday:
                return Colors.transparent;

        }
    }

    @override
    String get label {
        switch (this) {
            case AttendanceFilterEnum.all:
                return 'All';
            case AttendanceFilterEnum.absent:
                return 'Absent';
            case AttendanceFilterEnum.late:
                return 'Late';
            case AttendanceFilterEnum.holiday:
                return 'Holiday';

        }
    }
}