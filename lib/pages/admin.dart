import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phenom2025/provider/provider.dart';
import 'package:provider/provider.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  bool isLoading = true;

  final _whatsapp = TextEditingController();
  final _telegram = TextEditingController();
  final _tiktok = TextEditingController();
  final _channel = TextEditingController();

  final _sup_title = TextEditingController();
  final _sup_prefix = TextEditingController();
  final _sup_suffix = TextEditingController();
  final _sup_btn_text = TextEditingController();
  final _sup_btn_link = TextEditingController();

  final _hwk_title = TextEditingController();
  final _hwk_caption = TextEditingController();
  final _hwk_content = TextEditingController();
  final _hwk_button_text = TextEditingController();
  final _hwk_button_link = TextEditingController();

  final _wp_content = TextEditingController();
  final _wp_button_text = TextEditingController();

  final _w_content = TextEditingController();
  final _w_button_text = TextEditingController();

  final CollectionReference firestoreCollection =
      FirebaseFirestore.instance.collection('phenom2025');

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    try {
      final homeProvider = Provider.of<UserProvider>(context, listen: false);
      var socialLinks = await homeProvider.getSocialLinks();
      var signupPopup = await homeProvider.getSignupPopup();
      var howItWorks = await homeProvider.getHowItWorksPopup();
      var whatIsPhenom = await homeProvider.getWhatIsPhenom();
      var waitlist = await homeProvider.getWaitlist();

      setState(() {
        _whatsapp.text = socialLinks['whatsapp'].toString().trim();
        _telegram.text = socialLinks['telegram'].toString().trim();
        _tiktok.text = socialLinks['tiktok'].toString().trim();
        _channel.text = socialLinks['channel'].toString().trim();

        _sup_title.text = signupPopup['title'].toString().trim();
        _sup_prefix.text = signupPopup['prefix_message'].toString().trim();
        _sup_suffix.text = signupPopup['suffix_message'].toString().trim();
        _sup_btn_text.text = signupPopup['button_text'].toString().trim();
        _sup_btn_link.text = signupPopup['button_link'].toString().trim();

        _hwk_title.text = howItWorks['title'].toString().trim();
        _hwk_caption.text = howItWorks['caption'].toString().trim();
        _hwk_content.text =
            howItWorks['content'].toString().trim().replaceAll(r'\n', '\n');
        _hwk_button_text.text = howItWorks['button_text'].toString().trim();
        _hwk_button_link.text = howItWorks['button_link'].toString().trim();
        // hw_image = howItWorks['image'].toString();

        _wp_content.text =
            whatIsPhenom['content'].toString().trim().replaceAll(r'\n', '\n');
        _wp_button_text.text = whatIsPhenom['button_text'].toString().trim();

        _w_content.text =
            waitlist['content'].toString().trim().replaceAll(r'\n', '\n');
        _w_button_text.text =
            _w_button_text.text = waitlist['button_text'].toString().trim();

        isLoading = false;
      });
    } catch (e) {
      showSnackError('Error updating text: $e');
    }
  }

  Future<void> saveData() async {
    try {
      Map<String, dynamic> updatedSocialLinks = {};
      Map<String, dynamic> updateSignupPopup = {};
      Map<String, dynamic> updateHowItWorks = {};
      Map<String, dynamic> updateWhatIsPhenom = {};
      Map<String, dynamic> updateWaitlist = {};

      updatedSocialLinks['whatsapp'] = _whatsapp.text;
      updatedSocialLinks['telegram'] = _telegram.text;
      updatedSocialLinks['tiktok'] = _tiktok.text;
      updatedSocialLinks['channel'] = _channel.text;

      updateSignupPopup['title'] = _sup_title.text;
      updateSignupPopup['prefix_message'] = _sup_prefix.text;
      updateSignupPopup['suffix_message'] = _sup_suffix.text;
      updateSignupPopup['button_text'] = _sup_btn_text.text;
      updateSignupPopup['button_link'] = _sup_btn_link.text;

      updateHowItWorks['title'] = _hwk_title.text;
      updateHowItWorks['caption'] = _hwk_caption.text;
      updateHowItWorks['content'] = _hwk_content.text;
      updateHowItWorks['button_text'] = _hwk_button_text.text;
      updateHowItWorks['button_link'] = _hwk_button_link.text;

      updateWhatIsPhenom['content'] = _wp_content.text;
      updateWhatIsPhenom['button_text'] = _wp_button_text.text;

      updateWaitlist['content'] = _w_content.text;
      updateWaitlist['button_text'] = _w_button_text.text;

      // UPDATE
      await firestoreCollection.doc('social_links').update(updatedSocialLinks);
      await firestoreCollection.doc('signup_popup').update(updateSignupPopup);
      await firestoreCollection
          .doc('how_it_works_popup')
          .update(updateHowItWorks);
      await firestoreCollection
          .doc('what_is_phenom')
          .update(updateWhatIsPhenom);
      await firestoreCollection.doc('waitlist').update(updateWaitlist);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saved'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      showSnackError(e);
    }
  }

  showSnackError(e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
        backgroundColor: const Color(0xff510D84),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff25073D),
              Color(0xff000000),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const Text(
                        'Admin Panel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                const SizedBox(height: 32),
                // SOCIAL LINKS ////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Social Links',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Whatsapp',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _whatsapp,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Whatsapp',
                          prefixIcon: const Icon(
                            Icons.whatshot_sharp,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Telegram',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _telegram,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Telegram',
                          prefixIcon: const Icon(
                            Icons.telegram,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Tiktok',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _tiktok,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Tiktok',
                          prefixIcon: const Icon(
                            Icons.tiktok,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Channel',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _channel,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Channel',
                          prefixIcon: const Icon(
                            Icons.people,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Signup popup ////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Signup Popup',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Title',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _sup_title,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Title',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Prefix message',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _sup_prefix,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Prefix message',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Suffix message',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _sup_suffix,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Suffix mesage',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Button text',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _sup_btn_text,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Button text',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Button link',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _sup_btn_link,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Button link',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // HOW IT WORKS POPUP //////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'How  it works Popup',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Title',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _hwk_title,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Title',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Caption',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _hwk_caption,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Caption',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Content',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _hwk_content,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Content',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        maxLines: 10,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Button text',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _hwk_button_text,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Button text',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Button link',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _hwk_button_link,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Button link',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // HERO IMAGE //////////////////////////////////////////////////
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         'Hero Image',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 16,
                //           fontWeight: FontWeight.w900,
                //         ),
                //         textAlign: TextAlign.start,
                //       ),
                //       const SizedBox(height: 16),
                //       const Text(
                //         'Image',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //       const SizedBox(height: 5),
                //       SizedBox(
                //         width: double.infinity,
                //         child: ElevatedButton.icon(
                //           onPressed: () {},
                //           style: ElevatedButton.styleFrom(
                //             alignment: Alignment.topLeft,
                //             backgroundColor: Colors.transparent,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             side: const BorderSide(color: Colors.white),
                //             padding: const EdgeInsets.symmetric(
                //               horizontal: 32,
                //               vertical: 16,
                //             ),
                //           ),
                //           icon: const Icon(
                //             Icons.cloud_upload_outlined,
                //             color: Colors.white,
                //           ),
                //           label: const Text(
                //             'Select Image',
                //             style: TextStyle(
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 32),
                // WHAT IS PHENOM //////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What is Phenom',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Content',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _wp_content,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Content',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        maxLines: 5,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Button text',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _wp_button_text,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Button text',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SLIDES //////////////////////////////////////////////////////
                const SizedBox(height: 32),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         'Slides',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 16,
                //           fontWeight: FontWeight.w900,
                //         ),
                //         textAlign: TextAlign.start,
                //       ),
                //       const SizedBox(height: 16),
                //       SizedBox(
                //         width: double.infinity,
                //         child: ElevatedButton.icon(
                //           onPressed: () {},
                //           style: ElevatedButton.styleFrom(
                //             alignment: Alignment.topLeft,
                //             backgroundColor: Colors.transparent,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             side: const BorderSide(color: Colors.white),
                //             padding: const EdgeInsets.symmetric(
                //               horizontal: 32,
                //               vertical: 16,
                //             ),
                //           ),
                //           icon: const Icon(
                //             Icons.cloud_upload_outlined,
                //             color: Colors.white,
                //           ),
                //           label: const Text(
                //             'Select Image',
                //             style: TextStyle(
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // WAITLIST ////////////////////////////////////////////////////
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Waitlist',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Content',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _w_content,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Content',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        maxLines: 5,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _w_button_text,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Button text',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // WHY CHOOSE US ///////////////////////////////////////////////
                // const SizedBox(height: 32),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         'Why Choose Us',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 16,
                //           fontWeight: FontWeight.w900,
                //         ),
                //         textAlign: TextAlign.start,
                //       ),
                //       const SizedBox(height: 16),
                //       const Text(
                //         'Image',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //       const SizedBox(height: 5),
                //       SizedBox(
                //         width: double.infinity,
                //         child: ElevatedButton.icon(
                //           onPressed: () {},
                //           style: ElevatedButton.styleFrom(
                //             alignment: Alignment.topLeft,
                //             backgroundColor: Colors.transparent,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             side: const BorderSide(color: Colors.white),
                //             padding: const EdgeInsets.symmetric(
                //               horizontal: 32,
                //               vertical: 16,
                //             ),
                //           ),
                //           icon: const Icon(
                //             Icons.cloud_upload_outlined,
                //             color: Colors.white,
                //           ),
                //           label: const Text(
                //             'Select Image',
                //             style: TextStyle(
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //       ),
                //       const SizedBox(height: 16),
                //       const Text(
                //         'Caption',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //       const SizedBox(height: 5),
                //       TextField(
                //         controller: _wcu_caption,
                //         style: const TextStyle(
                //           color: Colors.white,
                //         ),
                //         decoration: InputDecoration(
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //             borderSide: const BorderSide(color: Colors.white),
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //             borderSide: const BorderSide(color: Colors.white),
                //           ),
                //           hintText: 'Caption',
                //           hintStyle: TextStyle(
                //             color: Colors.white.withOpacity(0.5),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // EARNING STRUCTURE ///////////////////////////////////////////
                // const SizedBox(height: 32),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         'Earning Structure',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 16,
                //           fontWeight: FontWeight.w900,
                //         ),
                //         textAlign: TextAlign.start,
                //       ),
                //       const SizedBox(height: 16),
                //       SizedBox(
                //         width: double.infinity,
                //         child: ElevatedButton.icon(
                //           onPressed: () {},
                //           style: ElevatedButton.styleFrom(
                //             alignment: Alignment.topLeft,
                //             backgroundColor: Colors.transparent,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             side: const BorderSide(color: Colors.white),
                //             padding: const EdgeInsets.symmetric(
                //               horizontal: 32,
                //               vertical: 16,
                //             ),
                //           ),
                //           icon: const Icon(
                //             Icons.cloud_upload_outlined,
                //             color: Colors.white,
                //           ),
                //           label: const Text(
                //             'Select Image',
                //             style: TextStyle(
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // VIDEOS //////////////////////////////////////////////////////
                // const SizedBox(height: 32),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         'Videos',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 16,
                //           fontWeight: FontWeight.w900,
                //         ),
                //         textAlign: TextAlign.start,
                //       ),
                //       const SizedBox(height: 16),
                //       Container(
                //         width: double.infinity,
                //         height: 250,
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Colors.white,
                //             width: 1,
                //           ),
                //         ),
                //       ),
                //       const SizedBox(height: 16),
                //       SizedBox(
                //         width: double.infinity,
                //         child: ElevatedButton.icon(
                //           onPressed: () {},
                //           style: ElevatedButton.styleFrom(
                //             alignment: Alignment.topLeft,
                //             backgroundColor: Colors.transparent,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             side: const BorderSide(color: Colors.white),
                //             padding: const EdgeInsets.symmetric(
                //               horizontal: 32,
                //               vertical: 16,
                //             ),
                //           ),
                //           icon: const Icon(
                //             Icons.cloud_upload_outlined,
                //             color: Colors.white,
                //           ),
                //           label: const Text(
                //             'Select Image',
                //             style: TextStyle(
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //       ),
                //       const SizedBox(height: 16),
                //       Container(
                //         width: double.infinity,
                //         height: 250,
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Colors.white,
                //             width: 1,
                //           ),
                //         ),
                //       ),
                //       const SizedBox(height: 16),
                //       SizedBox(
                //         width: double.infinity,
                //         child: ElevatedButton.icon(
                //           onPressed: () {},
                //           style: ElevatedButton.styleFrom(
                //             alignment: Alignment.topLeft,
                //             backgroundColor: Colors.transparent,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             side: const BorderSide(color: Colors.white),
                //             padding: const EdgeInsets.symmetric(
                //               horizontal: 32,
                //               vertical: 16,
                //             ),
                //           ),
                //           icon: const Icon(
                //             Icons.cloud_upload_outlined,
                //             color: Colors.white,
                //           ),
                //           label: const Text(
                //             'Select Image',
                //             style: TextStyle(
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // FOOTER //////////////////////////////////////////////////////
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.topLeft,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: const Text(
                        'Exit',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        saveData();
                      },
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.topLeft,
                        backgroundColor: const Color(0xffAC4AF2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
