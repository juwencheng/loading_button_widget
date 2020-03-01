import 'package:flutter/material.dart';

class InternalFilledLoadingButtonWidget extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> _width;
  final Animation<double> _opacity;
  final Animation<double> _loadingOpacity;
  final Animation<Color> _backgroundColor;
  final Animation<Color> _circularColor;
  final Color backgroundColor;
  final Widget child;

  final double maxWidth;
  final double minWidth;

  InternalFilledLoadingButtonWidget(
      {Key key,
      @required this.controller,
      @required this.child,
      this.backgroundColor = Colors.blue,
      @required this.maxWidth,
      @required this.minWidth})
      : _width = Tween<double>(begin: maxWidth, end: minWidth)
            .animate(CurvedAnimation(
          curve: Interval(0, 0.9, curve: Curves.easeInOutBack),
          parent: controller,
        )),
        _opacity = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.2, 0.7, curve: Curves.ease),
        )),
        _loadingOpacity =
            Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.7, 1.0, curve: Curves.ease),
        )),
        _backgroundColor = ColorTween(begin: backgroundColor, end: Colors.white)
            .animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.7, 1.0, curve: Curves.linearToEaseOut),
        )),
        _circularColor = ColorTween(
                begin: backgroundColor.withOpacity(0.8), end: backgroundColor)
            .animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.8, 1.0, curve: Curves.linearToEaseOut),
        )),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        child: child,
        builder: (context, child) {
          return Container(
            width: _width.value,
            height: minWidth,
            child: Stack(
              children: <Widget>[
                Opacity(opacity: _opacity.value, child: child),
                Opacity(
                  opacity: _loadingOpacity.value,
                  child: SizedBox(
                      width: minWidth,
                      height: minWidth,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: _circularColor,
                      )),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: _backgroundColor.value,
                borderRadius: BorderRadius.circular(minWidth / 2.0),
                boxShadow: [
                  BoxShadow(blurRadius: 16, color: Colors.black12),
                ]),
          );
        });
  }
}
