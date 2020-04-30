import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/util/style/colors.dart';

class AppDatePicker extends StatelessWidget {
  final String hint;
  final DateTime initDate;
  final Function(DateTime) onDateChanged;
  final bool showError;

  const AppDatePicker(
      {Key key, this.hint, this.initDate, this.onDateChanged, this.showError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      InkWell(
        child: Container(
            alignment: Alignment.center,
            width: 120,
            height: 36,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    initDate == null ? hint : initDate.year.toString(),
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: showError ? AppColors.red : AppColors.textBlack,
                    size: 18,
                  ),
                ])),
        onTap: () {
          pickTime(context, (DateTime dateTime, l) {
            onDateChanged(dateTime);
          });
        },
      ),
      Container(
        color: Colors.black,
        height: 0.2,
        width: 120,
      )
    ]);
  }

  void pickTime(
    BuildContext context,
    onChange,
  ) {
    String _format = 'yyyy-MMMM-dd';
    DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text('Done', style: TextStyle(color: AppColors.blue)),
        cancel: Text('Cancel', style: TextStyle(color: AppColors.red)),
      ),
      minDateTime: DateTime(1970),
      maxDateTime: DateTime.now(),
      initialDateTime: initDate,
      dateFormat: _format,
      locale: _locale,
      onConfirm: onChange,
    );
  }
}
