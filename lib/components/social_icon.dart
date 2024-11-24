import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

socialIcon(Color color, String imagePath, String url, BuildContext context) {
  return GestureDetector(
    onTap: () async {
      try {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              // content: Text("Error fetching data: $e"),
              content: Text('Could not launch ${url}'),
              backgroundColor: const Color(0xff510D84),
              duration: const Duration(seconds: 3),
            ),
          );

          Navigator.of(context).pop();
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error launchin URL: ${e}'),
            backgroundColor: const Color(0xff510D84),
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.of(context).pop();
      }
    },
    child: Container(
      width: 50,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          // color: const Color(0xff25D366),
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Image(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
      ),
    ),
  );
}
