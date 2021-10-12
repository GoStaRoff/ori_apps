import 'package:flutter/material.dart';
import 'dart:ui' as ui;

const RED_RIBBON = Color(0xFFFF8D76);
const RED_RIBBON_START = Color(0xFFFF7654);
const RED_RIBBON_END = Color(0xFF904431);
const BLUE_RIBBON = Color(0xFF81C7F1);
const BLUE_RIBBON_START = Color(0xFF61AAEA);
const BLUE_RIBBON_END = Color(0xFF2A4973);
const DARK_RIBBON = Color(0xFF979FC1);
const DARK_RIBBON_START = Color(0xFFA4A9C7);
const DARK_RIBBON_END = Color(0xFF2A4973);
const GREY_RIBBON = Color(0xFFE4E9EF);
const GREY_RIBBON_START = Color(0xFFCCD3DB);
const GREY_RIBBON_END = Color(0xFF61696E);
const GOLD_COLOR_1 = Color(0xFFBFA66D); /////////1
const GOLD_COLOR_2 = Color(0xFFDBC07C);
const GOLD_COLOR_3 = Color(0xFFE8C876);
const GOLD_COLOR_4 = Color(0xFFE6C470);
const GOLD_COLOR_5 = Color(0xFFDFBA60);
const GOLD_COLOR_6 = Color(0xFFD7AF4E);
const GOLD_COLOR_7 = Color(0xFFB5984F);
const GOLD_COLOR_8 = Color(0xFFFFE07D);
const GOLD_COLOR_9 = Color(0xFF91794C);
const GOLD_COLOR_10 = Color(0xFFEABE55);
const GOLD_COLOR_11 = Color(0xFF937333);
const SILVER_COLOR_1 = Color(0xFFADB8C9);
const SILVER_COLOR_2 = Color(0xFFC7D1E0);
const SILVER_COLOR_3 = Color(0xFFE2EAF7);
const SILVER_COLOR_4 = Color(0xFFE2EAF7);
const SILVER_COLOR_5 = Color(0xFFE2EAF7);
const SILVER_COLOR_6 = Color(0xFFC3CCDB);
const SILVER_COLOR_7 = Color(0xFFADB8C9);
const SILVER_COLOR_8 = Color(0xFF5C687F);
const SILVER_COLOR_9 = Color(0xFF5C687F);
const SILVER_COLOR_10 = Color(0xFFC3CCDB);
const SILVER_COLOR_11 = Color(0xFF7C8AA4);
const BRONZE_COLOR_1 = Color(0xFFDDA794);
const BRONZE_COLOR_2 = Color(0xFFEDC8BE);
const BRONZE_COLOR_3 = Color(0xFFFFB79E);
const BRONZE_COLOR_4 = Color(0xFFFFB79E);
const BRONZE_COLOR_5 = Color(0xFFFFB79E);
const BRONZE_COLOR_6 = Color(0xFFEEA085);
const BRONZE_COLOR_7 = Color(0xFFF2DBD6);
const BRONZE_COLOR_8 = Color(0xFF6D3127);
const BRONZE_COLOR_9 = Color(0xFF91794C);
const BRONZE_COLOR_10 = Color(0xFFDC9D87);
const BRONZE_COLOR_11 = Color(0xFF723A29);
const GREY_COLOR_1 = Color(0xFFC6C6C6);
const GREY_COLOR_2 = Color(0xFFE0E0E0);
const GREY_COLOR_3 = Color(0xFFD7D7D7);
const GREY_COLOR_4 = Color(0xFFD7D7D7);
const GREY_COLOR_5 = Color(0xFFD7D7D7);
const GREY_COLOR_6 = Color(0xFFCCCDCD);
const GREY_COLOR_7 = Color(0xFFA0A3A7);
const GREY_COLOR_8 = Color(0xFFFFFFFF);
const GREY_COLOR_9 = Color(0xFF6B6B6B);
const GREY_COLOR_10 = Color(0xFFC7C7C7);
const GREY_COLOR_11 = Color(0xFF818181);

class DMedal extends CustomPainter {
  bool withCup;
  String rColor;
  String mColor;
  DMedal({this.withCup = false, this.rColor = "red", this.mColor = "gold"});
  @override
  void paint(Canvas canvas, Size size) {
    var ribbonColor;
    var ribbonStart;
    var ribbonEnd;
    var mColor1;
    var mColor2;
    var mColor3;
    var mColor4;
    var mColor5;
    var mColor6;
    var mColor7;
    var mColor8;
    var mColor9;
    var mColor10;
    var mColor11;
    switch (mColor) {
      case "gold":
        mColor1 = GOLD_COLOR_1;
        mColor2 = GOLD_COLOR_2;
        mColor3 = GOLD_COLOR_3;
        mColor4 = GOLD_COLOR_4;
        mColor5 = GOLD_COLOR_5;
        mColor6 = GOLD_COLOR_6;
        mColor7 = GOLD_COLOR_7;
        mColor8 = GOLD_COLOR_8;
        mColor9 = GOLD_COLOR_9;
        mColor10 = GOLD_COLOR_10;
        mColor11 = GOLD_COLOR_11;
        break;
      case "silver":
        mColor1 = SILVER_COLOR_1;
        mColor2 = SILVER_COLOR_2;
        mColor3 = SILVER_COLOR_3;
        mColor4 = SILVER_COLOR_4;
        mColor5 = SILVER_COLOR_5;
        mColor6 = SILVER_COLOR_6;
        mColor7 = SILVER_COLOR_7;
        mColor8 = SILVER_COLOR_8;
        mColor9 = SILVER_COLOR_9;
        mColor10 = SILVER_COLOR_10;
        mColor11 = SILVER_COLOR_11;
        break;
      case "bronze":
        mColor1 = BRONZE_COLOR_1;
        mColor2 = BRONZE_COLOR_2;
        mColor3 = BRONZE_COLOR_3;
        mColor4 = BRONZE_COLOR_4;
        mColor5 = BRONZE_COLOR_5;
        mColor6 = BRONZE_COLOR_6;
        mColor7 = BRONZE_COLOR_7;
        mColor8 = BRONZE_COLOR_8;
        mColor9 = BRONZE_COLOR_9;
        mColor10 = BRONZE_COLOR_10;
        mColor11 = BRONZE_COLOR_11;
        break;
      case "grey":
        mColor1 = GREY_COLOR_1;
        mColor2 = GREY_COLOR_2;
        mColor3 = GREY_COLOR_3;
        mColor4 = GREY_COLOR_4;
        mColor5 = GREY_COLOR_5;
        mColor6 = GREY_COLOR_6;
        mColor7 = GREY_COLOR_7;
        mColor8 = GREY_COLOR_8;
        mColor9 = GREY_COLOR_9;
        mColor10 = GREY_COLOR_10;
        mColor11 = GREY_COLOR_11;
        break;
    }
    switch (rColor) {
      case "red":
        ribbonColor = RED_RIBBON;
        ribbonStart = RED_RIBBON_START;
        ribbonEnd = RED_RIBBON_END;
        break;
      case "blue":
        ribbonColor = BLUE_RIBBON;
        ribbonStart = BLUE_RIBBON_START;
        ribbonEnd = BLUE_RIBBON_END;
        break;
      case "dark":
        ribbonColor = DARK_RIBBON;
        ribbonStart = DARK_RIBBON_START;
        ribbonEnd = DARK_RIBBON_END;
        break;
      default:
        ribbonColor = GREY_RIBBON;
        ribbonStart = GREY_RIBBON_START;
        ribbonEnd = GREY_RIBBON_END;
        break;
    }
    var rect = Offset.zero & Size(size.width / 2, size.height / 3);
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5716535, size.height * 0.5381757);
    path_0.lineTo(size.width * 0.4259843, size.height * 0.5381757);
    path_0.cubicTo(
        size.width * 0.4055118,
        size.height * 0.5381757,
        size.width * 0.3889764,
        size.height * 0.5452703,
        size.width * 0.3889764,
        size.height * 0.5540541);
    path_0.lineTo(size.width * 0.3889764, size.height * 0.5709459);
    path_0.lineTo(size.width * 0.3889764, size.height * 0.5763514);
    path_0.lineTo(size.width * 0.3889764, size.height * 0.6263514);
    path_0.cubicTo(
        size.width * 0.3889764,
        size.height * 0.6351351,
        size.width * 0.4055118,
        size.height * 0.6422297,
        size.width * 0.4259843,
        size.height * 0.6422297);
    path_0.lineTo(size.width * 0.5724409, size.height * 0.6422297);
    path_0.cubicTo(
        size.width * 0.5929134,
        size.height * 0.6422297,
        size.width * 0.6094488,
        size.height * 0.6351351,
        size.width * 0.6094488,
        size.height * 0.6263514);
    path_0.lineTo(size.width * 0.6094488, size.height * 0.5763514);
    path_0.lineTo(size.width * 0.6094488, size.height * 0.5709459);
    path_0.lineTo(size.width * 0.6094488, size.height * 0.5540541);
    path_0.cubicTo(
        size.width * 0.6094488,
        size.height * 0.5452703,
        size.width * 0.5921260,
        size.height * 0.5381757,
        size.width * 0.5716535,
        size.height * 0.5381757);
    path_0.close();
    path_0.moveTo(size.width * 0.5700787, size.height * 0.5733108);
    path_0.lineTo(size.width * 0.5700787, size.height * 0.6256757);
    path_0.lineTo(size.width * 0.4283465, size.height * 0.6256757);
    path_0.lineTo(size.width * 0.4283465, size.height * 0.5733108);
    path_0.lineTo(size.width * 0.4283465, size.height * 0.5679054);
    path_0.lineTo(size.width * 0.4283465, size.height * 0.5550676);
    path_0.lineTo(size.width * 0.5700787, size.height * 0.5550676);
    path_0.lineTo(size.width * 0.5700787, size.height * 0.5679054);
    path_0.lineTo(size.width * 0.5700787, size.height * 0.5733108);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = mColor2.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.5188976, size.height * 0.5611486);
    path_1.lineTo(size.width * 0.4787402, size.height * 0.5611486);
    path_1.cubicTo(
        size.width * 0.4645669,
        size.height * 0.5611486,
        size.width * 0.4535433,
        size.height * 0.5564189,
        size.width * 0.4535433,
        size.height * 0.5503378);
    path_1.lineTo(size.width * 0.4535433, size.height * 0.5040541);
    path_1.cubicTo(
        size.width * 0.4535433,
        size.height * 0.4979730,
        size.width * 0.4645669,
        size.height * 0.4932432,
        size.width * 0.4787402,
        size.height * 0.4932432);
    path_1.lineTo(size.width * 0.5188976, size.height * 0.4932432);
    path_1.cubicTo(
        size.width * 0.5330709,
        size.height * 0.4932432,
        size.width * 0.5440945,
        size.height * 0.4979730,
        size.width * 0.5440945,
        size.height * 0.5040541);
    path_1.lineTo(size.width * 0.5440945, size.height * 0.5503378);
    path_1.cubicTo(
        size.width * 0.5440945,
        size.height * 0.5560811,
        size.width * 0.5330709,
        size.height * 0.5611486,
        size.width * 0.5188976,
        size.height * 0.5611486);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = mColor1.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.9976378, size.height * 0.7851351);
    path_2.cubicTo(
        size.width * 0.9976378,
        size.height * 0.9033784,
        size.width * 0.7740157,
        size.height * 0.9989865,
        size.width * 0.4992126,
        size.height * 0.9989865);
    path_2.cubicTo(size.width * 0.2236220, size.height * 0.9989865, 0,
        size.height * 0.9030405, 0, size.height * 0.7851351);
    path_2.cubicTo(0, size.height * 0.7841216, 0, size.height * 0.7834459, 0,
        size.height * 0.7824324);
    path_2.cubicTo(
        size.width * 0.003149606,
        size.height * 0.6817568,
        size.width * 0.1677165,
        size.height * 0.5976351,
        size.width * 0.3881890,
        size.height * 0.5763514);
    path_2.cubicTo(
        size.width * 0.4007874,
        size.height * 0.5750000,
        size.width * 0.4141732,
        size.height * 0.5739865,
        size.width * 0.4275591,
        size.height * 0.5733108);
    path_2.cubicTo(
        size.width * 0.4503937,
        size.height * 0.5719595,
        size.width * 0.4748031,
        size.height * 0.5712838,
        size.width * 0.4984252,
        size.height * 0.5712838);
    path_2.cubicTo(
        size.width * 0.5228346,
        size.height * 0.5712838,
        size.width * 0.5464567,
        size.height * 0.5719595,
        size.width * 0.5692913,
        size.height * 0.5733108);
    path_2.cubicTo(
        size.width * 0.5826772,
        size.height * 0.5739865,
        size.width * 0.5960630,
        size.height * 0.5750000,
        size.width * 0.6086614,
        size.height * 0.5763514);
    path_2.cubicTo(
        size.width * 0.8291339,
        size.height * 0.5976351,
        size.width * 0.9944882,
        size.height * 0.6817568,
        size.width * 0.9968504,
        size.height * 0.7824324);
    path_2.cubicTo(
        size.width * 0.9976378,
        size.height * 0.7834459,
        size.width * 0.9976378,
        size.height * 0.7841216,
        size.width * 0.9976378,
        size.height * 0.7851351);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.4260047, size.height * 0.6233480),
        Offset(size.width * 0.7423299, size.height * 1.326463), [
      mColor3.withOpacity(1.0),
      mColor4.withOpacity(1.0),
      mColor5.withOpacity(1.0),
      mColor6.withOpacity(1.0),
      mColor7.withOpacity(1.0)
    ], [
      0,
      0.0644261,
      0.148,
      0.2146,
      1
    ]);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.4984252, size.height * 0.9652027);
    path_3.cubicTo(
        size.width * 0.7236874,
        size.height * 0.9652027,
        size.width * 0.9062992,
        size.height * 0.8847365,
        size.width * 0.9062992,
        size.height * 0.7854730);
    path_3.cubicTo(
        size.width * 0.9062992,
        size.height * 0.6862095,
        size.width * 0.7236874,
        size.height * 0.6057432,
        size.width * 0.4984252,
        size.height * 0.6057432);
    path_3.cubicTo(
        size.width * 0.2731622,
        size.height * 0.6057432,
        size.width * 0.09055118,
        size.height * 0.6862095,
        size.width * 0.09055118,
        size.height * 0.7854730);
    path_3.cubicTo(
        size.width * 0.09055118,
        size.height * 0.8847365,
        size.width * 0.2731622,
        size.height * 0.9652027,
        size.width * 0.4984252,
        size.height * 0.9652027);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = mColor9.withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.4984252, size.height * 0.9601351);
    path_4.cubicTo(
        size.width * 0.7236874,
        size.height * 0.9601351,
        size.width * 0.9062992,
        size.height * 0.8817838,
        size.width * 0.9062992,
        size.height * 0.7851351);
    path_4.cubicTo(
        size.width * 0.9062992,
        size.height * 0.6884865,
        size.width * 0.7236874,
        size.height * 0.6101351,
        size.width * 0.4984252,
        size.height * 0.6101351);
    path_4.cubicTo(
        size.width * 0.2731622,
        size.height * 0.6101351,
        size.width * 0.09055118,
        size.height * 0.6884865,
        size.width * 0.09055118,
        size.height * 0.7851351);
    path_4.cubicTo(
        size.width * 0.09055118,
        size.height * 0.8817838,
        size.width * 0.2731622,
        size.height * 0.9601351,
        size.width * 0.4984252,
        size.height * 0.9601351);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.4819598, size.height * 0.6889764),
        Offset(size.width * 0.5753543, size.height * 1.222000),
        [mColor10.withOpacity(1.0), mColor11.withOpacity(1.0)],
        [0, 0.981]);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.9078740, size.height * 0.7854730);
    path_5.cubicTo(
        size.width * 0.9078740,
        size.height * 0.8087838,
        size.width * 0.8976378,
        size.height * 0.8320946,
        size.width * 0.8779528,
        size.height * 0.8537162);
    path_5.cubicTo(
        size.width * 0.8582677,
        size.height * 0.8753378,
        size.width * 0.8283465,
        size.height * 0.8956081,
        size.width * 0.7905512,
        size.height * 0.9125000);
    path_5.cubicTo(
        size.width * 0.7527559,
        size.height * 0.9293919,
        size.width * 0.7078740,
        size.height * 0.9432432,
        size.width * 0.6574803,
        size.height * 0.9527027);
    path_5.cubicTo(
        size.width * 0.6070866,
        size.height * 0.9621622,
        size.width * 0.5527559,
        size.height * 0.9668919,
        size.width * 0.4984244,
        size.height * 0.9668919);
    path_5.cubicTo(
        size.width * 0.4440937,
        size.height * 0.9668919,
        size.width * 0.3897638,
        size.height * 0.9618243,
        size.width * 0.3393693,
        size.height * 0.9527027);
    path_5.cubicTo(
        size.width * 0.2889756,
        size.height * 0.9435811,
        size.width * 0.2440945,
        size.height * 0.9297297,
        size.width * 0.2062992,
        size.height * 0.9128378);
    path_5.cubicTo(
        size.width * 0.1685039,
        size.height * 0.8959459,
        size.width * 0.1385827,
        size.height * 0.8760135,
        size.width * 0.1188976,
        size.height * 0.8543919);
    path_5.cubicTo(
        size.width * 0.09842520,
        size.height * 0.8327703,
        size.width * 0.08818898,
        size.height * 0.8094595,
        size.width * 0.08818898,
        size.height * 0.7861486);
    path_5.cubicTo(
        size.width * 0.08818898,
        size.height * 0.7628378,
        size.width * 0.09842520,
        size.height * 0.7395270,
        size.width * 0.1181102,
        size.height * 0.7175676);
    path_5.cubicTo(
        size.width * 0.1377953,
        size.height * 0.6959459,
        size.width * 0.1677165,
        size.height * 0.6756757,
        size.width * 0.2055118,
        size.height * 0.6587838);
    path_5.cubicTo(
        size.width * 0.2433071,
        size.height * 0.6418919,
        size.width * 0.2889764,
        size.height * 0.6280405,
        size.width * 0.3385827,
        size.height * 0.6189189);
    path_5.cubicTo(
        size.width * 0.3889764,
        size.height * 0.6094595,
        size.width * 0.4433063,
        size.height * 0.6047297,
        size.width * 0.4976378,
        size.height * 0.6047297);
    path_5.cubicTo(
        size.width * 0.5519685,
        size.height * 0.6047297,
        size.width * 0.6070866,
        size.height * 0.6094595,
        size.width * 0.6566929,
        size.height * 0.6189189);
    path_5.cubicTo(
        size.width * 0.7070866,
        size.height * 0.6283784,
        size.width * 0.7519685,
        size.height * 0.6422297,
        size.width * 0.7897638,
        size.height * 0.6591216);
    path_5.cubicTo(
        size.width * 0.8275591,
        size.height * 0.6760135,
        size.width * 0.8566929,
        size.height * 0.6962838,
        size.width * 0.8771654,
        size.height * 0.7179054);
    path_5.cubicTo(
        size.width * 0.8976378,
        size.height * 0.7388514,
        size.width * 0.9078740,
        size.height * 0.7621622,
        size.width * 0.9078740,
        size.height * 0.7854730);
    path_5.close();
    path_5.moveTo(size.width * 0.9070866, size.height * 0.7854730);
    path_5.cubicTo(
        size.width * 0.9070866,
        size.height * 0.7621622,
        size.width * 0.8960630,
        size.height * 0.7388514,
        size.width * 0.8763780,
        size.height * 0.7172297);
    path_5.cubicTo(
        size.width * 0.8559055,
        size.height * 0.6956081,
        size.width * 0.8259843,
        size.height * 0.6756757,
        size.width * 0.7889764,
        size.height * 0.6591216);
    path_5.cubicTo(
        size.width * 0.7511803,
        size.height * 0.6425676,
        size.width * 0.7062992,
        size.height * 0.6287162,
        size.width * 0.6566929,
        size.height * 0.6195946);
    path_5.cubicTo(
        size.width * 0.6070866,
        size.height * 0.6104730,
        size.width * 0.5527559,
        size.height * 0.6057432,
        size.width * 0.4992126,
        size.height * 0.6057432);
    path_5.cubicTo(
        size.width * 0.4448819,
        size.height * 0.6057432,
        size.width * 0.3913386,
        size.height * 0.6104730,
        size.width * 0.3417323,
        size.height * 0.6195946);
    path_5.cubicTo(
        size.width * 0.2921260,
        size.height * 0.6287162,
        size.width * 0.2472441,
        size.height * 0.6422297,
        size.width * 0.2094488,
        size.height * 0.6591216);
    path_5.cubicTo(
        size.width * 0.1724409,
        size.height * 0.6760135,
        size.width * 0.1425197,
        size.height * 0.6956081,
        size.width * 0.1220472,
        size.height * 0.7172297);
    path_5.cubicTo(
        size.width * 0.1015748,
        size.height * 0.7388514,
        size.width * 0.09133858,
        size.height * 0.7618243,
        size.width * 0.09133858,
        size.height * 0.7851351);
    path_5.cubicTo(
        size.width * 0.09133858,
        size.height * 0.8317568,
        size.width * 0.1330709,
        size.height * 0.8780405,
        size.width * 0.2086614,
        size.height * 0.9114865);
    path_5.cubicTo(
        size.width * 0.2464567,
        size.height * 0.9283784,
        size.width * 0.2913386,
        size.height * 0.9418919,
        size.width * 0.3409441,
        size.height * 0.9510135);
    path_5.cubicTo(
        size.width * 0.3905504,
        size.height * 0.9601351,
        size.width * 0.4448819,
        size.height * 0.9648649,
        size.width * 0.4992126,
        size.height * 0.9648649);
    path_5.cubicTo(
        size.width * 0.5535433,
        size.height * 0.9648649,
        size.width * 0.6070866,
        size.height * 0.9597973,
        size.width * 0.6566929,
        size.height * 0.9506757);
    path_5.cubicTo(
        size.width * 0.7062992,
        size.height * 0.9415541,
        size.width * 0.7519685,
        size.height * 0.9280405,
        size.width * 0.7889764,
        size.height * 0.9111486);
    path_5.cubicTo(
        size.width * 0.8267717,
        size.height * 0.8942568,
        size.width * 0.8566929,
        size.height * 0.8746622,
        size.width * 0.8763780,
        size.height * 0.8530405);
    path_5.cubicTo(
        size.width * 0.8968504,
        size.height * 0.8320946,
        size.width * 0.9070866,
        size.height * 0.8087838,
        size.width * 0.9070866,
        size.height * 0.7854730);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = mColor8.withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    if (mColor == "gold" && withCup) {
      Path path_6 = Path();
      path_6.moveTo(size.width * 0.7291339, size.height * 0.6993243);
      path_6.cubicTo(
          size.width * 0.7149606,
          size.height * 0.6922297,
          size.width * 0.6944882,
          size.height * 0.6885135,
          size.width * 0.6724409,
          size.height * 0.6885135);
      path_6.lineTo(size.width * 0.6354331, size.height * 0.6885135);
      path_6.cubicTo(
          size.width * 0.6425197,
          size.height * 0.6881757,
          size.width * 0.6480315,
          size.height * 0.6854730,
          size.width * 0.6480315,
          size.height * 0.6820946);
      path_6.lineTo(size.width * 0.6480315, size.height * 0.6746622);
      path_6.cubicTo(
          size.width * 0.6480315,
          size.height * 0.6733108,
          size.width * 0.6448819,
          size.height * 0.6719595,
          size.width * 0.6417323,
          size.height * 0.6719595);
      path_6.lineTo(size.width * 0.3803150, size.height * 0.6719595);
      path_6.lineTo(size.width * 0.3716535, size.height * 0.6719595);
      path_6.cubicTo(
          size.width * 0.3685039,
          size.height * 0.6719595,
          size.width * 0.3653543,
          size.height * 0.6733108,
          size.width * 0.3653543,
          size.height * 0.6746622);
      path_6.lineTo(size.width * 0.3653543, size.height * 0.6817568);
      path_6.cubicTo(
          size.width * 0.3653543,
          size.height * 0.6851351,
          size.width * 0.3708661,
          size.height * 0.6878378,
          size.width * 0.3787402,
          size.height * 0.6881757);
      path_6.lineTo(size.width * 0.3417323, size.height * 0.6881757);
      path_6.cubicTo(
          size.width * 0.3204724,
          size.height * 0.6881757,
          size.width * 0.3000000,
          size.height * 0.6922297,
          size.width * 0.2850394,
          size.height * 0.6989865);
      path_6.cubicTo(
          size.width * 0.2700787,
          size.height * 0.7057432,
          size.width * 0.2637795,
          size.height * 0.7152027,
          size.width * 0.2669291,
          size.height * 0.7243243);
      path_6.cubicTo(
          size.width * 0.2716535,
          size.height * 0.7402027,
          size.width * 0.2874016,
          size.height * 0.7550676,
          size.width * 0.3118110,
          size.height * 0.7672297);
      path_6.cubicTo(
          size.width * 0.3362205,
          size.height * 0.7793919,
          size.width * 0.3685039,
          size.height * 0.7878378,
          size.width * 0.4055118,
          size.height * 0.7915541);
      path_6.lineTo(size.width * 0.4173228, size.height * 0.7929054);
      path_6.cubicTo(
          size.width * 0.4346457,
          size.height * 0.8000000,
          size.width * 0.4559055,
          size.height * 0.8050676,
          size.width * 0.4803150,
          size.height * 0.8070946);
      path_6.lineTo(size.width * 0.4803150, size.height * 0.8307432);
      path_6.lineTo(size.width * 0.4409449, size.height * 0.8307432);
      path_6.lineTo(size.width * 0.4362205, size.height * 0.8307432);
      path_6.cubicTo(
          size.width * 0.4291339,
          size.height * 0.8307432,
          size.width * 0.4236220,
          size.height * 0.8331081,
          size.width * 0.4236220,
          size.height * 0.8361486);
      path_6.lineTo(size.width * 0.4236220, size.height * 0.8459459);
      path_6.cubicTo(
          size.width * 0.4236220,
          size.height * 0.8469595,
          size.width * 0.4259843,
          size.height * 0.8479730,
          size.width * 0.4283465,
          size.height * 0.8479730);
      path_6.lineTo(size.width * 0.5866142, size.height * 0.8479730);
      path_6.cubicTo(
          size.width * 0.5889764,
          size.height * 0.8479730,
          size.width * 0.5913386,
          size.height * 0.8469595,
          size.width * 0.5913386,
          size.height * 0.8459459);
      path_6.lineTo(size.width * 0.5913386, size.height * 0.8391892);
      path_6.lineTo(size.width * 0.5913386, size.height * 0.8364865);
      path_6.cubicTo(
          size.width * 0.5913386,
          size.height * 0.8331081,
          size.width * 0.5850394,
          size.height * 0.8304054,
          size.width * 0.5771654,
          size.height * 0.8304054);
      path_6.lineTo(size.width * 0.5338583, size.height * 0.8304054);
      path_6.lineTo(size.width * 0.5338583, size.height * 0.8222973);
      path_6.lineTo(size.width * 0.5338583, size.height * 0.8074324);
      path_6.cubicTo(
          size.width * 0.5448819,
          size.height * 0.8064189,
          size.width * 0.5551181,
          size.height * 0.8047297,
          size.width * 0.5653543,
          size.height * 0.8027027);
      path_6.cubicTo(
          size.width * 0.5771654,
          size.height * 0.8003378,
          size.width * 0.5874016,
          size.height * 0.7969595,
          size.width * 0.5968504,
          size.height * 0.7932432);
      path_6.lineTo(size.width * 0.6094488, size.height * 0.7918919);
      path_6.cubicTo(
          size.width * 0.6456693,
          size.height * 0.7878378,
          size.width * 0.6779528,
          size.height * 0.7793919,
          size.width * 0.7031496,
          size.height * 0.7675676);
      path_6.cubicTo(
          size.width * 0.7275591,
          size.height * 0.7554054,
          size.width * 0.7433071,
          size.height * 0.7408784,
          size.width * 0.7480315,
          size.height * 0.7246622);
      path_6.cubicTo(
          size.width * 0.7503937,
          size.height * 0.7155405,
          size.width * 0.7433071,
          size.height * 0.7060811,
          size.width * 0.7291339,
          size.height * 0.6993243);
      path_6.close();
      path_6.moveTo(size.width * 0.4409449, size.height * 0.8378378);
      path_6.cubicTo(
          size.width * 0.4409449,
          size.height * 0.8388514,
          size.width * 0.4425197,
          size.height * 0.8398649,
          size.width * 0.4448819,
          size.height * 0.8398649);
      path_6.cubicTo(
          size.width * 0.4425197,
          size.height * 0.8395270,
          size.width * 0.4409449,
          size.height * 0.8388514,
          size.width * 0.4409449,
          size.height * 0.8378378);
      path_6.close();
      path_6.moveTo(size.width * 0.3023622, size.height * 0.7226351);
      path_6.cubicTo(
          size.width * 0.3007874,
          size.height * 0.7179054,
          size.width * 0.3047244,
          size.height * 0.7128378,
          size.width * 0.3118110,
          size.height * 0.7091216);
      path_6.cubicTo(
          size.width * 0.3196850,
          size.height * 0.7054054,
          size.width * 0.3299213,
          size.height * 0.7033784,
          size.width * 0.3417323,
          size.height * 0.7033784);
      path_6.lineTo(size.width * 0.3787402, size.height * 0.7033784);
      path_6.lineTo(size.width * 0.3787402, size.height * 0.7533784);
      path_6.cubicTo(
          size.width * 0.3787402,
          size.height * 0.7601351,
          size.width * 0.3818898,
          size.height * 0.7665541,
          size.width * 0.3866142,
          size.height * 0.7726351);
      path_6.cubicTo(
          size.width * 0.3409449,
          size.height * 0.7635135,
          size.width * 0.3086614,
          size.height * 0.7449324,
          size.width * 0.3023622,
          size.height * 0.7226351);
      path_6.close();
      path_6.moveTo(size.width * 0.7118110, size.height * 0.7226351);
      path_6.cubicTo(
          size.width * 0.7055118,
          size.height * 0.7449324,
          size.width * 0.6732283,
          size.height * 0.7635135,
          size.width * 0.6267717,
          size.height * 0.7729730);
      path_6.cubicTo(
          size.width * 0.6322835,
          size.height * 0.7668919,
          size.width * 0.6346457,
          size.height * 0.7604730,
          size.width * 0.6346457,
          size.height * 0.7537162);
      path_6.lineTo(size.width * 0.6346457, size.height * 0.7037162);
      path_6.lineTo(size.width * 0.6716535, size.height * 0.7037162);
      path_6.cubicTo(
          size.width * 0.6826772,
          size.height * 0.7037162,
          size.width * 0.6937008,
          size.height * 0.7057432,
          size.width * 0.7015748,
          size.height * 0.7094595);
      path_6.cubicTo(
          size.width * 0.7102362,
          size.height * 0.7131757,
          size.width * 0.7133858,
          size.height * 0.7179054,
          size.width * 0.7118110,
          size.height * 0.7226351);
      path_6.close();

      Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
      paint_6_fill.color = Color(0xff91794C).withOpacity(1.0);
      canvas.drawPath(path_6, paint_6_fill);

      Path path_7 = Path();
      path_7.moveTo(size.width * 0.5251969, size.height * 0.8229730);
      path_7.lineTo(size.width * 0.5251969, size.height * 0.7949324);
      path_7.lineTo(size.width * 0.4716535, size.height * 0.7949324);
      path_7.lineTo(size.width * 0.4716535, size.height * 0.8310811);
      path_7.lineTo(size.width * 0.5000000, size.height * 0.8331081);
      path_7.lineTo(size.width * 0.5244094, size.height * 0.8310811);
      path_7.lineTo(size.width * 0.5244094, size.height * 0.8229730);
      path_7.lineTo(size.width * 0.5251969, size.height * 0.8229730);
      path_7.close();

      Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
      paint_7_fill.color = Color(0xffFFD064).withOpacity(1.0);
      canvas.drawPath(path_7, paint_7_fill);

      Path path_8 = Path();
      path_8.moveTo(size.width * 0.5322835, size.height * 0.7989865);
      path_8.lineTo(size.width * 0.4653543, size.height * 0.7989865);
      path_8.cubicTo(
          size.width * 0.4637795,
          size.height * 0.7989865,
          size.width * 0.4622047,
          size.height * 0.7989865,
          size.width * 0.4606299,
          size.height * 0.7986486);
      path_8.lineTo(size.width * 0.3968504, size.height * 0.7915541);
      path_8.cubicTo(
          size.width * 0.3606299,
          size.height * 0.7875000,
          size.width * 0.3283465,
          size.height * 0.7790541,
          size.width * 0.3031496,
          size.height * 0.7672297);
      path_8.cubicTo(
          size.width * 0.2787402,
          size.height * 0.7550676,
          size.width * 0.2629921,
          size.height * 0.7405405,
          size.width * 0.2582677,
          size.height * 0.7243243);
      path_8.cubicTo(
          size.width * 0.2559055,
          size.height * 0.7152027,
          size.width * 0.2622047,
          size.height * 0.7057432,
          size.width * 0.2763780,
          size.height * 0.6989865);
      path_8.cubicTo(
          size.width * 0.2905512,
          size.height * 0.6918919,
          size.width * 0.3110236,
          size.height * 0.6881757,
          size.width * 0.3330709,
          size.height * 0.6881757);
      path_8.lineTo(size.width * 0.6637795, size.height * 0.6881757);
      path_8.cubicTo(
          size.width * 0.6850394,
          size.height * 0.6881757,
          size.width * 0.7055118,
          size.height * 0.6922297,
          size.width * 0.7204724,
          size.height * 0.6989865);
      path_8.cubicTo(
          size.width * 0.7354331,
          size.height * 0.7057432,
          size.width * 0.7417323,
          size.height * 0.7152027,
          size.width * 0.7385827,
          size.height * 0.7243243);
      path_8.cubicTo(
          size.width * 0.7338583,
          size.height * 0.7402027,
          size.width * 0.7181102,
          size.height * 0.7550676,
          size.width * 0.6937008,
          size.height * 0.7672297);
      path_8.cubicTo(
          size.width * 0.6692913,
          size.height * 0.7793919,
          size.width * 0.6370079,
          size.height * 0.7878378,
          size.width * 0.6000000,
          size.height * 0.7915541);
      path_8.lineTo(size.width * 0.5362205, size.height * 0.7986486);
      path_8.cubicTo(
          size.width * 0.5354331,
          size.height * 0.7989865,
          size.width * 0.5338583,
          size.height * 0.7989865,
          size.width * 0.5322835,
          size.height * 0.7989865);
      path_8.close();
      path_8.moveTo(size.width * 0.4677165, size.height * 0.7837838);
      path_8.lineTo(size.width * 0.5299213, size.height * 0.7837838);
      path_8.lineTo(size.width * 0.5913386, size.height * 0.7770270);
      path_8.cubicTo(
          size.width * 0.6519685,
          size.height * 0.7706081,
          size.width * 0.6952756,
          size.height * 0.7489865,
          size.width * 0.7031496,
          size.height * 0.7226351);
      path_8.cubicTo(
          size.width * 0.7047244,
          size.height * 0.7179054,
          size.width * 0.7007874,
          size.height * 0.7128378,
          size.width * 0.6937008,
          size.height * 0.7091216);
      path_8.cubicTo(
          size.width * 0.6858268,
          size.height * 0.7054054,
          size.width * 0.6755906,
          size.height * 0.7033784,
          size.width * 0.6637795,
          size.height * 0.7033784);
      path_8.lineTo(size.width * 0.3330709, size.height * 0.7033784);
      path_8.cubicTo(
          size.width * 0.3220472,
          size.height * 0.7033784,
          size.width * 0.3110236,
          size.height * 0.7054054,
          size.width * 0.3031496,
          size.height * 0.7091216);
      path_8.cubicTo(
          size.width * 0.2952756,
          size.height * 0.7128378,
          size.width * 0.2921260,
          size.height * 0.7175676,
          size.width * 0.2937008,
          size.height * 0.7226351);
      path_8.cubicTo(
          size.width * 0.3015748,
          size.height * 0.7489865,
          size.width * 0.3456693,
          size.height * 0.7706081,
          size.width * 0.4055118,
          size.height * 0.7770270);
      path_8.lineTo(size.width * 0.4677165, size.height * 0.7837838);
      path_8.close();

      Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
      paint_8_fill.color = Color(0xffFFD064).withOpacity(1.0);
      canvas.drawPath(path_8, paint_8_fill);

      Path path_9 = Path();
      path_9.moveTo(size.width * 0.3724409, size.height * 0.6854730);
      path_9.lineTo(size.width * 0.3748031, size.height * 0.7523649);
      path_9.cubicTo(
          size.width * 0.3748031,
          size.height * 0.7827703,
          size.width * 0.4283472,
          size.height * 0.8067568,
          size.width * 0.4992134,
          size.height * 0.8067568);
      path_9.cubicTo(
          size.width * 0.5196858,
          size.height * 0.8067568,
          size.width * 0.5393709,
          size.height * 0.8064189,
          size.width * 0.5574811,
          size.height * 0.8027027);
      path_9.cubicTo(
          size.width * 0.5992134,
          size.height * 0.7935811,
          size.width * 0.6283472,
          size.height * 0.7750000,
          size.width * 0.6283472,
          size.height * 0.7533784);
      path_9.lineTo(size.width * 0.6283472, size.height * 0.6854730);
      path_9.lineTo(size.width * 0.3724409, size.height * 0.6854730);
      path_9.close();

      Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
      paint_9_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_9, paint_9_fill);

      Path path_10 = Path();
      path_10.moveTo(size.width * 0.5566929, size.height * 0.8027027);
      path_10.cubicTo(
          size.width * 0.5393701,
          size.height * 0.8064189,
          size.width * 0.5196850,
          size.height * 0.8084459,
          size.width * 0.4984252,
          size.height * 0.8084459);
      path_10.cubicTo(
          size.width * 0.4275591,
          size.height * 0.8084459,
          size.width * 0.3700787,
          size.height * 0.7837838,
          size.width * 0.3700787,
          size.height * 0.7533784);
      path_10.lineTo(size.width * 0.3700787, size.height * 0.6881757);
      path_10.lineTo(size.width * 0.3850394, size.height * 0.6844595);
      path_10.lineTo(size.width * 0.4055118, size.height * 0.6881757);
      path_10.lineTo(size.width * 0.4055118, size.height * 0.7483108);
      path_10.cubicTo(
          size.width * 0.4055118,
          size.height * 0.7787162,
          size.width * 0.4629921,
          size.height * 0.8033784,
          size.width * 0.5338583,
          size.height * 0.8033784);
      path_10.cubicTo(
          size.width * 0.5417323,
          size.height * 0.8037162,
          size.width * 0.5488189,
          size.height * 0.8033784,
          size.width * 0.5566929,
          size.height * 0.8027027);
      path_10.close();

      Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
      paint_10_fill.color = Color(0xffFFD064).withOpacity(1.0);
      canvas.drawPath(path_10, paint_10_fill);

      Path path_11 = Path();
      path_11.moveTo(size.width * 0.6401575, size.height * 0.6820946);
      path_11.cubicTo(
          size.width * 0.6401575,
          size.height * 0.6854730,
          size.width * 0.6338583,
          size.height * 0.6885135,
          size.width * 0.6251969,
          size.height * 0.6885135);
      path_11.lineTo(size.width * 0.3732283, size.height * 0.6885135);
      path_11.cubicTo(
          size.width * 0.3645669,
          size.height * 0.6885135,
          size.width * 0.3582677,
          size.height * 0.6854730,
          size.width * 0.3582677,
          size.height * 0.6820946);
      path_11.lineTo(size.width * 0.3582677, size.height * 0.6810811);
      path_11.cubicTo(
          size.width * 0.3582677,
          size.height * 0.6847973,
          size.width * 0.3653543,
          size.height * 0.6875000,
          size.width * 0.3732283,
          size.height * 0.6875000);
      path_11.lineTo(size.width * 0.6251969, size.height * 0.6875000);
      path_11.cubicTo(
          size.width * 0.6322835,
          size.height * 0.6875000,
          size.width * 0.6385827,
          size.height * 0.6851351,
          size.width * 0.6401575,
          size.height * 0.6820946);
      path_11.close();

      Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
      paint_11_fill.color = Color(0xffC6A054).withOpacity(1.0);
      canvas.drawPath(path_11, paint_11_fill);

      Path path_12 = Path();
      path_12.moveTo(size.width * 0.6393701, size.height * 0.6820946);
      path_12.cubicTo(
          size.width * 0.6385827,
          size.height * 0.6851351,
          size.width * 0.6322835,
          size.height * 0.6875000,
          size.width * 0.6251969,
          size.height * 0.6875000);
      path_12.lineTo(size.width * 0.3732283, size.height * 0.6875000);
      path_12.cubicTo(
          size.width * 0.3645669,
          size.height * 0.6875000,
          size.width * 0.3582677,
          size.height * 0.6844595,
          size.width * 0.3582677,
          size.height * 0.6810811);
      path_12.lineTo(size.width * 0.3582677, size.height * 0.6750000);
      path_12.cubicTo(
          size.width * 0.3582677,
          size.height * 0.6736486,
          size.width * 0.3606299,
          size.height * 0.6722973,
          size.width * 0.3645669,
          size.height * 0.6722973);
      path_12.lineTo(size.width * 0.3732283, size.height * 0.6722973);
      path_12.lineTo(size.width * 0.3732283, size.height * 0.6770270);
      path_12.cubicTo(
          size.width * 0.3732283,
          size.height * 0.6800676,
          size.width * 0.3787402,
          size.height * 0.6824324,
          size.width * 0.3858268,
          size.height * 0.6824324);
      path_12.lineTo(size.width * 0.6393701, size.height * 0.6824324);
      path_12.lineTo(size.width * 0.6393701, size.height * 0.6820946);
      path_12.close();

      Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
      paint_12_fill.color = Color(0xffE0C761).withOpacity(1.0);
      canvas.drawPath(path_12, paint_12_fill);

      Path path_13 = Path();
      path_13.moveTo(size.width * 0.6401583, size.height * 0.6746622);
      path_13.lineTo(size.width * 0.6401583, size.height * 0.6820946);
      path_13.lineTo(size.width * 0.3850402, size.height * 0.6820946);
      path_13.cubicTo(
          size.width * 0.3779535,
          size.height * 0.6820946,
          size.width * 0.3724409,
          size.height * 0.6797297,
          size.width * 0.3724409,
          size.height * 0.6766892);
      path_13.lineTo(size.width * 0.3724409, size.height * 0.6722973);
      path_13.lineTo(size.width * 0.6338583, size.height * 0.6722973);
      path_13.cubicTo(
          size.width * 0.6370087,
          size.height * 0.6719595,
          size.width * 0.6401583,
          size.height * 0.6733108,
          size.width * 0.6401583,
          size.height * 0.6746622);
      path_13.close();

      Paint paint_13_fill = Paint()..style = PaintingStyle.fill;
      paint_13_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_13, paint_13_fill);

      Path path_14 = Path();
      path_14.moveTo(size.width * 0.5826772, size.height * 0.8398649);
      path_14.lineTo(size.width * 0.5826772, size.height * 0.8466216);
      path_14.cubicTo(
          size.width * 0.5826772,
          size.height * 0.8476351,
          size.width * 0.5803150,
          size.height * 0.8486486,
          size.width * 0.5779528,
          size.height * 0.8486486);
      path_14.lineTo(size.width * 0.4188976, size.height * 0.8486486);
      path_14.cubicTo(
          size.width * 0.4165354,
          size.height * 0.8486486,
          size.width * 0.4141732,
          size.height * 0.8476351,
          size.width * 0.4141732,
          size.height * 0.8466216);
      path_14.lineTo(size.width * 0.4141732, size.height * 0.8368243);
      path_14.cubicTo(
          size.width * 0.4141732,
          size.height * 0.8337838,
          size.width * 0.4196850,
          size.height * 0.8314189,
          size.width * 0.4267717,
          size.height * 0.8314189);
      path_14.lineTo(size.width * 0.4314961, size.height * 0.8314189);
      path_14.lineTo(size.width * 0.4314961, size.height * 0.8381757);
      path_14.cubicTo(
          size.width * 0.4314961,
          size.height * 0.8391892,
          size.width * 0.4338583,
          size.height * 0.8402027,
          size.width * 0.4362205,
          size.height * 0.8402027);
      path_14.lineTo(size.width * 0.5826772, size.height * 0.8402027);
      path_14.lineTo(size.width * 0.5826772, size.height * 0.8398649);
      path_14.close();

      Paint paint_14_fill = Paint()..style = PaintingStyle.fill;
      paint_14_fill.color = Color(0xffFFD064).withOpacity(1.0);
      canvas.drawPath(path_14, paint_14_fill);

      Path path_15 = Path();
      path_15.moveTo(size.width * 0.4448819, size.height * 0.8398649);
      path_15.lineTo(size.width * 0.4370079, size.height * 0.8398649);
      path_15.cubicTo(
          size.width * 0.4346457,
          size.height * 0.8398649,
          size.width * 0.4322835,
          size.height * 0.8388514,
          size.width * 0.4322835,
          size.height * 0.8378378);
      path_15.lineTo(size.width * 0.4322835, size.height * 0.8344595);
      path_15.cubicTo(
          size.width * 0.4322835,
          size.height * 0.8371622,
          size.width * 0.4377953,
          size.height * 0.8398649,
          size.width * 0.4448819,
          size.height * 0.8398649);
      path_15.close();

      Paint paint_15_fill = Paint()..style = PaintingStyle.fill;
      paint_15_fill.color = Color(0xffFFD064).withOpacity(1.0);
      canvas.drawPath(path_15, paint_15_fill);

      Path path_16 = Path();
      path_16.moveTo(size.width * 0.5826772, size.height * 0.8371622);
      path_16.lineTo(size.width * 0.5826772, size.height * 0.8398649);
      path_16.lineTo(size.width * 0.4448819, size.height * 0.8398649);
      path_16.cubicTo(
          size.width * 0.4377953,
          size.height * 0.8398649,
          size.width * 0.4322835,
          size.height * 0.8375000,
          size.width * 0.4322835,
          size.height * 0.8344595);
      path_16.lineTo(size.width * 0.4322835, size.height * 0.8310811);
      path_16.lineTo(size.width * 0.5685039, size.height * 0.8310811);
      path_16.cubicTo(
          size.width * 0.5763780,
          size.height * 0.8310811,
          size.width * 0.5826772,
          size.height * 0.8337838,
          size.width * 0.5826772,
          size.height * 0.8371622);
      path_16.close();

      Paint paint_16_fill = Paint()..style = PaintingStyle.fill;
      paint_16_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_16, paint_16_fill);
    } else if (mColor == "gold" && !withCup) {
      Path path_6 = Path();
      path_6.moveTo(size.width * 0.7299220, size.height * 0.7466216);
      path_6.lineTo(size.width * 0.7267724, size.height * 0.7459459);
      path_6.cubicTo(
          size.width * 0.7165362,
          size.height * 0.7439189,
          size.width * 0.7047252,
          size.height * 0.7452703,
          size.width * 0.6968512,
          size.height * 0.7489865);
      path_6.cubicTo(
          size.width * 0.6984260,
          size.height * 0.7439189,
          size.width * 0.7000008,
          size.height * 0.7385135,
          size.width * 0.7000008,
          size.height * 0.7334459);
      path_6.cubicTo(
          size.width * 0.7000008,
          size.height * 0.7304054,
          size.width * 0.6992134,
          size.height * 0.7270270,
          size.width * 0.6992134,
          size.height * 0.7239865);
      path_6.lineTo(size.width * 0.7023630, size.height * 0.7239865);
      path_6.cubicTo(
          size.width * 0.7181110,
          size.height * 0.7239865,
          size.width * 0.7307094,
          size.height * 0.7179054,
          size.width * 0.7307094,
          size.height * 0.7104730);
      path_6.lineTo(size.width * 0.7307094, size.height * 0.7030405);
      path_6.cubicTo(
          size.width * 0.7307094,
          size.height * 0.7013514,
          size.width * 0.7283472,
          size.height * 0.7003378,
          size.width * 0.7244102,
          size.height * 0.7003378);
      path_6.lineTo(size.width * 0.7212606, size.height * 0.7003378);
      path_6.cubicTo(
          size.width * 0.7078748,
          size.height * 0.7003378,
          size.width * 0.6968512,
          size.height * 0.7047297,
          size.width * 0.6937016,
          size.height * 0.7104730);
      path_6.cubicTo(
          size.width * 0.6889772,
          size.height * 0.7016892,
          size.width * 0.6818906,
          size.height * 0.6929054,
          size.width * 0.6716543,
          size.height * 0.6851351);
      path_6.lineTo(size.width * 0.6740165, size.height * 0.6851351);
      path_6.cubicTo(
          size.width * 0.6897646,
          size.height * 0.6851351,
          size.width * 0.7023630,
          size.height * 0.6790541,
          size.width * 0.7023630,
          size.height * 0.6716216);
      path_6.lineTo(size.width * 0.7023630, size.height * 0.6641892);
      path_6.cubicTo(
          size.width * 0.7023630,
          size.height * 0.6625000,
          size.width * 0.7000008,
          size.height * 0.6614865,
          size.width * 0.6960638,
          size.height * 0.6614865);
      path_6.lineTo(size.width * 0.6929142, size.height * 0.6614865);
      path_6.cubicTo(
          size.width * 0.6771661,
          size.height * 0.6614865,
          size.width * 0.6645677,
          size.height * 0.6675676,
          size.width * 0.6645677,
          size.height * 0.6750000);
      path_6.lineTo(size.width * 0.6645677, size.height * 0.6797297);
      path_6.lineTo(size.width * 0.6645677, size.height * 0.6793919);
      path_6.cubicTo(
          size.width * 0.6535441,
          size.height * 0.6716216,
          size.width * 0.6393709,
          size.height * 0.6648649,
          size.width * 0.6244102,
          size.height * 0.6591216);
      path_6.cubicTo(
          size.width * 0.6401583,
          size.height * 0.6591216,
          size.width * 0.6527567,
          size.height * 0.6530405,
          size.width * 0.6527567,
          size.height * 0.6456081);
      path_6.lineTo(size.width * 0.6527567, size.height * 0.6381757);
      path_6.cubicTo(
          size.width * 0.6527567,
          size.height * 0.6364865,
          size.width * 0.6503945,
          size.height * 0.6354730,
          size.width * 0.6464575,
          size.height * 0.6354730);
      path_6.lineTo(size.width * 0.6433079, size.height * 0.6354730);
      path_6.cubicTo(
          size.width * 0.6275598,
          size.height * 0.6354730,
          size.width * 0.6149614,
          size.height * 0.6415541,
          size.width * 0.6149614,
          size.height * 0.6489865);
      path_6.lineTo(size.width * 0.6149614, size.height * 0.6557432);
      path_6.cubicTo(
          size.width * 0.6023630,
          size.height * 0.6516892,
          size.width * 0.5881898,
          size.height * 0.6479730,
          size.width * 0.5740165,
          size.height * 0.6452703);
      path_6.cubicTo(
          size.width * 0.5700795,
          size.height * 0.6445946,
          size.width * 0.5661425,
          size.height * 0.6456081,
          size.width * 0.5653551,
          size.height * 0.6472973);
      path_6.cubicTo(
          size.width * 0.5637803,
          size.height * 0.6489865,
          size.width * 0.5661425,
          size.height * 0.6510135,
          size.width * 0.5692921,
          size.height * 0.6516892);
      path_6.cubicTo(
          size.width * 0.5889772,
          size.height * 0.6550676,
          size.width * 0.6063000,
          size.height * 0.6604730,
          size.width * 0.6220480,
          size.height * 0.6665541);
      path_6.cubicTo(
          size.width * 0.6086622,
          size.height * 0.6638514,
          size.width * 0.5929142,
          size.height * 0.6665541,
          size.width * 0.5858276,
          size.height * 0.6726351);
      path_6.lineTo(size.width * 0.5842528, size.height * 0.6739865);
      path_6.cubicTo(
          size.width * 0.5826780,
          size.height * 0.6753378,
          size.width * 0.5834654,
          size.height * 0.6770270,
          size.width * 0.5866150,
          size.height * 0.6777027);
      path_6.lineTo(size.width * 0.6000008, size.height * 0.6810811);
      path_6.cubicTo(
          size.width * 0.6141740,
          size.height * 0.6844595,
          size.width * 0.6314969,
          size.height * 0.6820946,
          size.width * 0.6385835,
          size.height * 0.6753378);
      path_6.lineTo(size.width * 0.6393709, size.height * 0.6743243);
      path_6.cubicTo(
          size.width * 0.6440953,
          size.height * 0.6770270,
          size.width * 0.6488197,
          size.height * 0.6797297,
          size.width * 0.6535441,
          size.height * 0.6827703);
      path_6.cubicTo(
          size.width * 0.6708669,
          size.height * 0.6945946,
          size.width * 0.6811031,
          size.height * 0.7081081,
          size.width * 0.6850402,
          size.height * 0.7222973);
      path_6.cubicTo(
          size.width * 0.6795283,
          size.height * 0.7158784,
          size.width * 0.6637803,
          size.height * 0.7121622,
          size.width * 0.6496071,
          size.height * 0.7145270);
      path_6.lineTo(size.width * 0.6464575, size.height * 0.7152027);
      path_6.cubicTo(
          size.width * 0.6433079,
          size.height * 0.7155405,
          size.width * 0.6417331,
          size.height * 0.7172297,
          size.width * 0.6425205,
          size.height * 0.7189189);
      path_6.lineTo(size.width * 0.6472449, size.height * 0.7260135);
      path_6.cubicTo(
          size.width * 0.6519693,
          size.height * 0.7331081,
          size.width * 0.6685047,
          size.height * 0.7371622,
          size.width * 0.6834654,
          size.height * 0.7347973);
      path_6.lineTo(size.width * 0.6866150, size.height * 0.7344595);
      path_6.cubicTo(
          size.width * 0.6866150,
          size.height * 0.7459459,
          size.width * 0.6811031,
          size.height * 0.7570946,
          size.width * 0.6724417,
          size.height * 0.7672297);
      path_6.cubicTo(
          size.width * 0.6740165,
          size.height * 0.7597973,
          size.width * 0.6629929,
          size.height * 0.7530405,
          size.width * 0.6480323,
          size.height * 0.7520270);
      path_6.lineTo(size.width * 0.6448827, size.height * 0.7516892);
      path_6.cubicTo(
          size.width * 0.6417331,
          size.height * 0.7513514,
          size.width * 0.6385835,
          size.height * 0.7527027,
          size.width * 0.6385835,
          size.height * 0.7540541);
      path_6.lineTo(size.width * 0.6370087, size.height * 0.7614865);
      path_6.cubicTo(
          size.width * 0.6354339,
          size.height * 0.7689189,
          size.width * 0.6464575,
          size.height * 0.7756757,
          size.width * 0.6614181,
          size.height * 0.7766892);
      path_6.lineTo(size.width * 0.6637803, size.height * 0.7766892);
      path_6.cubicTo(
          size.width * 0.6464575,
          size.height * 0.7915541,
          size.width * 0.6196858,
          size.height * 0.8033784,
          size.width * 0.5881898,
          size.height * 0.8114865);
      path_6.cubicTo(
          size.width * 0.5944890,
          size.height * 0.8074324,
          size.width * 0.5952764,
          size.height * 0.8016892,
          size.width * 0.5897646,
          size.height * 0.7966216);
      path_6.lineTo(size.width * 0.5881898, size.height * 0.7952703);
      path_6.cubicTo(
          size.width * 0.5866150,
          size.height * 0.7939189,
          size.width * 0.5826780,
          size.height * 0.7935811,
          size.width * 0.5803157,
          size.height * 0.7942568);
      path_6.lineTo(size.width * 0.5669299, size.height * 0.7979730);
      path_6.cubicTo(
          size.width * 0.5535441,
          size.height * 0.8016892,
          size.width * 0.5488197,
          size.height * 0.8101351,
          size.width * 0.5566937,
          size.height * 0.8165541);
      path_6.lineTo(size.width * 0.5574811, size.height * 0.8175676);
      path_6.cubicTo(
          size.width * 0.5409457,
          size.height * 0.8199324,
          size.width * 0.5228354,
          size.height * 0.8212838,
          size.width * 0.5047252,
          size.height * 0.8212838);
      path_6.cubicTo(
          size.width * 0.4866150,
          size.height * 0.8212838,
          size.width * 0.4685047,
          size.height * 0.8199324,
          size.width * 0.4519693,
          size.height * 0.8175676);
      path_6.lineTo(size.width * 0.4527567, size.height * 0.8165541);
      path_6.cubicTo(
          size.width * 0.4606307,
          size.height * 0.8101351,
          size.width * 0.4559063,
          size.height * 0.8016892,
          size.width * 0.4425205,
          size.height * 0.7979730);
      path_6.lineTo(size.width * 0.4291346, size.height * 0.7942568);
      path_6.cubicTo(
          size.width * 0.4259850,
          size.height * 0.7935811,
          size.width * 0.4228354,
          size.height * 0.7939189,
          size.width * 0.4212606,
          size.height * 0.7952703);
      path_6.lineTo(size.width * 0.4196858, size.height * 0.7966216);
      path_6.cubicTo(
          size.width * 0.4141740,
          size.height * 0.8013514,
          size.width * 0.4149614,
          size.height * 0.8070946,
          size.width * 0.4212606,
          size.height * 0.8114865);
      path_6.cubicTo(
          size.width * 0.3897646,
          size.height * 0.8037162,
          size.width * 0.3637803,
          size.height * 0.7915541,
          size.width * 0.3456701,
          size.height * 0.7766892);
      path_6.lineTo(size.width * 0.3480323, size.height * 0.7766892);
      path_6.cubicTo(
          size.width * 0.3637803,
          size.height * 0.7756757,
          size.width * 0.3748039,
          size.height * 0.7689189,
          size.width * 0.3724417,
          size.height * 0.7614865);
      path_6.lineTo(size.width * 0.3708669, size.height * 0.7540541);
      path_6.cubicTo(
          size.width * 0.3700795,
          size.height * 0.7523649,
          size.width * 0.3677173,
          size.height * 0.7513514,
          size.width * 0.3645677,
          size.height * 0.7516892);
      path_6.lineTo(size.width * 0.3614181, size.height * 0.7520270);
      path_6.cubicTo(
          size.width * 0.3456701,
          size.height * 0.7530405,
          size.width * 0.3346465,
          size.height * 0.7597973,
          size.width * 0.3370087,
          size.height * 0.7672297);
      path_6.cubicTo(
          size.width * 0.3283472,
          size.height * 0.7570946,
          size.width * 0.3236228,
          size.height * 0.7459459,
          size.width * 0.3228354,
          size.height * 0.7344595);
      path_6.lineTo(size.width * 0.3259850, size.height * 0.7347973);
      path_6.cubicTo(
          size.width * 0.3409457,
          size.height * 0.7371622,
          size.width * 0.3566937,
          size.height * 0.7334459,
          size.width * 0.3622055,
          size.height * 0.7260135);
      path_6.lineTo(size.width * 0.3669299, size.height * 0.7189189);
      path_6.cubicTo(
          size.width * 0.3677173,
          size.height * 0.7175676,
          size.width * 0.3661425,
          size.height * 0.7158784,
          size.width * 0.3629929,
          size.height * 0.7152027);
      path_6.lineTo(size.width * 0.3598433, size.height * 0.7145270);
      path_6.cubicTo(
          size.width * 0.3456701,
          size.height * 0.7121622,
          size.width * 0.3307094,
          size.height * 0.7158784,
          size.width * 0.3244102,
          size.height * 0.7222973);
      path_6.cubicTo(
          size.width * 0.3283472,
          size.height * 0.7081081,
          size.width * 0.3385835,
          size.height * 0.6945946,
          size.width * 0.3559063,
          size.height * 0.6827703);
      path_6.cubicTo(
          size.width * 0.3598433,
          size.height * 0.6797297,
          size.width * 0.3645677,
          size.height * 0.6770270,
          size.width * 0.3700795,
          size.height * 0.6743243);
      path_6.lineTo(size.width * 0.3708669, size.height * 0.6753378);
      path_6.cubicTo(
          size.width * 0.3779535,
          size.height * 0.6820946,
          size.width * 0.3952764,
          size.height * 0.6844595,
          size.width * 0.4094496,
          size.height * 0.6810811);
      path_6.lineTo(size.width * 0.4228354, size.height * 0.6777027);
      path_6.cubicTo(
          size.width * 0.4259850,
          size.height * 0.6770270,
          size.width * 0.4267724,
          size.height * 0.6753378,
          size.width * 0.4251976,
          size.height * 0.6739865);
      path_6.lineTo(size.width * 0.4236228, size.height * 0.6726351);
      path_6.cubicTo(
          size.width * 0.4165362,
          size.height * 0.6662162,
          size.width * 0.4007882,
          size.height * 0.6638514,
          size.width * 0.3874024,
          size.height * 0.6665541);
      path_6.cubicTo(
          size.width * 0.4031504,
          size.height * 0.6601351,
          size.width * 0.4204732,
          size.height * 0.6550676,
          size.width * 0.4401583,
          size.height * 0.6516892);
      path_6.cubicTo(
          size.width * 0.4440953,
          size.height * 0.6510135,
          size.width * 0.4456701,
          size.height * 0.6489865,
          size.width * 0.4440953,
          size.height * 0.6472973);
      path_6.cubicTo(
          size.width * 0.4425205,
          size.height * 0.6456081,
          size.width * 0.4385835,
          size.height * 0.6445946,
          size.width * 0.4354339,
          size.height * 0.6452703);
      path_6.cubicTo(
          size.width * 0.4204732,
          size.height * 0.6479730,
          size.width * 0.4070874,
          size.height * 0.6513514,
          size.width * 0.3944890,
          size.height * 0.6557432);
      path_6.lineTo(size.width * 0.3944890, size.height * 0.6489865);
      path_6.cubicTo(
          size.width * 0.3944890,
          size.height * 0.6415541,
          size.width * 0.3818906,
          size.height * 0.6354730,
          size.width * 0.3661425,
          size.height * 0.6354730);
      path_6.lineTo(size.width * 0.3629929, size.height * 0.6354730);
      path_6.cubicTo(
          size.width * 0.3598433,
          size.height * 0.6354730,
          size.width * 0.3566937,
          size.height * 0.6368243,
          size.width * 0.3566937,
          size.height * 0.6381757);
      path_6.lineTo(size.width * 0.3566937, size.height * 0.6456081);
      path_6.cubicTo(
          size.width * 0.3566937,
          size.height * 0.6530405,
          size.width * 0.3692921,
          size.height * 0.6591216,
          size.width * 0.3850402,
          size.height * 0.6591216);
      path_6.cubicTo(
          size.width * 0.3700795,
          size.height * 0.6648649,
          size.width * 0.3559063,
          size.height * 0.6716216,
          size.width * 0.3448827,
          size.height * 0.6793919);
      path_6.lineTo(size.width * 0.3448827, size.height * 0.6797297);
      path_6.lineTo(size.width * 0.3448827, size.height * 0.6750000);
      path_6.cubicTo(
          size.width * 0.3448827,
          size.height * 0.6675676,
          size.width * 0.3322843,
          size.height * 0.6614865,
          size.width * 0.3165362,
          size.height * 0.6614865);
      path_6.lineTo(size.width * 0.3133866, size.height * 0.6614865);
      path_6.cubicTo(
          size.width * 0.3102370,
          size.height * 0.6614865,
          size.width * 0.3070874,
          size.height * 0.6628378,
          size.width * 0.3070874,
          size.height * 0.6641892);
      path_6.lineTo(size.width * 0.3070874, size.height * 0.6716216);
      path_6.cubicTo(
          size.width * 0.3070874,
          size.height * 0.6790541,
          size.width * 0.3196858,
          size.height * 0.6851351,
          size.width * 0.3354339,
          size.height * 0.6851351);
      path_6.lineTo(size.width * 0.3377961, size.height * 0.6851351);
      path_6.cubicTo(
          size.width * 0.3275598,
          size.height * 0.6932432,
          size.width * 0.3204732,
          size.height * 0.7016892,
          size.width * 0.3157488,
          size.height * 0.7104730);
      path_6.cubicTo(
          size.width * 0.3125992,
          size.height * 0.7047297,
          size.width * 0.3015756,
          size.height * 0.7003378,
          size.width * 0.2881898,
          size.height * 0.7003378);
      path_6.lineTo(size.width * 0.2850402, size.height * 0.7003378);
      path_6.cubicTo(
          size.width * 0.2818906,
          size.height * 0.7003378,
          size.width * 0.2787409,
          size.height * 0.7016892,
          size.width * 0.2787409,
          size.height * 0.7030405);
      path_6.lineTo(size.width * 0.2787409, size.height * 0.7104730);
      path_6.cubicTo(
          size.width * 0.2787409,
          size.height * 0.7179054,
          size.width * 0.2913394,
          size.height * 0.7239865,
          size.width * 0.3070874,
          size.height * 0.7239865);
      path_6.cubicTo(
          size.width * 0.3063000,
          size.height * 0.7270270,
          size.width * 0.3063000,
          size.height * 0.7300676,
          size.width * 0.3063000,
          size.height * 0.7334459);
      path_6.cubicTo(
          size.width * 0.3063000,
          size.height * 0.7388514,
          size.width * 0.3070874,
          size.height * 0.7439189,
          size.width * 0.3094496,
          size.height * 0.7489865);
      path_6.cubicTo(
          size.width * 0.3015756,
          size.height * 0.7456081,
          size.width * 0.2905520,
          size.height * 0.7442568,
          size.width * 0.2795283,
          size.height * 0.7459459);
      path_6.lineTo(size.width * 0.2755913, size.height * 0.7466216);
      path_6.cubicTo(
          size.width * 0.2724417,
          size.height * 0.7472973,
          size.width * 0.2708669,
          size.height * 0.7489865,
          size.width * 0.2724417,
          size.height * 0.7503378);
      path_6.lineTo(size.width * 0.2779535, size.height * 0.7570946);
      path_6.cubicTo(
          size.width * 0.2834654,
          size.height * 0.7641892,
          size.width * 0.3000008,
          size.height * 0.7675676,
          size.width * 0.3149614,
          size.height * 0.7652027);
      path_6.lineTo(size.width * 0.3181110, size.height * 0.7648649);
      path_6.cubicTo(
          size.width * 0.3228354,
          size.height * 0.7712838,
          size.width * 0.3291346,
          size.height * 0.7773649,
          size.width * 0.3362213,
          size.height * 0.7831081);
      path_6.cubicTo(
          size.width * 0.3259850,
          size.height * 0.7810811,
          size.width * 0.3133866,
          size.height * 0.7820946,
          size.width * 0.3047252,
          size.height * 0.7861486);
      path_6.lineTo(size.width * 0.3023630, size.height * 0.7871622);
      path_6.cubicTo(
          size.width * 0.3000008,
          size.height * 0.7881757,
          size.width * 0.3000008,
          size.height * 0.7902027,
          size.width * 0.3023630,
          size.height * 0.7912162);
      path_6.lineTo(size.width * 0.3133866, size.height * 0.7962838);
      path_6.cubicTo(
          size.width * 0.3244102,
          size.height * 0.8016892,
          size.width * 0.3425205,
          size.height * 0.8016892,
          size.width * 0.3535441,
          size.height * 0.7962838);
      path_6.lineTo(size.width * 0.3551189, size.height * 0.7952703);
      path_6.cubicTo(
          size.width * 0.3637803,
          size.height * 0.8000000,
          size.width * 0.3732291,
          size.height * 0.8043919,
          size.width * 0.3842528,
          size.height * 0.8084459);
      path_6.cubicTo(
          size.width * 0.3755913,
          size.height * 0.8087838,
          size.width * 0.3669299,
          size.height * 0.8111486,
          size.width * 0.3622055,
          size.height * 0.8155405);
      path_6.lineTo(size.width * 0.3606307, size.height * 0.8168919);
      path_6.cubicTo(
          size.width * 0.3590559,
          size.height * 0.8182432,
          size.width * 0.3598433,
          size.height * 0.8199324,
          size.width * 0.3629929,
          size.height * 0.8206081);
      path_6.lineTo(size.width * 0.3763787, size.height * 0.8243243);
      path_6.cubicTo(
          size.width * 0.3897646,
          size.height * 0.8280405,
          size.width * 0.4070874,
          size.height * 0.8256757,
          size.width * 0.4149614,
          size.height * 0.8189189);
      path_6.lineTo(size.width * 0.4165362, size.height * 0.8179054);
      path_6.cubicTo(
          size.width * 0.4425205,
          size.height * 0.8243243,
          size.width * 0.4724417,
          size.height * 0.8277027,
          size.width * 0.5039378,
          size.height * 0.8277027);
      path_6.cubicTo(
          size.width * 0.5354339,
          size.height * 0.8277027,
          size.width * 0.5645677,
          size.height * 0.8243243,
          size.width * 0.5913394,
          size.height * 0.8179054);
      path_6.lineTo(size.width * 0.5929142, size.height * 0.8189189);
      path_6.cubicTo(
          size.width * 0.6007882,
          size.height * 0.8253378,
          size.width * 0.6181110,
          size.height * 0.8277027,
          size.width * 0.6314969,
          size.height * 0.8243243);
      path_6.lineTo(size.width * 0.6448827, size.height * 0.8206081);
      path_6.cubicTo(
          size.width * 0.6480323,
          size.height * 0.8199324,
          size.width * 0.6488197,
          size.height * 0.8182432,
          size.width * 0.6472449,
          size.height * 0.8168919);
      path_6.lineTo(size.width * 0.6456701, size.height * 0.8155405);
      path_6.cubicTo(
          size.width * 0.6409457,
          size.height * 0.8114865,
          size.width * 0.6322843,
          size.height * 0.8091216,
          size.width * 0.6236228,
          size.height * 0.8084459);
      path_6.cubicTo(
          size.width * 0.6338591,
          size.height * 0.8047297,
          size.width * 0.6440953,
          size.height * 0.8003378,
          size.width * 0.6527567,
          size.height * 0.7952703);
      path_6.lineTo(size.width * 0.6543315, size.height * 0.7962838);
      path_6.cubicTo(
          size.width * 0.6653551,
          size.height * 0.8016892,
          size.width * 0.6834654,
          size.height * 0.8016892,
          size.width * 0.6944890,
          size.height * 0.7962838);
      path_6.lineTo(size.width * 0.7055126, size.height * 0.7912162);
      path_6.cubicTo(
          size.width * 0.7078748,
          size.height * 0.7902027,
          size.width * 0.7078748,
          size.height * 0.7881757,
          size.width * 0.7055126,
          size.height * 0.7871622);
      path_6.lineTo(size.width * 0.7031504, size.height * 0.7861486);
      path_6.cubicTo(
          size.width * 0.6944890,
          size.height * 0.7820946,
          size.width * 0.6818906,
          size.height * 0.7810811,
          size.width * 0.6716543,
          size.height * 0.7831081);
      path_6.cubicTo(
          size.width * 0.6787409,
          size.height * 0.7773649,
          size.width * 0.6850402,
          size.height * 0.7712838,
          size.width * 0.6897646,
          size.height * 0.7648649);
      path_6.lineTo(size.width * 0.6929142, size.height * 0.7652027);
      path_6.cubicTo(
          size.width * 0.7078748,
          size.height * 0.7679054,
          size.width * 0.7244102,
          size.height * 0.7641892,
          size.width * 0.7299220,
          size.height * 0.7570946);
      path_6.lineTo(size.width * 0.7354339, size.height * 0.7503378);
      path_6.cubicTo(
          size.width * 0.7338591,
          size.height * 0.7489865,
          size.width * 0.7330717,
          size.height * 0.7472973,
          size.width * 0.7299220,
          size.height * 0.7466216);
      path_6.close();

      Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
      paint_6_fill.color = Color(0xff91794C).withOpacity(1.0);
      canvas.drawPath(path_6, paint_6_fill);
      Path path_7 = Path();
      path_7.moveTo(size.width * 0.3834646, size.height * 0.6591216);
      path_7.lineTo(size.width * 0.3740157, size.height * 0.6591216);
      path_7.cubicTo(
          size.width * 0.3582677,
          size.height * 0.6591216,
          size.width * 0.3456693,
          size.height * 0.6530405,
          size.width * 0.3456693,
          size.height * 0.6456081);
      path_7.lineTo(size.width * 0.3456693, size.height * 0.6381757);
      path_7.cubicTo(
          size.width * 0.3456693,
          size.height * 0.6364865,
          size.width * 0.3480315,
          size.height * 0.6354730,
          size.width * 0.3519685,
          size.height * 0.6354730);
      path_7.lineTo(size.width * 0.3551181, size.height * 0.6354730);
      path_7.cubicTo(
          size.width * 0.3708661,
          size.height * 0.6354730,
          size.width * 0.3834646,
          size.height * 0.6415541,
          size.width * 0.3834646,
          size.height * 0.6489865);
      path_7.lineTo(size.width * 0.3834646, size.height * 0.6591216);
      path_7.close();

      Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
      paint_7_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_7, paint_7_fill);

      Path path_8 = Path();
      path_8.moveTo(size.width * 0.3559063, size.height * 0.6716216);
      path_8.lineTo(size.width * 0.3606307, size.height * 0.6756757);
      path_8.cubicTo(
          size.width * 0.3677173,
          size.height * 0.6824324,
          size.width * 0.3850402,
          size.height * 0.6847973,
          size.width * 0.3992134,
          size.height * 0.6814189);
      path_8.lineTo(size.width * 0.4125992, size.height * 0.6780405);
      path_8.cubicTo(
          size.width * 0.4157488,
          size.height * 0.6773649,
          size.width * 0.4165362,
          size.height * 0.6756757,
          size.width * 0.4149614,
          size.height * 0.6743243);
      path_8.lineTo(size.width * 0.4133866, size.height * 0.6729730);
      path_8.cubicTo(
          size.width * 0.4063000,
          size.height * 0.6662162,
          size.width * 0.3889772,
          size.height * 0.6638514,
          size.width * 0.3748039,
          size.height * 0.6672297);
      path_8.lineTo(size.width * 0.3559063, size.height * 0.6716216);
      path_8.close();

      Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
      paint_8_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_8, paint_8_fill);

      Path path_9 = Path();
      path_9.moveTo(size.width * 0.3330709, size.height * 0.6851351);
      path_9.lineTo(size.width * 0.3236220, size.height * 0.6851351);
      path_9.cubicTo(
          size.width * 0.3078740,
          size.height * 0.6851351,
          size.width * 0.2952756,
          size.height * 0.6790541,
          size.width * 0.2952756,
          size.height * 0.6716216);
      path_9.lineTo(size.width * 0.2952756, size.height * 0.6641892);
      path_9.cubicTo(
          size.width * 0.2952756,
          size.height * 0.6625000,
          size.width * 0.2976378,
          size.height * 0.6614865,
          size.width * 0.3015748,
          size.height * 0.6614865);
      path_9.lineTo(size.width * 0.3047244, size.height * 0.6614865);
      path_9.cubicTo(
          size.width * 0.3204724,
          size.height * 0.6614865,
          size.width * 0.3330709,
          size.height * 0.6675676,
          size.width * 0.3330709,
          size.height * 0.6750000);
      path_9.lineTo(size.width * 0.3330709, size.height * 0.6851351);
      path_9.close();

      Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
      paint_9_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_9, paint_9_fill);

      Path path_10 = Path();
      path_10.moveTo(size.width * 0.3055118, size.height * 0.7239865);
      path_10.lineTo(size.width * 0.2960630, size.height * 0.7239865);
      path_10.cubicTo(
          size.width * 0.2803150,
          size.height * 0.7239865,
          size.width * 0.2677165,
          size.height * 0.7179054,
          size.width * 0.2677165,
          size.height * 0.7104730);
      path_10.lineTo(size.width * 0.2677165, size.height * 0.7030405);
      path_10.cubicTo(
          size.width * 0.2677165,
          size.height * 0.7013514,
          size.width * 0.2700787,
          size.height * 0.7003378,
          size.width * 0.2740157,
          size.height * 0.7003378);
      path_10.lineTo(size.width * 0.2771654, size.height * 0.7003378);
      path_10.cubicTo(
          size.width * 0.2929134,
          size.height * 0.7003378,
          size.width * 0.3055118,
          size.height * 0.7064189,
          size.width * 0.3055118,
          size.height * 0.7138514);
      path_10.lineTo(size.width * 0.3055118, size.height * 0.7239865);
      path_10.close();

      Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
      paint_10_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_10, paint_10_fill);

      Path path_11 = Path();
      path_11.moveTo(size.width * 0.3062992, size.height * 0.7331081);
      path_11.lineTo(size.width * 0.3149606, size.height * 0.7344595);
      path_11.cubicTo(
          size.width * 0.3299213,
          size.height * 0.7368243,
          size.width * 0.3456693,
          size.height * 0.7331081,
          size.width * 0.3511811,
          size.height * 0.7256757);
      path_11.lineTo(size.width * 0.3559055, size.height * 0.7185811);
      path_11.cubicTo(
          size.width * 0.3566929,
          size.height * 0.7172297,
          size.width * 0.3551181,
          size.height * 0.7155405,
          size.width * 0.3519685,
          size.height * 0.7148649);
      path_11.lineTo(size.width * 0.3488189, size.height * 0.7141892);
      path_11.cubicTo(
          size.width * 0.3338583,
          size.height * 0.7118243,
          size.width * 0.3181102,
          size.height * 0.7155405,
          size.width * 0.3125984,
          size.height * 0.7229730);
      path_11.lineTo(size.width * 0.3062992, size.height * 0.7331081);
      path_11.close();

      Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
      paint_11_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_11, paint_11_fill);

      Path path_12 = Path();
      path_12.moveTo(size.width * 0.3283472, size.height * 0.7770270);
      path_12.lineTo(size.width * 0.3377961, size.height * 0.7763514);
      path_12.cubicTo(
          size.width * 0.3535441,
          size.height * 0.7753378,
          size.width * 0.3645677,
          size.height * 0.7685811,
          size.width * 0.3622055,
          size.height * 0.7611486);
      path_12.lineTo(size.width * 0.3606307, size.height * 0.7537162);
      path_12.cubicTo(
          size.width * 0.3598433,
          size.height * 0.7520270,
          size.width * 0.3574811,
          size.height * 0.7510135,
          size.width * 0.3543315,
          size.height * 0.7513514);
      path_12.lineTo(size.width * 0.3511819, size.height * 0.7516892);
      path_12.cubicTo(
          size.width * 0.3354339,
          size.height * 0.7527027,
          size.width * 0.3244102,
          size.height * 0.7594595,
          size.width * 0.3267724,
          size.height * 0.7668919);
      path_12.lineTo(size.width * 0.3283472, size.height * 0.7770270);
      path_12.close();

      Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
      paint_12_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_12, paint_12_fill);

      Path path_13 = Path();
      path_13.moveTo(size.width * 0.3157480, size.height * 0.7635135);
      path_13.lineTo(size.width * 0.3070866, size.height * 0.7652027);
      path_13.cubicTo(
          size.width * 0.2921260,
          size.height * 0.7679054,
          size.width * 0.2755906,
          size.height * 0.7641892,
          size.width * 0.2700787,
          size.height * 0.7570946);
      path_13.lineTo(size.width * 0.2645669, size.height * 0.7503378);
      path_13.cubicTo(
          size.width * 0.2637795,
          size.height * 0.7489865,
          size.width * 0.2645669,
          size.height * 0.7472973,
          size.width * 0.2677165,
          size.height * 0.7466216);
      path_13.lineTo(size.width * 0.2708661, size.height * 0.7459459);
      path_13.cubicTo(
          size.width * 0.2858268,
          size.height * 0.7432432,
          size.width * 0.3023622,
          size.height * 0.7469595,
          size.width * 0.3078740,
          size.height * 0.7540541);
      path_13.lineTo(size.width * 0.3157480, size.height * 0.7635135);
      path_13.close();

      Paint paint_13_fill = Paint()..style = PaintingStyle.fill;
      paint_13_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_13, paint_13_fill);

      Path path_14 = Path();
      path_14.moveTo(size.width * 0.3519685, size.height * 0.7932432);
      path_14.lineTo(size.width * 0.3456693, size.height * 0.7962838);
      path_14.cubicTo(
          size.width * 0.3346457,
          size.height * 0.8016892,
          size.width * 0.3165354,
          size.height * 0.8016892,
          size.width * 0.3055118,
          size.height * 0.7962838);
      path_14.lineTo(size.width * 0.2944882, size.height * 0.7912162);
      path_14.cubicTo(
          size.width * 0.2921260,
          size.height * 0.7902027,
          size.width * 0.2921260,
          size.height * 0.7881757,
          size.width * 0.2944882,
          size.height * 0.7871622);
      path_14.lineTo(size.width * 0.2968504, size.height * 0.7861486);
      path_14.cubicTo(
          size.width * 0.3078740,
          size.height * 0.7807432,
          size.width * 0.3259843,
          size.height * 0.7807432,
          size.width * 0.3370079,
          size.height * 0.7861486);
      path_14.lineTo(size.width * 0.3519685, size.height * 0.7932432);
      path_14.close();

      Paint paint_14_fill = Paint()..style = PaintingStyle.fill;
      paint_14_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_14, paint_14_fill);

      Path path_15 = Path();
      path_15.moveTo(size.width * 0.4110244, size.height * 0.8152027);
      path_15.lineTo(size.width * 0.4063000, size.height * 0.8192568);
      path_15.cubicTo(
          size.width * 0.3984260,
          size.height * 0.8256757,
          size.width * 0.3811031,
          size.height * 0.8280405,
          size.width * 0.3677173,
          size.height * 0.8246622);
      path_15.lineTo(size.width * 0.3543315, size.height * 0.8209459);
      path_15.cubicTo(
          size.width * 0.3511819,
          size.height * 0.8202703,
          size.width * 0.3503945,
          size.height * 0.8185811,
          size.width * 0.3519693,
          size.height * 0.8172297);
      path_15.lineTo(size.width * 0.3535441, size.height * 0.8158784);
      path_15.cubicTo(
          size.width * 0.3614181,
          size.height * 0.8094595,
          size.width * 0.3787409,
          size.height * 0.8070946,
          size.width * 0.3921268,
          size.height * 0.8104730);
      path_15.lineTo(size.width * 0.4110244, size.height * 0.8152027);
      path_15.close();

      Paint paint_15_fill = Paint()..style = PaintingStyle.fill;
      paint_15_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_15, paint_15_fill);

      Path path_16 = Path();
      path_16.moveTo(size.width * 0.4385827, size.height * 0.8202703);
      path_16.lineTo(size.width * 0.4433071, size.height * 0.8162162);
      path_16.cubicTo(
          size.width * 0.4511811,
          size.height * 0.8097973,
          size.width * 0.4464567,
          size.height * 0.8013514,
          size.width * 0.4330709,
          size.height * 0.7976351);
      path_16.lineTo(size.width * 0.4196850, size.height * 0.7939189);
      path_16.cubicTo(
          size.width * 0.4165354,
          size.height * 0.7932432,
          size.width * 0.4133858,
          size.height * 0.7935811,
          size.width * 0.4118110,
          size.height * 0.7949324);
      path_16.lineTo(size.width * 0.4102362, size.height * 0.7962838);
      path_16.cubicTo(
          size.width * 0.4023622,
          size.height * 0.8027027,
          size.width * 0.4070866,
          size.height * 0.8111486,
          size.width * 0.4204724,
          size.height * 0.8148649);
      path_16.lineTo(size.width * 0.4385827, size.height * 0.8202703);
      path_16.close();

      Paint paint_16_fill = Paint()..style = PaintingStyle.fill;
      paint_16_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_16, paint_16_fill);

      Path path_17 = Path();
      path_17.moveTo(size.width * 0.6062992, size.height * 0.6591216);
      path_17.lineTo(size.width * 0.6157480, size.height * 0.6591216);
      path_17.cubicTo(
          size.width * 0.6314961,
          size.height * 0.6591216,
          size.width * 0.6440945,
          size.height * 0.6530405,
          size.width * 0.6440945,
          size.height * 0.6456081);
      path_17.lineTo(size.width * 0.6440945, size.height * 0.6381757);
      path_17.cubicTo(
          size.width * 0.6440945,
          size.height * 0.6364865,
          size.width * 0.6417323,
          size.height * 0.6354730,
          size.width * 0.6377953,
          size.height * 0.6354730);
      path_17.lineTo(size.width * 0.6346457, size.height * 0.6354730);
      path_17.cubicTo(
          size.width * 0.6188976,
          size.height * 0.6354730,
          size.width * 0.6062992,
          size.height * 0.6415541,
          size.width * 0.6062992,
          size.height * 0.6489865);
      path_17.lineTo(size.width * 0.6062992, size.height * 0.6591216);
      path_17.close();

      Paint paint_17_fill = Paint()..style = PaintingStyle.fill;
      paint_17_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_17, paint_17_fill);

      Path path_18 = Path();
      path_18.moveTo(size.width * 0.6338583, size.height * 0.6716216);
      path_18.lineTo(size.width * 0.6299213, size.height * 0.6756757);
      path_18.cubicTo(
          size.width * 0.6228346,
          size.height * 0.6824324,
          size.width * 0.6055118,
          size.height * 0.6847973,
          size.width * 0.5913386,
          size.height * 0.6814189);
      path_18.lineTo(size.width * 0.5779528, size.height * 0.6780405);
      path_18.cubicTo(
          size.width * 0.5748031,
          size.height * 0.6773649,
          size.width * 0.5740157,
          size.height * 0.6756757,
          size.width * 0.5755906,
          size.height * 0.6743243);
      path_18.lineTo(size.width * 0.5771654, size.height * 0.6729730);
      path_18.cubicTo(
          size.width * 0.5842520,
          size.height * 0.6662162,
          size.width * 0.6015748,
          size.height * 0.6638514,
          size.width * 0.6157480,
          size.height * 0.6672297);
      path_18.lineTo(size.width * 0.6338583, size.height * 0.6716216);
      path_18.close();

      Paint paint_18_fill = Paint()..style = PaintingStyle.fill;
      paint_18_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_18, paint_18_fill);

      Path path_19 = Path();
      path_19.moveTo(size.width * 0.6559055, size.height * 0.6851351);
      path_19.lineTo(size.width * 0.6653543, size.height * 0.6851351);
      path_19.cubicTo(
          size.width * 0.6811024,
          size.height * 0.6851351,
          size.width * 0.6937008,
          size.height * 0.6790541,
          size.width * 0.6937008,
          size.height * 0.6716216);
      path_19.lineTo(size.width * 0.6937008, size.height * 0.6641892);
      path_19.cubicTo(
          size.width * 0.6937008,
          size.height * 0.6625000,
          size.width * 0.6913386,
          size.height * 0.6614865,
          size.width * 0.6874016,
          size.height * 0.6614865);
      path_19.lineTo(size.width * 0.6850394, size.height * 0.6614865);
      path_19.cubicTo(
          size.width * 0.6692913,
          size.height * 0.6614865,
          size.width * 0.6566929,
          size.height * 0.6675676,
          size.width * 0.6566929,
          size.height * 0.6750000);
      path_19.lineTo(size.width * 0.6566929, size.height * 0.6851351);
      path_19.lineTo(size.width * 0.6559055, size.height * 0.6851351);
      path_19.close();

      Paint paint_19_fill = Paint()..style = PaintingStyle.fill;
      paint_19_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_19, paint_19_fill);

      Path path_20 = Path();
      path_20.moveTo(size.width * 0.6842520, size.height * 0.7239865);
      path_20.lineTo(size.width * 0.6937008, size.height * 0.7239865);
      path_20.cubicTo(
          size.width * 0.7094488,
          size.height * 0.7239865,
          size.width * 0.7220472,
          size.height * 0.7179054,
          size.width * 0.7220472,
          size.height * 0.7104730);
      path_20.lineTo(size.width * 0.7220472, size.height * 0.7030405);
      path_20.cubicTo(
          size.width * 0.7220472,
          size.height * 0.7013514,
          size.width * 0.7196850,
          size.height * 0.7003378,
          size.width * 0.7157480,
          size.height * 0.7003378);
      path_20.lineTo(size.width * 0.7125984, size.height * 0.7003378);
      path_20.cubicTo(
          size.width * 0.6968504,
          size.height * 0.7003378,
          size.width * 0.6842520,
          size.height * 0.7064189,
          size.width * 0.6842520,
          size.height * 0.7138514);
      path_20.lineTo(size.width * 0.6842520, size.height * 0.7239865);
      path_20.close();

      Paint paint_20_fill = Paint()..style = PaintingStyle.fill;
      paint_20_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_20, paint_20_fill);

      Path path_21 = Path();
      path_21.moveTo(size.width * 0.6834654, size.height * 0.7331081);
      path_21.lineTo(size.width * 0.6748039, size.height * 0.7344595);
      path_21.cubicTo(
          size.width * 0.6598433,
          size.height * 0.7368243,
          size.width * 0.6440953,
          size.height * 0.7331081,
          size.width * 0.6385835,
          size.height * 0.7256757);
      path_21.lineTo(size.width * 0.6338591, size.height * 0.7185811);
      path_21.cubicTo(
          size.width * 0.6330717,
          size.height * 0.7172297,
          size.width * 0.6346465,
          size.height * 0.7155405,
          size.width * 0.6377961,
          size.height * 0.7148649);
      path_21.lineTo(size.width * 0.6409457, size.height * 0.7141892);
      path_21.cubicTo(
          size.width * 0.6559063,
          size.height * 0.7118243,
          size.width * 0.6716543,
          size.height * 0.7155405,
          size.width * 0.6771661,
          size.height * 0.7229730);
      path_21.lineTo(size.width * 0.6834654, size.height * 0.7331081);
      path_21.close();

      Paint paint_21_fill = Paint()..style = PaintingStyle.fill;
      paint_21_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_21, paint_21_fill);

      Path path_22 = Path();
      path_22.moveTo(size.width * 0.6614173, size.height * 0.7770270);
      path_22.lineTo(size.width * 0.6519685, size.height * 0.7763514);
      path_22.cubicTo(
          size.width * 0.6362205,
          size.height * 0.7753378,
          size.width * 0.6251969,
          size.height * 0.7685811,
          size.width * 0.6275591,
          size.height * 0.7611486);
      path_22.lineTo(size.width * 0.6291339, size.height * 0.7537162);
      path_22.cubicTo(
          size.width * 0.6299213,
          size.height * 0.7520270,
          size.width * 0.6322835,
          size.height * 0.7510135,
          size.width * 0.6354331,
          size.height * 0.7513514);
      path_22.lineTo(size.width * 0.6385827, size.height * 0.7516892);
      path_22.cubicTo(
          size.width * 0.6543307,
          size.height * 0.7527027,
          size.width * 0.6653543,
          size.height * 0.7594595,
          size.width * 0.6629921,
          size.height * 0.7668919);
      path_22.lineTo(size.width * 0.6614173, size.height * 0.7770270);
      path_22.close();

      Paint paint_22_fill = Paint()..style = PaintingStyle.fill;
      paint_22_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_22, paint_22_fill);

      Path path_23 = Path();
      path_23.moveTo(size.width * 0.6740157, size.height * 0.7635135);
      path_23.lineTo(size.width * 0.6826772, size.height * 0.7652027);
      path_23.cubicTo(
          size.width * 0.6976378,
          size.height * 0.7679054,
          size.width * 0.7141732,
          size.height * 0.7641892,
          size.width * 0.7196850,
          size.height * 0.7570946);
      path_23.lineTo(size.width * 0.7251969, size.height * 0.7503378);
      path_23.cubicTo(
          size.width * 0.7259843,
          size.height * 0.7489865,
          size.width * 0.7251969,
          size.height * 0.7472973,
          size.width * 0.7220472,
          size.height * 0.7466216);
      path_23.lineTo(size.width * 0.7188976, size.height * 0.7459459);
      path_23.cubicTo(
          size.width * 0.7039370,
          size.height * 0.7432432,
          size.width * 0.6874016,
          size.height * 0.7469595,
          size.width * 0.6818898,
          size.height * 0.7540541);
      path_23.lineTo(size.width * 0.6740157, size.height * 0.7635135);
      path_23.close();

      Paint paint_23_fill = Paint()..style = PaintingStyle.fill;
      paint_23_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_23, paint_23_fill);

      Path path_24 = Path();
      path_24.moveTo(size.width * 0.6377953, size.height * 0.7932432);
      path_24.lineTo(size.width * 0.6440945, size.height * 0.7962838);
      path_24.cubicTo(
          size.width * 0.6551181,
          size.height * 0.8016892,
          size.width * 0.6732283,
          size.height * 0.8016892,
          size.width * 0.6842520,
          size.height * 0.7962838);
      path_24.lineTo(size.width * 0.6952756, size.height * 0.7912162);
      path_24.cubicTo(
          size.width * 0.6976378,
          size.height * 0.7902027,
          size.width * 0.6976378,
          size.height * 0.7881757,
          size.width * 0.6952756,
          size.height * 0.7871622);
      path_24.lineTo(size.width * 0.6929134, size.height * 0.7861486);
      path_24.cubicTo(
          size.width * 0.6818898,
          size.height * 0.7807432,
          size.width * 0.6637795,
          size.height * 0.7807432,
          size.width * 0.6527559,
          size.height * 0.7861486);
      path_24.lineTo(size.width * 0.6377953, size.height * 0.7932432);
      path_24.close();

      Paint paint_24_fill = Paint()..style = PaintingStyle.fill;
      paint_24_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_24, paint_24_fill);

      Path path_25 = Path();
      path_25.moveTo(size.width * 0.5787402, size.height * 0.8152027);
      path_25.lineTo(size.width * 0.5834646, size.height * 0.8192568);
      path_25.cubicTo(
          size.width * 0.5913386,
          size.height * 0.8256757,
          size.width * 0.6086614,
          size.height * 0.8280405,
          size.width * 0.6220472,
          size.height * 0.8246622);
      path_25.lineTo(size.width * 0.6354331, size.height * 0.8209459);
      path_25.cubicTo(
          size.width * 0.6385827,
          size.height * 0.8202703,
          size.width * 0.6393701,
          size.height * 0.8185811,
          size.width * 0.6377953,
          size.height * 0.8172297);
      path_25.lineTo(size.width * 0.6362205, size.height * 0.8158784);
      path_25.cubicTo(
          size.width * 0.6283465,
          size.height * 0.8094595,
          size.width * 0.6110236,
          size.height * 0.8070946,
          size.width * 0.5976378,
          size.height * 0.8104730);
      path_25.lineTo(size.width * 0.5787402, size.height * 0.8152027);
      path_25.close();

      Paint paint_25_fill = Paint()..style = PaintingStyle.fill;
      paint_25_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_25, paint_25_fill);

      Path path_26 = Path();
      path_26.moveTo(size.width * 0.5511811, size.height * 0.8202703);
      path_26.lineTo(size.width * 0.5464567, size.height * 0.8162162);
      path_26.cubicTo(
          size.width * 0.5385827,
          size.height * 0.8097973,
          size.width * 0.5433071,
          size.height * 0.8013514,
          size.width * 0.5566929,
          size.height * 0.7976351);
      path_26.lineTo(size.width * 0.5700787, size.height * 0.7939189);
      path_26.cubicTo(
          size.width * 0.5732283,
          size.height * 0.7932432,
          size.width * 0.5763780,
          size.height * 0.7935811,
          size.width * 0.5779528,
          size.height * 0.7949324);
      path_26.lineTo(size.width * 0.5795276, size.height * 0.7962838);
      path_26.cubicTo(
          size.width * 0.5874016,
          size.height * 0.8027027,
          size.width * 0.5826772,
          size.height * 0.8111486,
          size.width * 0.5692913,
          size.height * 0.8148649);
      path_26.lineTo(size.width * 0.5511811, size.height * 0.8202703);
      path_26.close();

      Paint paint_26_fill = Paint()..style = PaintingStyle.fill;
      paint_26_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_26, paint_26_fill);

      Path path_27 = Path();
      path_27.moveTo(size.width * 0.4944882, size.height * 0.8277027);
      path_27.cubicTo(
          size.width * 0.3858268,
          size.height * 0.8277027,
          size.width * 0.2976378,
          size.height * 0.7854730,
          size.width * 0.2976378,
          size.height * 0.7334459);
      path_27.cubicTo(
          size.width * 0.2976378,
          size.height * 0.7138514,
          size.width * 0.3102362,
          size.height * 0.6952703,
          size.width * 0.3330709,
          size.height * 0.6793919);
      path_27.cubicTo(
          size.width * 0.3559055,
          size.height * 0.6638514,
          size.width * 0.3874024,
          size.height * 0.6520270,
          size.width * 0.4244102,
          size.height * 0.6452703);
      path_27.cubicTo(
          size.width * 0.4283472,
          size.height * 0.6445946,
          size.width * 0.4322835,
          size.height * 0.6456081,
          size.width * 0.4330709,
          size.height * 0.6472973);
      path_27.cubicTo(
          size.width * 0.4346465,
          size.height * 0.6489865,
          size.width * 0.4322835,
          size.height * 0.6510135,
          size.width * 0.4291339,
          size.height * 0.6516892);
      path_27.cubicTo(
          size.width * 0.3944882,
          size.height * 0.6581081,
          size.width * 0.3653551,
          size.height * 0.6689189,
          size.width * 0.3440953,
          size.height * 0.6834459);
      path_27.cubicTo(
          size.width * 0.3228354,
          size.height * 0.6983108,
          size.width * 0.3110236,
          size.height * 0.7155405,
          size.width * 0.3110236,
          size.height * 0.7337838);
      path_27.cubicTo(
          size.width * 0.3110236,
          size.height * 0.7820946,
          size.width * 0.3929142,
          size.height * 0.8212838,
          size.width * 0.4937016,
          size.height * 0.8212838);
      path_27.cubicTo(
          size.width * 0.5944882,
          size.height * 0.8212838,
          size.width * 0.6763787,
          size.height * 0.7820946,
          size.width * 0.6763787,
          size.height * 0.7337838);
      path_27.cubicTo(
          size.width * 0.6763787,
          size.height * 0.7155405,
          size.width * 0.6645669,
          size.height * 0.6983108,
          size.width * 0.6433071,
          size.height * 0.6834459);
      path_27.cubicTo(
          size.width * 0.6220472,
          size.height * 0.6689189,
          size.width * 0.5929142,
          size.height * 0.6581081,
          size.width * 0.5582685,
          size.height * 0.6516892);
      path_27.cubicTo(
          size.width * 0.5543315,
          size.height * 0.6510135,
          size.width * 0.5527567,
          size.height * 0.6489865,
          size.width * 0.5543315,
          size.height * 0.6472973);
      path_27.cubicTo(
          size.width * 0.5559063,
          size.height * 0.6456081,
          size.width * 0.5598425,
          size.height * 0.6445946,
          size.width * 0.5629921,
          size.height * 0.6452703);
      path_27.cubicTo(
          size.width * 0.6000008,
          size.height * 0.6520270,
          size.width * 0.6314961,
          size.height * 0.6638514,
          size.width * 0.6543307,
          size.height * 0.6793919);
      path_27.cubicTo(
          size.width * 0.6779528,
          size.height * 0.6952703,
          size.width * 0.6897638,
          size.height * 0.7138514,
          size.width * 0.6897638,
          size.height * 0.7334459);
      path_27.cubicTo(
          size.width * 0.6913386,
          size.height * 0.7854730,
          size.width * 0.6031496,
          size.height * 0.8277027,
          size.width * 0.4944882,
          size.height * 0.8277027);
      path_27.close();

      Paint paint_27_fill = Paint()..style = PaintingStyle.fill;
      paint_27_fill.color = Color(0xffFFD064).withOpacity(1.0);
      canvas.drawPath(path_27, paint_27_fill);

      Path path_28 = Path();
      path_28.moveTo(size.width * 0.4944874, size.height * 0.6719595);
      path_28.cubicTo(
          size.width * 0.4842512,
          size.height * 0.6837838,
          size.width * 0.4732283,
          size.height * 0.6942568,
          size.width * 0.4228346,
          size.height * 0.6942568);
      path_28.lineTo(size.width * 0.4228346, size.height * 0.7138514);
      path_28.lineTo(size.width * 0.4732276, size.height * 0.7138514);
      path_28.lineTo(size.width * 0.4732276, size.height * 0.8489865);
      path_28.lineTo(size.width * 0.5377953, size.height * 0.8489865);
      path_28.lineTo(size.width * 0.5377953, size.height * 0.6719595);
      path_28.lineTo(size.width * 0.4944874, size.height * 0.6719595);
      path_28.close();

      Paint paint_28_fill = Paint()..style = PaintingStyle.fill;
      paint_28_fill.color = Color(0xff91794C).withOpacity(1.0);
      canvas.drawPath(path_28, paint_28_fill);

      Path path_29 = Path();
      path_29.moveTo(size.width * 0.4944874, size.height * 0.6719595);
      path_29.cubicTo(
          size.width * 0.4842512,
          size.height * 0.6837838,
          size.width * 0.4732283,
          size.height * 0.6942568,
          size.width * 0.4228346,
          size.height * 0.6942568);
      path_29.lineTo(size.width * 0.4228346, size.height * 0.7138514);
      path_29.lineTo(size.width * 0.4732276, size.height * 0.7138514);
      path_29.lineTo(size.width * 0.4732276, size.height * 0.8489865);
      path_29.lineTo(size.width * 0.5291331, size.height * 0.8489865);
      path_29.lineTo(size.width * 0.5291331, size.height * 0.6719595);
      path_29.lineTo(size.width * 0.4944874, size.height * 0.6719595);
      path_29.close();

      Paint paint_29_fill = Paint()..style = PaintingStyle.fill;
      paint_29_fill.color = Color(0xffFFE07D).withOpacity(1.0);
      canvas.drawPath(path_29, paint_29_fill);

      Path path_30 = Path();
      path_30.moveTo(size.width * 0.4740157, size.height * 0.7138514);
      path_30.lineTo(size.width * 0.4653543, size.height * 0.7138514);
      path_30.lineTo(size.width * 0.4653543, size.height * 0.8489865);
      path_30.lineTo(size.width * 0.4740157, size.height * 0.8489865);
      path_30.lineTo(size.width * 0.4740157, size.height * 0.7138514);
      path_30.close();

      Paint paint_30_fill = Paint()..style = PaintingStyle.fill;
      paint_30_fill.color = Color(0xffFFD064).withOpacity(1.0);
      canvas.drawPath(path_30, paint_30_fill);

      Path path_31 = Path();
      path_31.moveTo(size.width * 0.4944882, size.height * 0.6719595);
      path_31.cubicTo(
          size.width * 0.4842520,
          size.height * 0.6837838,
          size.width * 0.4732283,
          size.height * 0.6942568,
          size.width * 0.4228346,
          size.height * 0.6942568);
      path_31.lineTo(size.width * 0.4228346, size.height * 0.7138514);
      path_31.lineTo(size.width * 0.4141732, size.height * 0.7138514);
      path_31.lineTo(size.width * 0.4141732, size.height * 0.6942568);
      path_31.cubicTo(
          size.width * 0.4645669,
          size.height * 0.6942568,
          size.width * 0.4755906,
          size.height * 0.6837838,
          size.width * 0.4858268,
          size.height * 0.6719595);
      path_31.lineTo(size.width * 0.4944882, size.height * 0.6719595);
      path_31.close();

      Paint paint_31_fill = Paint()..style = PaintingStyle.fill;
      paint_31_fill.color = Color(0xffFFD064).withOpacity(1.0);
      canvas.drawPath(path_31, paint_31_fill);
    }

    Path path_17 = Path();
    path_17.moveTo(size.width * 0.2834646, 0);
    path_17.lineTo(size.width * 0.2834646, size.height * 0.4445946);
    path_17.lineTo(size.width * 0.2755906, size.height * 0.4425676);
    path_17.lineTo(size.width * 0.01102378, size.height * 0.3793919);
    path_17.lineTo(size.width * 0.01102378, 0);
    path_17.lineTo(size.width * 0.2834646, 0);
    path_17.close();

    Paint paint_17_fill = Paint()..style = PaintingStyle.fill;
    paint_17_fill.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [ribbonStart.withOpacity(1.0), ribbonEnd.withOpacity(1.0)],
    ).createShader(rect);
    canvas.drawPath(path_17, paint_17_fill);

    Path path_18 = Path();
    path_18.moveTo(size.width * 0.9858268, 0);
    path_18.lineTo(size.width * 0.9858268, size.height * 0.3793919);
    path_18.lineTo(size.width * 0.7220472, size.height * 0.4425676);
    path_18.lineTo(size.width * 0.7141732, size.height * 0.4445946);
    path_18.lineTo(size.width * 0.7141732, 0);
    path_18.lineTo(size.width * 0.9858268, 0);
    path_18.close();

    Paint paint_18_fill = Paint()..style = PaintingStyle.fill;
    paint_18_fill.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [ribbonStart.withOpacity(1.0), ribbonEnd.withOpacity(1.0)],
    ).createShader(rect);
    canvas.drawPath(path_18, paint_18_fill);

    Path path_19 = Path();
    path_19.moveTo(size.width * 0.7141732, 0);
    path_19.lineTo(size.width * 0.7141732, size.height * 0.4709459);
    path_19.lineTo(size.width * 0.4984252, size.height * 0.5226351);
    path_19.lineTo(size.width * 0.2834646, size.height * 0.4709459);
    path_19.lineTo(size.width * 0.2834646, 0);
    path_19.lineTo(size.width * 0.7141732, 0);
    path_19.close();

    Paint paint_19_fill = Paint()..style = PaintingStyle.fill;
    paint_19_fill.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [ribbonStart.withOpacity(1.0), ribbonEnd.withOpacity(1.0)],
    ).createShader(rect);
    canvas.drawPath(path_19, paint_19_fill);

    Path path_20 = Path();
    path_20.moveTo(size.width * 0.7141732, 0);
    path_20.lineTo(size.width * 0.7141732, size.height * 0.4709459);
    path_20.lineTo(size.width * 0.4984252, size.height * 0.5226351);
    path_20.lineTo(size.width * 0.2834646, size.height * 0.4709459);
    path_20.lineTo(size.width * 0.2834646, 0);
    path_20.lineTo(size.width * 0.7141732, 0);
    path_20.close();

    Paint paint_20_fill = Paint()..style = PaintingStyle.fill;
    paint_20_fill.color = ribbonColor.withOpacity(0.5);
    canvas.drawPath(path_20, paint_20_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
