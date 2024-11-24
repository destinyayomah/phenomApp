import 'package:flutter/material.dart';
import 'package:phenom2025/components/social_icon.dart';
import 'package:phenom2025/provider/provider.dart';
import 'package:provider/provider.dart';

class Socials extends StatelessWidget {
  const Socials({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<UserProvider>(context, listen: false);
    return FutureBuilder(
        future: homeProvider.getSocialLinks(),
        builder: ((context, snapshot) {
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
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialIcon(
                  const Color(0xff25D366),
                  'assets/images/whatsapp.png',
                  snapshot.data['whatsapp'].toString(),
                  context,
                ),
                const SizedBox(width: 20),
                socialIcon(
                  const Color(0xff1DA1F2),
                  'assets/images/telegram.png',
                  snapshot.data['telegram'].toString(),
                  context,
                ),
                const SizedBox(width: 20),
                socialIcon(
                  const Color(0xffffffff),
                  'assets/images/tiktok.png',
                  snapshot.data['tiktok'].toString(),
                  context,
                ),
                const SizedBox(width: 20),
                socialIcon(
                  const Color(0xff0E662F),
                  'assets/images/team.png',
                  snapshot.data['channel'].toString(),
                  context,
                ),
              ],
            );
          }
        }));
  }
}
