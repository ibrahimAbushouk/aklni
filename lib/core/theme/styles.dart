import 'package:aklni/core/utils/helper/responsive_ui_helper/size_helper_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextStylesExtension on BuildContext {
  TextStyle get font14deepgrayBold => TextStyle(
    fontSize: setSp(14),
    fontWeight: FontWeight.bold,
    color: Colors.black,
    decoration: TextDecoration.none,
  );
  TextStyle get onBoardingTitleStyle => TextStyle(
    fontSize: setSp(25),
    fontFamily: GoogleFonts.inder.toString(),
    fontWeight: FontWeight.w700,
    color: Colors.white,
    decoration: TextDecoration.none,
  );

  TextStyle get onBoardingDescriptionStyle => TextStyle(
    fontSize: setSp(13),
    fontFamily: GoogleFonts.inder.toString(),
    fontWeight: FontWeight.normal,
    color: Colors.white,
    decoration: TextDecoration.none,
  );

  TextStyle get white14semiBold => TextStyle(
    fontSize: setSp(14),
    fontFamily: GoogleFonts.inder.toString(),
    fontWeight: FontWeight.w500,
    color: Colors.white,
    decoration: TextDecoration.none,
  );

  TextStyle get black16Medium => TextStyle(
    fontSize: setSp(16),
    fontFamily: GoogleFonts.inder.toString(),
    fontWeight: FontWeight.w500,
    color: Colors.black,
    decoration: TextDecoration.none,
  );
  TextStyle get grey14Regular => TextStyle(
    fontSize: setSp(14),
    fontFamily: GoogleFonts.inder.toString(),
    fontWeight: FontWeight.normal,
    color: Color(0xFF878787),
    decoration: TextDecoration.none,
  );
// used to do
// Text('Resend Code?', style: context.font14deepgrayBold)

}




/// الحل الامثل يتكون من الاولى :


// class TextStyles {
//   static TextStyle font14deepgrayBold(BuildContext context) {
//     return TextStyle(
//       fontSize: context.setSp(14),
//       fontWeight: FontWeight.bold,
//       color: Colors.black,
//       decoration: TextDecoration.none,
//     );
//   }
//   //useeeeeeeeeed
//  // Text('Resend Code?', style: TextStyles.font14deepgrayBold(context))
//
// }
