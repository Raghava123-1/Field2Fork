import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'option1_page.dart';
import 'option2_page.dart';
import 'option3_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/mainscreen.mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        _videoController.play();
        _videoController.setLooping(true);
      }).catchError((error) {
        print('Error initializing video player: $error');
      });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onMenuOptionSelected(BuildContext context, String value) {
    switch (value) {
      case 'signInHead':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Option1Page()));
        break;
      case 'signInFarmer':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Option2Page()));
        break;
      case 'option3':
        Navigator.push(context, MaterialPageRoute(builder: (context) => Option3Page()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Field2Fork',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.withOpacity(0.8),
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => _onMenuOptionSelected(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'signInHead',
                child: Text('Sign in Head of the Rythu Bazaar'),
              ),
              const PopupMenuItem<String>(
                value: 'signInFarmer',
                child: Text('Sign in as Farmer'),
              ),
              const PopupMenuItem<String>(
                value: 'option3',
                child: Text('Near Rythu Bazaar Prices'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Video Background
          if (_isVideoInitialized)
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController.value.size.width,
                  height: _videoController.value.size.height,
                  child: VideoPlayer(_videoController),
                ),
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),

          // Overlay content with dynamic effects
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + 0.05 * _animation.value,
                  child: child,
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Field2Fork',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.7),
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  OptionCard(
                    title: 'Sign in as Head of Rythu Bazaar',
                    icon: Icons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Option1Page()),
                      );
                    },
                  ),
                  OptionCard(
                    title: 'Sign in as Farmer',
                    icon: Icons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Option2Page()),
                      );
                    },
                  ),
                  OptionCard(
                    title: 'Near Rythu Bazaar Prices',
                    icon: Icons.more_horiz,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Option3Page()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const OptionCard({super.key, 
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: onTap,
      ),
    );
  }
}
