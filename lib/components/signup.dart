import 'package:flutter/material.dart';
import 'package:phenom2025/components/socials.dart';
import 'package:phenom2025/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

Future<dynamic> signUp(BuildContext context) {
  final homeProvider = Provider.of<UserProvider>(context, listen: false);

  return showDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(0.1),
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.black,
          content: SingleChildScrollView(
            child: FutureBuilder(
              future: homeProvider.getSignupPopup(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No data found'));
                } else {
                  return Column(
                    children: [
                      // HEADER ////////////////////////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data['title'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: const Color(0xff191919),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        snapshot.data['prefix_message'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            final Uri uri = Uri.parse(
                                snapshot.data['button_link'].toString());
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              // debugPrint('Could not launch $url');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Could not launch ${snapshot.data['button_link']}'),
                                  backgroundColor: const Color(0xff510D84),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                          } catch (e) {
                            // debugPrint('Error launching URL: $e');
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
                        label: Text(
                          snapshot.data['button_text'].toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                        icon: const Icon(
                          Icons.double_arrow,
                          color: Colors.black,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        snapshot.data['suffix_message'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: const Color(0xff191919),
                      ),
                      const SizedBox(height: 32),
                      const Socials(),
                    ],
                  );
                }
              },
            ),
          ),
          actions: const [],
        );
      });
}
