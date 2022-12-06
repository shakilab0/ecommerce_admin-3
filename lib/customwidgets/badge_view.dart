import 'package:flutter/material.dart';

class BadgeView extends StatelessWidget {
  final int count;
  const BadgeView({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        child: Text('$count', style: const TextStyle(fontSize: 18, color: Colors.white,),
        ),
      ),
    );
  }
}
