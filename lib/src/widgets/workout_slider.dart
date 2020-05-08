import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:vector_math/vector_math.dart' as v_math;
import 'package:ludisy/src/util/ui_utils.dart';

class WorkoutSlider extends StatefulWidget {
  final Function(int) onChanged;
  final List<String> vales;
  final String metric;

  WorkoutSlider(this.onChanged, this.vales, {this.metric = ""});

  @override
  _WorkoutSliderState createState() =>
      _WorkoutSliderState(onChanged, vales, metric);
}

class _WorkoutSliderState extends State<WorkoutSlider>
    with SingleTickerProviderStateMixin {
  double intitalReviewValue = 2;

  Animation<double> _animation;
  AnimationController _controller;
  Tween<double> _tween;
  double _innerWidth;
  double _animationValue;
  final Function(int) onChanged;
  final List<String> vales;
  final String metric;

  _WorkoutSliderState(this.onChanged, this.vales, this.metric);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      value: intitalReviewValue,
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _tween = Tween(end: intitalReviewValue);
    _animation = _tween.animate(
      CurvedAnimation(
        curve: Curves.easeIn,
        parent: _controller,
      ),
    )..addListener(() {
        setState(() {
          _animationValue = _animation.value;
        });
      });
    _animationValue = intitalReviewValue;
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  _afterLayout(_) {
    setState(() {
      _innerWidth = MediaQuery.of(context).size.width - 90;
    });
  }

  void handleTap(int state) {
    _controller.duration = Duration(milliseconds: 400);

    _tween.begin = _tween.end;
    _tween.end = state.toDouble();
    _controller.reset();
    _controller.forward();
  }

  _onDrag(details) {
    var newAnimatedValue = _calcAnimatedValueFormDragX(
      details.globalPosition.dx,
    );
    if (newAnimatedValue > 0 && newAnimatedValue < vales.length - 1) {
      setState(
        () {
          _animationValue = newAnimatedValue;
        },
      );
    }
  }

  _calcAnimatedValueFormDragX(x) {
    return (x - circleDiameter) / _innerWidth * vales.length;
  }

  _onDragEnd(_) {
    _controller.duration = Duration(milliseconds: 100);
    _tween.begin = _animationValue;
    _tween.end = _animationValue.round().toDouble();
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var value = _animationValue.round();
    onChanged(value);
    return Center(
      child: _innerWidth == null
          ? Container()
          : Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                height: 60,
                width: _innerWidth,
                child: Stack(children: <Widget>[
                  MeasureLine(
                    states: vales,
                    handleTap: handleTap,
                    animationValue: _animationValue,
                    width: _innerWidth,
                    metric: metric,
                  ),
                  MyIndicator(
                    vales[value],
                    animationValue: _animationValue,
                    width: _innerWidth,
                    onDrag: _onDrag,
                    onDragEnd: _onDragEnd,
                    metric: metric,
                  ),
                ]),
              )),
    );
  }
}

const double circleDiameter = 56;
const double paddingSize = 0;

class MeasureLine extends StatelessWidget {
  MeasureLine(
      {this.handleTap,
      this.animationValue,
      this.states,
      this.width,
      this.metric});

  final double animationValue;
  final Function handleTap;
  final List<String> states;
  final double width;
  final String metric;

  List<Widget> _buildUnits() {
    var res = <Widget>[];
    var animatingUnitIndex = animationValue.round();
    var unitAnimatingValue = (animationValue * 10 % 10 / 10 - 0.5).abs() * 2;

    states.asMap().forEach((index, text) {
      var scale = 1.0;
      if (animatingUnitIndex == index) {
        scale = (1 - unitAnimatingValue / 4);
      }
      res.add(LimitedBox(
        key: ValueKey(text),
        maxWidth: circleDiameter,
        child: GestureDetector(
          onTap: () {
            handleTap(index);
          },
          child: Transform.scale(
            scale: scale,
            child: Stack(
              children: [
                Head(
                  Colors.transparent,
                  text: text,
                  metric: metric,
                ),
              ],
            ),
          ),
        ),
      ));
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          width: width,
          child: Container(
            width: width,
            height: 56,
            decoration: BoxDecoration(
                boxShadow: [AppContainerBoxShadow()],
                color: AppColors.instance.containerColor,
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildUnits(),
            )),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter(animationValue, this.color)
      : activeIndex = animationValue.floor(),
        unitAnimatingValue = (animationValue * 10 % 10 / 10);

  final Color color;
  final int activeIndex;
  final double unitAnimatingValue;

  @override
  void paint(Canvas canvas, Size size) {
    _drawEye(canvas, size);
    _drawMouth(canvas, size);
  }

  _drawEye(canvas, size) {
    var angle = 0.0;
    var wide = 0.0;

    switch (activeIndex) {
      case 0:
        angle = 55 - unitAnimatingValue * 56;
        wide = 80.0;
        break;
      case 1:
        wide = 80 - unitAnimatingValue * 80;
        angle = 5;
        break;
    }
    var degree1 = 90 * 3 + angle;
    var degree2 = 90 * 3 - angle + wide;
    var x1 = size.width / 2 * 0.65;
    var x2 = size.width - x1;
    var y = size.height * 0.41;
    var eyeRadius = 5.0;

    var paint = Paint()..color = color;
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(x1, y),
        radius: eyeRadius,
      ),
      v_math.radians(degree1),
      v_math.radians(360 - wide),
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(x2, y),
        radius: eyeRadius,
      ),
      v_math.radians(degree2),
      v_math.radians(360 - wide),
      false,
      paint,
    );
  }

  _drawMouth(Canvas canvas, size) {
    var upperY = size.height * 0.70;
    var lowerY = size.height * 0.77;
    var middleY = (lowerY - upperY) / 2 + upperY;

    var leftX = size.width / 2 * 0.65;
    var rightX = size.width - leftX;
    var middleX = size.width / 2;

    double y1, y3, x2, y2;
    Path path2;
    switch (activeIndex) {
      case 0:
        y1 = lowerY;
        x2 = middleX;
        y2 = upperY;
        y3 = lowerY;
        break;
      case 1:
        y1 = lowerY;
        x2 = middleX;
        y2 = unitAnimatingValue * (middleY - upperY) + upperY;
        y3 = lowerY - unitAnimatingValue * (lowerY - upperY);
        break;
      case 2:
        y1 = unitAnimatingValue * (upperY - lowerY) + lowerY;
        x2 = middleX;
        y2 = unitAnimatingValue * (lowerY + 3 - middleY) + middleY;
        y3 = upperY;
        break;
      case 3:
        y1 = upperY;
        x2 = middleX;
        y2 = lowerY + 3;
        y3 = upperY;
        path2 = Path()
          ..moveTo(leftX, y1)
          ..quadraticBezierTo(
            x2,
            y2,
            upperY - 2.5,
            y3 - 2.5,
          )
          ..quadraticBezierTo(
            x2,
            y2 - unitAnimatingValue * (y2 - upperY + 2.5),
            leftX,
            upperY - 2.5,
          )
          ..close();
        break;
      case 4:
        y1 = upperY;
        x2 = middleX;
        y2 = lowerY + 3;
        y3 = upperY;
        path2 = Path()
          ..moveTo(leftX, y1)
          ..quadraticBezierTo(
            x2,
            y2,
            upperY - 2.5,
            y3 - 2.5,
          )
          ..quadraticBezierTo(
            x2,
            upperY - 2.5,
            leftX,
            upperY - 2.5,
          )
          ..close();
        break;
    }
    var path = Path()
      ..moveTo(leftX, y1)
      ..quadraticBezierTo(
        x2,
        y2,
        rightX,
        y3,
      );

    canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 5);

    if (path2 != null) {
      canvas.drawPath(
        path2,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return unitAnimatingValue != oldDelegate.unitAnimatingValue ||
        activeIndex != oldDelegate.activeIndex;
  }
}

class MyIndicator extends StatelessWidget {
  MyIndicator(
    this.title, {
    this.animationValue,
    width,
    this.onDrag,
    this.onDragStart,
    this.onDragEnd,
    this.metric,
  })  : width = width - circleDiameter,
        possition = animationValue == 0 ? 0 : animationValue / 4;

  final String title;
  final double possition;
  final Function onDrag;
  final Function onDragStart;
  final Function onDragEnd;
  final double width;
  final double animationValue;
  final String metric;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
        top: 0,
        left: width * possition,
        child: _buildIndicator(),
      ),
    );
  }

  _buildIndicator() {
    return GestureDetector(
      onPanDown: onDragStart,
      onPanUpdate: onDrag,
      onPanStart: onDrag,
      onPanEnd: onDragEnd,
      child: Container(
        width: circleDiameter,
        height: circleDiameter,
        child: Transform.scale(
            scale: 1.3,
            child: Head(
              AppColors.instance.blue,
              text: title,
              selected: true,
              metric: metric,
            )),
      ),
    );
  }
}

class Head extends StatelessWidget {
  Head(this.color, {this.text = "", this.selected = false, this.metric});

  final String text;
  final Color color;
  final bool selected;
  final String metric;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          color: color,
          borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color:
                  selected ? Colors.black.withOpacity(0.4) : Colors.transparent,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 0),
            )
          ]),
      height: circleDiameter,
      width: circleDiameter - 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(text,
              style: GoogleFonts.montserrat(
                  fontSize: selected ? 11.2 : 12.0,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w600,
                  color: selected ? AppColors.instance.containerColor : Colors.black)),
          Text(metric,
              style: GoogleFonts.montserrat(
                  fontSize: selected ? 11.2 : 12.0,
                  fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
                  color: selected ? AppColors.instance.containerColor : Colors.black))
        ],
      ),
    );
  }
}
