import 'package:flutter/material.dart';
import 'package:phenom2025/components/socials.dart';
import 'package:phenom2025/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

Future<dynamic> howItWorks(BuildContext context) {
  final homeProvider = Provider.of<UserProvider>(context, listen: false);

  return showDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(0.1),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: SingleChildScrollView(
            child: FutureBuilder(
              future: homeProvider.getHowItWorksPopup(),
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
                            textAlign: TextAlign.start,
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
                        snapshot.data['caption'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 32),
                      const Image(
                        image: AssetImage('assets/images/how-it-works.png'),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        snapshot.data['content']
                            .toString()
                            .replaceAll(r'\n', '\n'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        softWrap: true,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data['button_text'].toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const Icon(
                              Icons.double_arrow,
                              color: Colors.black,
                              size: 14,
                            ),
                          ],
                        ),
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
        );
      });
}
