import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/util/style/colors.dart';

Widget buildColorCircleTextValue3Pair(String text, String value, Color color) {
  return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              text,
              style: GoogleFonts.montserrat(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.instance.textPrimary),
            ),
            Text(
              value,
              style: GoogleFonts.montserrat(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.instance.textPrimary),
            ),
          ],
        )
      ]));
}

Widget buildIconTextValue3Pair(String text, String value, String iconName) {
  return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
        SvgPicture.asset(
          iconName,
          color: AppColors.instance.iconSecundary,
          height: 23,
        ),
        Padding(
          padding: EdgeInsets.only(left: 2),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              text,
              style: GoogleFonts.montserrat(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.instance.textPrimary),
            ),
            Text(
              value,
              style: GoogleFonts.montserrat(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.instance.primary),
            ),
          ],
        )
      ]));
}
