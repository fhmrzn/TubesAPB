import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';


class TPrimaryHeader extends StatelessWidget {
  const TPrimaryHeader({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TColors.white,
      padding: const EdgeInsets.only(bottom: 16), // Add padding if needed
      child: Column(
        children: [
          child,
          const SizedBox(
            height: 10, // Adjust height as necessary
            child: Stack(
            ),
          ),
        ],
      ),
    );
  }
}
