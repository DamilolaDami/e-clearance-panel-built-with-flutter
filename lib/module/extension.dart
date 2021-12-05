import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/main_widgets.dart';

extension ContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

extension StringExtension on String {
  String get appName => 'School Management System';
  Widget toLabel({
    double? fontSize,
    Color? color,
    bool bold = false,
  }) =>
      Label(
        this,
        bold: bold,
        color: color,
        fontSize: fontSize,
      );
}

extension WidgetExtention on Widget {
  Widget get vMargin3 => Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        child: this,
      );
  Widget get vMargin6 => Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: this,
      );
  Widget get vMargin9 => Container(
        margin: const EdgeInsets.symmetric(vertical: 9),
        child: this,
      );
  Widget get hMargin3 => Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        child: this,
      );
  Widget get hMargin6 => Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: this,
      );
  Widget get hMargin9 => Container(
        margin: EdgeInsets.symmetric(vertical: 9),
        child: this,
      );
  Widget get margin3 => Container(
        margin: EdgeInsets.all(3),
        child: this,
      );
  Widget get margin6 => Container(
        margin: EdgeInsets.all(6),
        child: this,
      );
  Widget get margin9 => Container(
        margin: EdgeInsets.all(9),
        child: this,
      );
  Widget get vpadding3 => Container(
        margin: EdgeInsets.symmetric(
          vertical: 3,
        ),
        child: this,
      );
  Widget get vpadding6 => Container(
        margin: EdgeInsets.symmetric(
          vertical: 6,
        ),
        child: this,
      );
  Widget get vpadding9 => Container(
        padding: EdgeInsets.symmetric(
          vertical: 9,
        ),
        child: this,
      );
  Widget get hpadding3 => Container(
        padding: EdgeInsets.symmetric(
          vertical: 3,
        ),
        child: this,
      );
  Widget get hpadding6 => Container(
        padding: EdgeInsets.symmetric(
          vertical: 3,
        ),
        child: this,
      );
  Widget get hpadding9 => Container(
        padding: EdgeInsets.symmetric(
          vertical: 9,
        ),
        child: this,
      );
  Widget get padding3 => Container(
        padding: EdgeInsets.all(3),
        child: this,
      );
  Widget get padding6 => Container(
        padding: EdgeInsets.all(6),
        child: this,
      );
  Widget get padding9 => Container(
        padding: EdgeInsets.all(9),
        child: this,
      );
  Widget get card => Card(child: this);
  Widget get expanded => Expanded(child: this);
  Widget get center => Center(child: this);
}
