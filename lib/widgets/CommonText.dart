import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonText extends StatelessWidget {
  const CommonText({
    super.key, this.color,
    this.backgroundColor, this.fontSize, this.fontWeight,
    this.fontStyle, this.letterSpacing, this.wordSpacing,
    this.textBaseline, this.height, this.leadingDistribution,
    this.locale, this.foreground, this.background,
    this.shadows, this.fontFeatures, this.fontVariations,
    this.decoration, this.decorationColor,
    this.decorationStyle, this.decorationThickness,
    this.debugLabel, this.fontFamily, this.fontFamilyFallback, this.package, this.overflow, required this.text, this.textAlign, this.headText, this.titleText, this.descriptionText, this.numericText});
  final bool inherit = true;
  final String text;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize ;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextBaseline? textBaseline;
  final double? height;
  final TextLeadingDistribution?leadingDistribution;
  final Locale? locale ;
  final Paint? foreground ;
  final Paint? background ;
  final List<Shadow>? shadows  ;
  final List<FontFeature>? fontFeatures  ;
  final List<FontVariation>? fontVariations ;
  final TextDecoration? decoration;
  final Color? decorationColor ;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final  String? debugLabel ;
  final String? fontFamily ;
  final  List<String>? fontFamilyFallback  ;
  final  String? package ;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool? headText;
  final bool? titleText;
  final bool? descriptionText;
  final bool? numericText;

  @override
  Widget build(BuildContext context) {

    if(headText != null && headText == true) {
      return Text(text,
        textAlign:textAlign ,
        style: GoogleFonts.aboreto(fontSize: fontSize, fontWeight: fontWeight, fontStyle: fontStyle,  ),);
    }

    if(titleText != null && titleText == true) {
      return Text(text,
        textAlign:textAlign ,
        style: GoogleFonts.aclonica(fontSize: fontSize, fontWeight: fontWeight, fontStyle: fontStyle,  ),);
    }

    if(descriptionText != null && descriptionText == true) {
      return Text(text,
        textAlign:textAlign ,
        style: GoogleFonts.actor(fontSize: fontSize, fontWeight: fontWeight, fontStyle: fontStyle,  ),);
    }

    if(numericText!= null && numericText == true) {
      return Text(text,
        textAlign:textAlign ,
        style: GoogleFonts.aboreto(fontSize: fontSize, fontWeight: fontWeight, fontStyle: fontStyle,  ),);
    }

    return Text(text,
      textAlign:textAlign ,
      style: GoogleFonts.aboreto(fontSize: fontSize, fontWeight: fontWeight, fontStyle: fontStyle,  ),);
  }

}
