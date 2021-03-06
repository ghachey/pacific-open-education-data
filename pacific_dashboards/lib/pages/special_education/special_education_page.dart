import 'package:arch/arch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pacific_dashboards/models/filter/filter.dart';
import 'package:pacific_dashboards/pages/special_education/componnets/cohort_distribution_component.dart';
import 'package:pacific_dashboards/pages/special_education/componnets/special_education_component.dart';
import 'package:pacific_dashboards/pages/special_education/special_education_view_model.dart';
import 'package:pacific_dashboards/res/colors.dart';
import 'package:pacific_dashboards/res/strings.dart';
import 'package:pacific_dashboards/shared_ui/loading_stack.dart';
import 'package:pacific_dashboards/shared_ui/page_note_widget.dart';
import 'package:pacific_dashboards/shared_ui/platform_app_bar.dart';
import 'package:pacific_dashboards/view_model_factory.dart';

import 'special_education_data.dart';

class SpecialEducationPage extends MvvmStatefulWidget {
  static String kRoute = "/Special Education";

  SpecialEducationPage({
    Key key,
  }) : super(
          key: key,
          viewModelBuilder: (ctx) =>
              ViewModelFactory.instance.createSpecialEducationViewModel(ctx),
        );

  @override
  _SpecialEducationPageState createState() => _SpecialEducationPageState();
}

class _SpecialEducationPageState
    extends MvvmState<SpecialEducationViewModel, SpecialEducationPage> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: PlatformAppBar(
        title: Text('homeSectionSpecialEducation'.localized(context)),
        actions: <Widget>[
          StreamBuilder<List<Filter>>(
            stream: viewModel.filtersStream,
            builder: (ctx, snapshot) {
              return Visibility(
                visible: snapshot.hasData,
                child: IconButton(
                  icon: SvgPicture.asset('images/filter.svg'),
                  onPressed: () {
                    viewModel.onFiltersPressed();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: LoadingStack(
        loadingStateStream: viewModel.activityIndicatorStream,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: PageNoteWidget(noteStream: viewModel.noteStream),
                ),
                StreamBuilder<SpecialEducationData>(
                  stream: viewModel.dataStream,
                  builder: (ctx, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      final year = snapshot.data.year;
                      return Column(
                        children: [
                          _Title(
                            text: 'specialEducationTitleDisability',
                            year: year,
                          ),
                          SpecialEducationComponent(
                            data: snapshot.data.dataByGender,
                          ),
                          _Title(
                            text: 'specialEducationTitleEthnicity',
                            year: year,
                          ),
                          SpecialEducationComponent(
                            data: snapshot.data.dataByEthnicity,
                          ),
                          _Title(
                            text: 'specialEducationTitleEnvironment',
                            year: year,
                          ),
                          SpecialEducationComponent(
                            data: snapshot.data.dataBySpecialEdEnvironment,
                          ),
                          _Title(
                            text: 'specialEducationTitleEnglishLearnerStatus',
                            year: year,
                          ),
                          SpecialEducationComponent(
                            data: snapshot.data.dataByEnglishLearner,
                          ),
                          _Title(
                            text: 'specialEducationTitleCohortDistribution',
                          ),
                          _Title(
                            text: 'specialEducationTitleByYear',
                            year: year,
                          ),
                          CohortDistributionComponent(
                            data: snapshot.data.dataByCohortDistributionByYear,
                          ),
                          _Title(
                            text: 'specialEducationTitleByState',
                            year: year,
                          ),
                          CohortDistributionComponent(
                            data: snapshot.data.dataByCohortDistributionByDistrict,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String _text;
  final int _year;

  const _Title({
    Key key,
    @required String text,
    int year,
  })  : assert(text != null),
        _text = text,
        _year = year,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 0.0,
        top: 10.0,
      ),
      child: Text(
        '${_text.localized(context)}' + (_year == null ? '' : ' $_year'),
        style: _year == null
            ? Theme.of(context).textTheme.headline3.copyWith(
                  color: AppColors.kTextMain,
                )
            : Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
