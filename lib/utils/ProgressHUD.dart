import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;

  ProgressHUD({Key key,
    @required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.valueColor,
    @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = new List<Widget>();
    widgetList.add(child);
    if (inAsyncCall) {
      final model = new Stack(
        children: [
          new Opacity(opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color,),),
          new Center(
            child: new CircularProgressIndicator(),
          )
        ],
      );
      widgetList.add(model);
    }
    return Stack(
      children:
      widgetList,

    );
  }
}
