import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FontSample(),
    );
  }
}

class FontSample extends StatelessWidget {
  const FontSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Text(
            'Fontの違いを確かめる',
            style: TextStyle(fontSize: 32),
          ),
          Text(
            'Fontの違いを確かめる',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(fontSize: 32)
            ),
          ),
          Text(
            'Fontの違いを確かめる',
            style: GoogleFonts.pottaOne(
              textStyle: const TextStyle(fontSize: 32)
            ),
          ),
          Text(
            'Fontの違いを確かめる',
            style: GoogleFonts.notoSansBhaiksuki(
              textStyle: const TextStyle(fontSize: 32)
            ),
          ),
        ],
      )
    );
  }
}