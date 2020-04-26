import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/util/style/colors.dart';

class DropDownItem extends StatelessWidget {
  final IconData iconData;
  final String hint;
  final String value;
  final List<String> items;
  final Function(String) onChanged;
  final Color hintColor;

  DropDownItem(this.value, this.items, this.onChanged,
      {this.hint = "",
      this.iconData = Icons.arrow_drop_down,
      this.hintColor = AppColors.textBlack});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        child: Theme(
            data: Theme.of(context).copyWith(
              buttonTheme: ButtonTheme.of(context).copyWith(
                padding: EdgeInsets.all(0),
                alignedDropdown: true,
              ),
            ),
            child: DropdownButton<String>(
                iconSize: 30,
                icon: Icon(
                  iconData,
                  color: hintColor,
                ),
                hint: Text(
                  hint,
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBlack),
                  textAlign: TextAlign.center,
                ),
                value: value,
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      children: <Widget>[
                        Text(
                          item,
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textBlack),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }).toList(),
                onChanged: onChanged)));
  }
}
