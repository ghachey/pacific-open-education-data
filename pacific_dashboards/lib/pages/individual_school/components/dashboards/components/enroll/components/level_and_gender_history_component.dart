import 'package:flutter/material.dart';
import 'package:pacific_dashboards/pages/individual_school/components/dashboards/components/enroll/components/enroll_data_by_grade_component.dart';
import 'package:pacific_dashboards/pages/individual_school/components/dashboards/components/enroll/enroll_data.dart';
import 'package:pacific_dashboards/res/strings/strings.dart';
import 'package:pacific_dashboards/shared_ui/mini_tab_layout.dart';
import 'package:pacific_dashboards/res/themes.dart';

class LevelAndGenderHistoryComponent extends StatefulWidget {
  final List<EnrollDataByGradeHistory> data;

  const LevelAndGenderHistoryComponent({
    Key key,
    @required this.data,
  })  : assert(data != null),
        super(key: key);

  @override
  _LevelAndGenderHistoryComponentState createState() =>
      _LevelAndGenderHistoryComponentState();
}

class _LevelAndGenderHistoryComponentState
    extends State<LevelAndGenderHistoryComponent> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            AppLocalizations.individualSchoolEnrollByLevelAndGenderHistory,
            style: textTheme.individualDashboardsSubtitle,
          ),
        ),
        MiniTabLayout(
          tabs: widget.data.map((it) => it.year).toList(),
          tabNameBuilder: (year) {
            return '$year';
          },
          builder: (ctx, year) {
            return EnrollDataByGradeComponent(
              data: widget.data.firstWhere((it) => it.year == year).data,
            );
          },
        ),
      ],
    );
  }
}
