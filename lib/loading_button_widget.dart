library loading_button_widget;

import 'package:flutter/material.dart';
import 'internal_filed_loading_button_widget.dart';

class LoadingButtonWidget extends StatefulWidget {
  final Color color;
  final String title;
  final TextStyle titleStyle;
  final double height;
  final VoidCallback onTap;

  const LoadingButtonWidget(
      {Key key,
      @required this.onTap,
      this.title,
      this.color,
      this.height = 56,
      this.titleStyle})
      : super(key: key);
  @override
  _LoadingButtonWidgetState createState() => _LoadingButtonWidgetState();
}

class _LoadingButtonWidgetState extends State<LoadingButtonWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  bool _processing = false;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () async {
            if (_processing) {
              return;
            }
            _processing = true;
            await _animationController.forward();
            await Future.wait(
              [
                // 立即调用returns a future containing the result of immediately calling [computation]
                // 测试了
                Future.sync(widget.onTap),
                // 最小间隔时间
                Future.delayed(Duration(seconds: 1)),
              ],
            );
            await _animationController.reverse();
            _processing = false;
          },
          child: InternalFilledLoadingButtonWidget(
            backgroundColor: widget.color,
            child: Center(
              child: Text(
                "${widget.title}",
                style: TextStyle(color: Colors.white),
              ),
            ),
            controller: _animationController,
            maxWidth: constraints.maxWidth,
            minWidth: widget.height,
          ),
        );
      },
    );
  }
}
