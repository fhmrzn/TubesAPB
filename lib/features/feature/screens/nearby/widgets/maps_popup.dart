import 'package:flutter/material.dart';

class MarkerPopup extends StatelessWidget {
  const MarkerPopup(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: const Center(
        child: Text(
          'This is a popup for the marker.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
