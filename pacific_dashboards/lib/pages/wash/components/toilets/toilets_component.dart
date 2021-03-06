import 'package:arch/arch.dart' show Pair;
import 'package:flutter/material.dart';
import 'package:pacific_dashboards/pages/wash/components/toilets/toilets_data.dart';
import 'package:pacific_dashboards/res/colors.dart';
import 'package:pacific_dashboards/res/strings.dart';
import 'package:pacific_dashboards/shared_ui/charts/chart_data.dart';
import 'package:pacific_dashboards/shared_ui/charts/horizontal_stacked_scrollable_bar_chart.dart';
import 'package:pacific_dashboards/shared_ui/mini_tab_layout.dart';

class ToiletsComponent extends StatelessWidget {
  final WashToiletViewData _data;

  const ToiletsComponent({
    Key key,
    @required WashToiletViewData data,
  })  : assert(data != null),
        _data = data,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        MiniTabLayout(
          tabs: _Tabs.values,
          tabNameBuilder: (tab) {
            return (tab as _Tabs).getLocalizedName(context);
          },
          builder: (context, tab) => _buildChartForTab(context, tab as _Tabs),
        ),
      ],
    );
  }

  Widget _buildChartForTab(BuildContext context, _Tabs tab) {
    switch (tab) {
      case _Tabs.totalToilets:
        return _SchoolDataByToiletTypeChart(data: _data.totalToilets);
      case _Tabs.usableToilets:
        return _SchoolDataByToiletTypeChart(data: _data.usableToilets);
      case _Tabs.usablePercent:
        return _SchoolDataByPercentChart(data: _data.usablePercent);
      case _Tabs.usablePercentByGender:
        return _SchoolDataByGenderPercentChart(
          data: _data.usablePercentByGender,
        );
      case _Tabs.pupilsByToilet:
        return _SchoolDataByPupilsChart(data: _data.pupilsByToilet);
      case _Tabs.pupilsByToiletByGender:
        return _SchoolDataByGenderChart(
          data: _data.pupilsByToiletByGender,
          isMirrored: true,
        );
      case _Tabs.pupilsByUsableToilet:
        return _SchoolDataByPupilsChart(data: _data.pupilsByUsableToilet);
      case _Tabs.pupilsByUsableToiletByGender:
        return _SchoolDataByGenderChart(
          data: _data.pupilsByUsableToiletByGender,
          isMirrored: true,
        );
      case _Tabs.pupils:
        return _SchoolDataByGenderChart(data: _data.pupils);
      case _Tabs.pupilsMirrored:
        return _SchoolDataByGenderChart(
          data: _data.pupils,
          isMirrored: true,
        );
    }
    throw FallThroughError();
  }
}

enum _Tabs {
  totalToilets,
  usableToilets,
  usablePercent,
  usablePercentByGender,
  pupilsByToilet,
  pupilsByToiletByGender,
  pupilsByUsableToilet,
  pupilsByUsableToiletByGender,
  pupils,
  pupilsMirrored,
}

extension _TabsNameExt on _Tabs {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case _Tabs.totalToilets:
        return 'washToiletsTotalToiletsTab'.localized(context);
      case _Tabs.usableToilets:
        return 'washToiletsUsableToiletsTab'.localized(context);
      case _Tabs.usablePercent:
        return 'washToiletsUsablePercentTab'.localized(context);
      case _Tabs.usablePercentByGender:
        return 'washToiletsUsablePercentByGenderTab'.localized(context);
      case _Tabs.pupilsByToilet:
        return 'washToiletsPupilsByToiletTab'.localized(context);
      case _Tabs.pupilsByToiletByGender:
        return 'washToiletsPupilsByToiletByGenderTab'.localized(context);
      case _Tabs.pupilsByUsableToilet:
        return 'washToiletsPupilsByUsableToiletTab'.localized(context);
      case _Tabs.pupilsByUsableToiletByGender:
        return 'washToiletsPupilsByUsableToiletByGenderTab'.localized(context);
      case _Tabs.pupils:
        return 'washToiletsPupilsTab'.localized(context);
      case _Tabs.pupilsMirrored:
        return 'washToiletsPupilsMirroredTab'.localized(context);
    }
    throw FallThroughError();
  }
}

class _SchoolDataByToiletTypeChart
    extends HorizontalStackedScrollableBarChart {
  final List<SchoolDataByToiletType> _data;

  const _SchoolDataByToiletTypeChart({
    Key key,
    @required List<SchoolDataByToiletType> data,
  })  : assert(data != null),
        _data = data,
        super(key: key);

  @override
  List<ChartData> get chartData {
    final chartData = <ChartData>[];
    _data.forEach((it) {
      chartData.add(ChartData(
        it.school,
        it.boys,
        AppColors.kMale,
      ));
      chartData.add(ChartData(
        it.school,
        it.girls,
        AppColors.kFemale,
      ));
      chartData.add(ChartData(
        it.school,
        it.common,
        AppColors.kGreen,
      ));
    });
    return chartData;
  }

  @override
  int get domainLength => _data.length;

  @override
  List<Pair<String, Color>> get legend => [
        Pair('washToiletsBoysLabel', AppColors.kMale),
        Pair('washToiletsGirlsLabel', AppColors.kFemale),
        Pair('washToiletsCommonLabel', AppColors.kGreen),
      ];
}

class _SchoolDataByPercentChart extends HorizontalStackedScrollableBarChart {
  final List<SchoolDataByPercent> _data;

  const _SchoolDataByPercentChart({
    Key key,
    @required List<SchoolDataByPercent> data,
  })  : assert(data != null),
        _data = data,
        super(key: key);

  @override
  List<ChartData> get chartData {
    final chartData = <ChartData>[];
    _data.forEach((it) {
      chartData.add(ChartData(
        it.school,
        it.percent,
        AppColors.kPercent,
      ));
    });
    return chartData;
  }

  @override
  int get domainLength => _data.length;

  @override
  List<Pair<String, Color>> get legend => [
        Pair('washToiletsUsablePercentLabel', AppColors.kPercent),
      ];
}

class _SchoolDataByGenderPercentChart
    extends HorizontalStackedScrollableBarChart {
  final List<SchoolDataByGenderPercent> _data;

  const _SchoolDataByGenderPercentChart({
    Key key,
    @required List<SchoolDataByGenderPercent> data,
  })  : assert(data != null),
        _data = data,
        super(key: key);

  @override
  List<ChartData> get chartData {
    final chartData = <ChartData>[];
    _data.forEach((it) {
      chartData.add(ChartData(
        it.school,
        it.percentMale,
        AppColors.kMale,
      ));
      chartData.add(ChartData(
        it.school,
        -it.percentFemale,
        AppColors.kFemale,
      ));
    });
    return chartData;
  }

  @override
  int get domainLength => _data.length;

  @override
  List<Pair<String, Color>> get legend => [
        Pair('washToiletsBoysLabel', AppColors.kMale),
        Pair('washToiletsGirlsLabel', AppColors.kFemale),
      ];
}

class _SchoolDataByPupilsChart extends HorizontalStackedScrollableBarChart {
  final List<SchoolDataByPupils> _data;

  const _SchoolDataByPupilsChart({
    Key key,
    @required List<SchoolDataByPupils> data,
  })  : assert(data != null),
        _data = data,
        super(key: key);

  @override
  List<ChartData> get chartData {
    final chartData = <ChartData>[];
    _data.forEach((it) {
      chartData.add(ChartData(
        it.school,
        it.pupils,
        AppColors.kPupil,
      ));
    });
    return chartData;
  }

  @override
  int get domainLength => _data.length;

  @override
  List<Pair<String, Color>> get legend => [
        Pair('washToiletsPupilsLabel', AppColors.kPupil),
      ];
}

class _SchoolDataByGenderChart extends HorizontalStackedScrollableBarChart {
  final List<SchoolDataByGender> _data;
  final bool _isMirrored;

  const _SchoolDataByGenderChart({
    Key key,
    @required List<SchoolDataByGender> data,
    bool isMirrored = false,
  })  : assert(data != null),
        assert(isMirrored != null),
        _data = data,
        _isMirrored = isMirrored,
        super(key: key);

  @override
  List<ChartData> get chartData {
    final chartData = <ChartData>[];
    _data.forEach((it) {
      chartData.add(ChartData(
        it.school,
        it.male,
        AppColors.kMale,
      ));
      chartData.add(ChartData(
        it.school,
        it.female * (_isMirrored ? -1 : 1),
        AppColors.kFemale,
      ));
    });
    return chartData;
  }

  @override
  int get domainLength => _data.length;

  @override
  List<Pair<String, Color>> get legend => [
        Pair('labelMale', AppColors.kMale),
        Pair('labelFemale', AppColors.kFemale),
      ];
}
