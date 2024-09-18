import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dashboard_page.dart'; // Import your dashboard page

class Option1Page extends StatefulWidget {
  const Option1Page({super.key});

  @override
  _Option1PageState createState() => _Option1PageState();
}

class _Option1PageState extends State<Option1Page> with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String _correctUsername = 'admin'; // Replace with actual logic
  final String _correctPassword = 'admin'; // Replace with actual logic

  final _formKey = GlobalKey<FormState>(); // Key to manage the form state

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/background_op1.mp4')
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
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward(); // Start the animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      if (username == _correctUsername && password == _correctPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Incorrect username or password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Stack(
        children: [
          // Background Video
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

          // Overlay for login form
          Center(
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
