import 'package:flutter/material.dart';

class PhotoFrameView extends StatelessWidget {
  final Widget child;
  const PhotoFrameView({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      alignment: Alignment.center,
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey,width: 1.5),
      ),
      child: child,

    );
  }
}
