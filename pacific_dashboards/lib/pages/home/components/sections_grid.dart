import 'package:flutter/material.dart';
import 'package:pacific_dashboards/pages/home/components/section.dart';

class SectionsGrid extends StatelessWidget {
  SectionsGrid(
      {@required List<Section> sections, @required bool useMobileLayout})
      : assert(sections != null, useMobileLayout != null),
        _sections = sections,
        _useMobileLayout = useMobileLayout;

  final List<Section> _sections;
  final bool _useMobileLayout;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _sections.length,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _useMobileLayout ? 2 : 3),
      itemBuilder: (BuildContext context, int index) {
        return _MenuTab(
          section: _sections[index],
          useMobileLayout: _useMobileLayout,
        );
      },
    );
  }
}

class _MenuTab extends StatelessWidget {
  const _MenuTab({
    Key key,
    @required Section section,
    @required useMobileLayout,
  })  : _section = section,
        super(key: key);

  final Section _section;

  @override
  Widget build(BuildContext context) {
    var useMobileLayout = MediaQuery.of(context).size.shortestSide < 720;
    return Container(
      margin: const EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color.fromRGBO(8, 36, 73, 0.4),
            blurRadius: 16.0,
            offset: const Offset(0.0, 16.0),
          ),
        ],
      ),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(16.0)),
        ),
        child: InkWell(
          splashColor: Theme.of(context).accentColor.withAlpha(30),
          onTap: () {
            Navigator.pushNamed(context, _section.routeName);
          },
          child: ClipRect(
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: Container(
                    child: Image.asset(
                      _section.logoPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      _section.getName(context),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: useMobileLayout
                          ? Theme.of(context).textTheme.headline5
                          : Theme.of(context).textTheme.headline4,
                      textScaleFactor: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
