import 'package:flutter/material.dart';

Column faqOptions(IconData icon, String text) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          children: [
            Container(
              color: const Color(0xff510D84),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: Color(0xffAC4AF2),
                  size: 30,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff1F0A2F),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  softWrap: true,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 32),
    ],
  );
}
