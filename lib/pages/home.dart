import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phenom2025/components/faq_options.dart';
import 'package:phenom2025/components/how_it_works.dart';
import 'package:phenom2025/components/signup.dart';
import 'package:phenom2025/components/socials.dart';
import 'package:phenom2025/pages/admin.dart';
import 'package:phenom2025/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<dynamic> data = [];

  final List<String> images = [
    'assets/images/slide/image1.jpg',
    'assets/images/slide/image2.jpg',
    'assets/images/slide/image3.jpg',
    'assets/images/slide/image4.jpg',
    'assets/images/slide/image5.jpg',
    'assets/images/slide/image6.jpg',
  ];

  final _email = TextEditingController();
  final _password = TextEditingController();

  late VideoPlayerController _controller1;
  late ChewieController _chewieController1;

  late VideoPlayerController _controller2;
  late ChewieController _chewieController2;

  Future<void> login() async {
    final loginProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      await loginProvider.login(_email.text, _password.text);
      adminNavigate();
      _email.clear();
      _password.clear();
    } catch (e) {
      showSnackError(e);
    }
  }

  // Future<void> loadVideo() async {
  //   final homeProvider = Provider.of<UserProvider>(context, listen: false);
  //   try {
  //     var videos = await homeProvider.getVideos();

  //     // Cache the first video
  //     final file1 = await DefaultCacheManager()
  //         .getSingleFile(videos['video'][0].toString());
  //     _controller1 = VideoPlayerController.file(file1);

  //     // Cache the second video
  //     final file2 = await DefaultCacheManager()
  //         .getSingleFile(videos['video'][1].toString());
  //     _controller2 = VideoPlayerController.file(file2);

  //     _chewieController1 = ChewieController(
  //       videoPlayerController: _controller1,
  //       autoPlay: true,
  //       looping: true,
  //       showControls: true,
  //     );

  //     _chewieController2 = ChewieController(
  //       videoPlayerController: _controller2,
  //       autoPlay: false,
  //       looping: true,
  //       showControls: true,
  //     );

  //     isLoading = false;

  //     setState(() {});
  //   } catch (e) {
  //     showSnackError(e);
  //   }
  // }

  void adminNavigate() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => const Admin(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // fetchData();
    // loadVideo();

    _controller1 = VideoPlayerController.asset('assets/videos/video1.mp4');
    _controller2 = VideoPlayerController.asset('assets/videos/video2.mp4');

    _chewieController1 = ChewieController(
      videoPlayerController: _controller1,
      autoPlay: true,
      looping: true,
      showControls: true,
    );

    _chewieController2 = ChewieController(
      videoPlayerController: _controller2,
      autoPlay: false,
      looping: true,
      showControls: true,
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _chewieController1.dispose();
    _chewieController2.dispose();
    super.dispose();
  }

  // Future<void> fetchData() async {
  //   try {
  //     final querySnapshot =
  //         await FirebaseFirestore.instance.collection('phenom2025').get();
  //     data = querySnapshot.docs.map((doc) => doc.data()).toList();
  //     setState(() {
  //       isLoading = false;
  //       print(data);
  //     });
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //     showSnackError(e);
  //   }
  // }

  showSnackError(e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // content: Text("Error fetching data: $e"),
        content: Text(e.toString()),
        backgroundColor: const Color(0xff510D84),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<UserProvider>(context, listen: false);
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // NAVBAR //////////////////////////////////////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onLongPress: () {
                        showDialog(
                            context: context,
                            barrierColor: Colors.white.withOpacity(0.1),
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.black,
                                content: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'LOGIN',
                                              style: TextStyle(
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
                                        TextField(
                                          controller: _email,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            hintText: 'Email',
                                            prefixIcon: const Icon(
                                              Icons.email,
                                              color: Colors.white,
                                            ),
                                            hintStyle: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          controller: _password,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            prefixIcon: const Icon(
                                              Icons.lock,
                                              color: Colors.white,
                                            ),
                                            hintText: 'Password',
                                            hintStyle: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                        ElevatedButton(
                                          onPressed: login,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xffffffff),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 32,
                                              vertical: 16,
                                            ),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Login',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: const Image(
                        image: AssetImage('assets/images/logo2.png'),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        signUp(context);
                      },
                      icon: const Icon(
                        Icons.person_add_alt_1,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // HERO ////////////////////////////////////////////////////////
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: const Image(
                        image: AssetImage('assets/images/hero.png'),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            howItWorks(context);
                          },
                          icon: const Icon(
                            Icons.settings_outlined,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'How it works',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
                // WHAT IS PHENOM //////////////////////////////////////////////
                FutureBuilder(
                    future: homeProvider.getWhatIsPhenom(),
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
                        return Column(
                          children: [
                            const Text(
                              'WHAT IS PHENOM?',
                              style: TextStyle(
                                color: Color(0xffAC4AF2),
                                fontWeight: FontWeight.w900,
                                fontSize: 28,
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              snapshot.data['content'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                signUp(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffAC4AF2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                              ),
                              child: Text(
                                snapshot.data['button_text'].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    })),
                // CAROUSEL SLIDER /////////////////////////////////////////////
                const SizedBox(height: 64),
                CarouselSlider(
                  items: images.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            imagePath
                                .toString(), // Ensure the value is a string
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        );
                      },
                    );
                  }).toList(), // Convert the iterable to a list
                  options: CarouselOptions(
                    height: 400,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                ),
                // WAITLIST ////////////////////////////////////////////////////
                const SizedBox(height: 64),
                FutureBuilder(
                  future: homeProvider.getWaitlist(),
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
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 32,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xff21112F),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xff362942),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Waitlist!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              snapshot.data['content'].toString(),
                              style: const TextStyle(
                                color: Colors.white38,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: () {
                                signUp(context);
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
                              child: Text(
                                snapshot.data['button_text'].toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ),
                const SizedBox(height: 150),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const Image(
                    image: AssetImage('assets/images/features.jpg'),
                  ),
                ),
                // WHY CHOOSE US ///////////////////////////////////////////////
                const SizedBox(height: 150),
                const Image(
                  image: AssetImage('assets/images/faq.png'),
                ),
                const SizedBox(height: 32),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'WHY',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextSpan(
                        text: ' CHOOSE ',
                        style: TextStyle(
                          color: Color(0xffAC4AF2),
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                        ),
                      ),
                      TextSpan(
                        text: 'US',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      faqOptions(
                        Icons.person,
                        'Users are placed first',
                      ),
                      const SizedBox(height: 10),
                      faqOptions(
                        Icons.person,
                        'Experience and expertise from the team',
                      ),
                      const SizedBox(height: 10),
                      faqOptions(
                        Icons.content_paste_search,
                        'Transparency',
                      ),
                      const SizedBox(height: 10),
                      faqOptions(
                        Icons.security_sharp,
                        'Data security',
                      ),
                      const SizedBox(height: 10),
                      faqOptions(
                        Icons.support_agent_outlined,
                        'On seat and instant customer services',
                      ),
                      const SizedBox(height: 10),
                      faqOptions(
                        Icons.credit_card,
                        'Swift disbursement of payments',
                      ),
                      const SizedBox(height: 10),
                      faqOptions(
                        Icons.map,
                        'Global recognition',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 64),
                // VIDEO ONE ///////////////////////////////////////////////////
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AspectRatio(
                    aspectRatio: _controller1.value.aspectRatio,
                    child: Chewie(controller: _chewieController1),
                  ),
                ),
                // EARNING STRUCTURE ///////////////////////////////////////////
                const SizedBox(height: 64),
                const Text(
                  'EARNING STRUCTURE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 32),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Image(
                      image: AssetImage('assets/images/earning.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // VIDEO TWO ///////////////////////////////////////////////////
                const SizedBox(height: 64),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: AspectRatio(
                    aspectRatio: _controller2.value.aspectRatio,
                    child: Chewie(controller: _chewieController2),
                  ),
                ),
                // SOCIAL ICONS ////////////////////////////////////////////////
                const SizedBox(height: 100),
                const Socials(),
                const SizedBox(height: 32),
                // FOOTER //////////////////////////////////////////////////////
                const Image(
                  image: AssetImage('assets/images/logo2.png'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'All rights reserved ©️ Phenom 2025',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
