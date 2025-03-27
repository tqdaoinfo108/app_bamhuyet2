import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';


AppBarTheme appBarLightTheme = AppBarTheme(
  backgroundColor: Colors.white,
  elevation: 0,
  iconTheme: IconThemeData(color: blackColor),
  titleTextStyle: GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: blackColor,
  ),
);

AppBarTheme appBarDarkTheme = AppBarTheme(
  backgroundColor: blackColor,
  elevation: 0,
  iconTheme: IconThemeData(color: Colors.white),
  titleTextStyle: GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
);

ScrollbarThemeData scrollbarThemeData = ScrollbarThemeData(
  trackColor: MaterialStateProperty.all(primaryColor),
);

DataTableThemeData dataTableLightThemeData = DataTableThemeData(
  columnSpacing: 24,
  headingRowColor: MaterialStateProperty.all(Colors.black12),
  decoration: BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(defaultBorderRadious)),
    border: Border.all(color: Colors.black12),
  ),
  dataTextStyle:  GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: blackColor,
  ),
);

DataTableThemeData dataTableDarkThemeData = DataTableThemeData(
  columnSpacing: 24,
  headingRowColor: MaterialStateProperty.all(Colors.white10),
  decoration: BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(defaultBorderRadious)),
    border: Border.all(color: Colors.white10),
  ),
  dataTextStyle:  GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontSize: 12,
  ),
);
