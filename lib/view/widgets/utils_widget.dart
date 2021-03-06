import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

/// Provides a unified Padding to parameterize it.
class NormalizedPadding extends StatelessWidget {
  late final Widget child;
  final double offset = 10;

  NormalizedPadding({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(this.offset), child: child);
  }
}

/// Provides a ToolTip Widget
class ToolTip extends StatelessWidget {

  late final Widget child;
  late final String text;
  late final Widget? content;
  late final TooltipDirection direction;
  late final double offset;
  late final double fontSize;
  late final Function? onTap;

  final bool show;

  ToolTip({required this.child, this.text = "", this.content, this.show = true, this.direction = TooltipDirection.up, this.offset = 0.0, this.fontSize = 20, this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return SimpleTooltip(
      tooltipTap: () {
        if(onTap !=null){
          onTap!();
        }
      },
      child: child,
      borderColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.white,
      content: content ?? Text(text, style: TextStyle(fontSize: fontSize, color: Colors.black87, decoration: TextDecoration.none),),
      show: show,
      tooltipDirection: direction,
      arrowTipDistance: offset,
    );
  }
}
