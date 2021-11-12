import 'package:flutter/cupertino.dart';

class NormalizedPadding extends StatelessWidget {
  late final Widget child;
  final double offset = 10;

  NormalizedPadding({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(this.offset), child: child);
  }
}
