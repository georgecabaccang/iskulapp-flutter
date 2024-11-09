import 'package:flutter/material.dart';
import 'package:school_erp/dtos/assessment_taker_dto.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/models/teacher.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_takers/widgets/assessment_section_row.dart';
import 'package:school_erp/theme/colors.dart';

class AssessmentTakersForm extends StatefulWidget {
  final Assessment? assessment;
  const AssessmentTakersForm({this.assessment, super.key});

  @override
  _AssessmentTakersFormState createState() => _AssessmentTakersFormState();
}

class _AssessmentTakersFormState extends State<AssessmentTakersForm> {
  List<Section> activeSections = [];
  List<AssessmentTakerUpdateDTO> assessmentTakerUpdateDTOs = [];
  List<String> removedTakers = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    activeSections = await Teacher.activeSections();
    if (widget.assessment != null) {
      var takers = await widget.assessment!.assessmentTakers();
      setState(() {
        // not ideal since if you have something that needs to be displayed that is not covered by toUpdateDTO
        // or retain the takers but that means you need to update the dto and that model when you want to render something
        assessmentTakerUpdateDTOs =
            takers.map((taker) => taker.toUpdateDTO()).toList();
      });
    } else {
      _addChoice();
    }
  }

  void _addChoice() {
    setState(() {
      var newTaker = AssessmentTakerUpdateDTO(
        null,
        assessmentId: widget.assessment?.id,
        sectionId: null,
        startTime: DateTime.now().add(const Duration(minutes: 30)),
        deadLine: DateTime.now().add(const Duration(days: 1)),
      );
      assessmentTakerUpdateDTOs.add(newTaker);
    });
  }

  void _removeChoice(int index) {
    if (assessmentTakerUpdateDTOs.length > 1) {
      removedTakers.add(assessmentTakerUpdateDTOs[index].sectionId!);
      setState(() {
        assessmentTakerUpdateDTOs.removeAt(index);
      });
    }
  }

  void _updateAssessmentTaker(
      int index, AssessmentTakerUpdateDTO updatedTaker) {
    if (index < assessmentTakerUpdateDTOs.length) {
      setState(() {
        assessmentTakerUpdateDTOs[index] = updatedTaker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: ListView.separated(
                  itemCount: assessmentTakerUpdateDTOs.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 25),
                  itemBuilder: (context, idx) {
                    return AssessmentSectionRow(
                      index: idx,
                      key: ValueKey(assessmentTakerUpdateDTOs[idx].id),
                      activeSections: activeSections,
                      assessmentTakerUpdateDTO: assessmentTakerUpdateDTOs[idx],
                      onAssessmentTakerChanged: (updatedTaker) =>
                          _updateAssessmentTaker(idx, updatedTaker),
                      onAddPressed: _addChoice,
                      onRemovePressed: () => _removeChoice(idx),
                      onClearPressed: () {
                        var taker = assessmentTakerUpdateDTOs[idx];
                        _updateAssessmentTaker(
                          idx,
                          AssessmentTakerUpdateDTO(
                            taker.id,
                            assessmentId: taker.assessmentId,
                            sectionId: taker.sectionId,
                            startTime: taker.startTime,
                            deadLine: taker.deadLine,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => (),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: Size(double.infinity,
                      MediaQuery.of(context).size.height * 0.08),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
