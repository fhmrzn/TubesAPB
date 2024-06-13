import 'package:flutter/material.dart';

class TSearchHeader extends StatelessWidget {
  TSearchHeader({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          // Perform search functionality here
        },
      ),
    );
  }
}
