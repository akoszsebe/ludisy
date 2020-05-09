import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';

void showConfirmDialog(BuildContext context, String text, VoidCallback onOK) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        backgroundColor: AppColors.instance.containerColor,
        titlePadding: EdgeInsets.only(top: 32, left: 16, right: 16),
        title: Center(
            child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: AppColors.instance.textPrimary),
        )),
        actions: <Widget>[
          Transform.translate(
              offset: Offset(0, 32),
              child: Container(
                  width: MediaQuery.of(context).size.width - 96,
                  padding: EdgeInsets.only(bottom: 0),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RoundedButton(
                          null,
                          AppSVGAssets.cancel,
                          () {
                            NavigationModule.pop(context);
                          },
                          iconColor: AppColors.instance.secundary,
                          backgroundColor: AppColors.instance.containerColor,
                          scale: 1,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        RoundedButton(
                          null,
                          AppSVGAssets.done,
                          () {
                            onOK();
                            NavigationModule.pop(context);
                          },
                          scale: 1,
                        ),
                      ]))),
        ],
      );
    },
  );
}
