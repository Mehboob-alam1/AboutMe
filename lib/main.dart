import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'About Me - Mehboob Alam Lone',
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1), // Indigo
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF818CF8), // Light Indigo
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: SplashScreen(onToggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}

// Splash Screen with Animation
class SplashScreen extends StatefulWidget {
  final void Function(bool) onToggleTheme;
  final bool isDarkMode;

  const SplashScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                MainScreen(
              onToggleTheme: widget.onToggleTheme,
              isDarkMode: widget.isDarkMode,
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.code,
                        size: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Appo Matrix',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Building Solutions That Matter',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Main Screen with Bottom Navigation
class MainScreen extends StatefulWidget {
  final void Function(bool) onToggleTheme;
  final bool isDarkMode;

  const MainScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [];

  void _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      HomeScreen(
        onToggleTheme: widget.onToggleTheme,
        isDarkMode: widget.isDarkMode,
        onNavigate: _changeIndex,
      ),
      AboutScreen(),
      SkillsScreen(),
      ProjectsScreen(),
      ContactScreen(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'About',
          ),
          NavigationDestination(
            icon: Icon(Icons.code_outlined),
            selectedIcon: Icon(Icons.code),
            label: 'Skills',
          ),
          NavigationDestination(
            icon: Icon(Icons.work_outline),
            selectedIcon: Icon(Icons.work),
            label: 'Projects',
          ),
          NavigationDestination(
            icon: Icon(Icons.contact_mail_outlined),
            selectedIcon: Icon(Icons.contact_mail),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  final void Function(bool) onToggleTheme;
  final bool isDarkMode;
  final void Function(int) onNavigate;

  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Dark Mode'),
                Switch(
                  value: isDarkMode,
                  onChanged: onToggleTheme,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Hero(
                tag: 'profile',
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  backgroundImage: const AssetImage('assets/images/ceo website.png'),
                ),
              ),
              const SizedBox(height: 30),
              FadeIn(
                delay: 0.2,
                child: Text(
                  'Hi, I\'m Mehboob Alam Lone',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              FadeIn(
                delay: 0.3,
                child: Text(
                  'Founder of Appo Matrix | Mobile App Developer',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              FadeIn(
                delay: 0.4,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          'From Code to Company: Building Solutions That Matter',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'My journey from writing my first Android app to founding Appo Matrix taught me something crucial: the most valuable innovations happen when deep technical expertise aligns with clear business objectives.',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FadeIn(
                delay: 0.5,
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildActionButton(
                      context,
                      icon: Icons.person,
                      label: 'About Me',
                      onTap: () => _navigateToIndex(context, 1),
                    ),
                    _buildActionButton(
                      context,
                      icon: Icons.code,
                      label: 'My Skills',
                      onTap: () => _navigateToIndex(context, 2),
                    ),
                    _buildActionButton(
                      context,
                      icon: Icons.work,
                      label: 'My Projects',
                      onTap: () => _navigateToIndex(context, 3),
                    ),
                    _buildActionButton(
                      context,
                      icon: Icons.contact_mail,
                      label: 'Contact Me',
                      onTap: () => _navigateToIndex(context, 4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 140,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToIndex(BuildContext context, int index) {
    onNavigate(index);
  }
}

// About Screen
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeIn(
                delay: 0.1,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Professional Background',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'I\'m a Senior Mobile App Developer with expertise in Android, Flutter, and full-stack mobile development. Over the years, I\'ve delivered 50+ apps for startups, businesses, and entrepreneurs worldwide.',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'I started Appo Matrix to help people bring their ideas to life through clean UI/UX and scalable mobile apps. I focus on quality, speed, and innovation in every project.',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeIn(
                delay: 0.2,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What Sets Us Apart',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 15),
                        _buildBulletPoint(
                          context,
                          'Technical precision: Building scalable, performant systems that grow with your business',
                        ),
                        _buildBulletPoint(
                          context,
                          'Business acumen: Translating complex technical concepts into tangible business value',
                        ),
                        _buildBulletPoint(
                          context,
                          'Industry insight: Tailoring solutions to the unique challenges of finance, healthcare, retail, and logistics',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeIn(
                delay: 0.3,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Key Information',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 15),
                        _buildInfoRow(context, Icons.location_on, 'Based in: Pakistan'),
                        _buildInfoRow(context, Icons.trending_up, 'Experience: 6+ Years'),
                        _buildInfoRow(context, Icons.business, 'Founder of Appo Matrix'),
                        _buildInfoRow(context, Icons.public, 'Worked with USA, UK, UAE & European Clients'),
                        _buildInfoRow(context, Icons.rocket_launch, 'Objective: Create impactful digital products'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '→ ',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

// Skills Screen
class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Skills'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeIn(
                delay: 0.1,
                child: _buildSkillCategory(
                  context,
                  'Mobile Development',
                  [
                    'Android (Java, Kotlin)',
                    'Flutter & FlutterFlow',
                    'iOS (Swift basics)',
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FadeIn(
                delay: 0.2,
                child: _buildSkillCategory(
                  context,
                  'Backend & APIs',
                  [
                    'Firebase',
                    'Supabase',
                    'REST APIs',
                    'Node.js Basics',
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FadeIn(
                delay: 0.3,
                child: _buildSkillCategory(
                  context,
                  'UI/UX & Tools',
                  [
                    'Figma',
                    'Adobe XD',
                    'Clean Architecture',
                    'MVVM / Provider / Riverpod',
                    'Git & Version Control',
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FadeIn(
                delay: 0.4,
                child: _buildSkillCategory(
                  context,
                  'Additional Skills',
                  [
                    'App Monetization (Ads, In-App Purchase)',
                    'Payment Gateway Integration',
                    'Push Notifications',
                    'Firebase Auth & Storage',
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCategory(
    BuildContext context,
    String title,
    List<String> skills,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: skills.map((skill) {
                return Chip(
                  label: Text(skill),
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// Projects Screen
class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  final List<Map<String, String>> projects = const [
    {
      'name': 'Halal Restaurant Finder',
      'description': 'A Flutter app to locate Halal food spots with maps and filters',
    },
    {
      'name': 'Daily Yoga App',
      'description': 'Fitness & meditation app with videos + structured workout plans',
    },
    {
      'name': 'Matrimony App',
      'description': 'Full wedding/matchmaking app with filtering & profiles',
    },
    {
      'name': 'News App',
      'description': 'Real-time news app with clean UI and categories',
    },
    {
      'name': 'VPN App',
      'description': 'Secure VPN app with subscription model',
    },
    {
      'name': 'Job Finder App',
      'description': 'Govt job listings + notifications',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return FadeIn(
            delay: index * 0.1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(
                      Icons.phone_android,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  title: Text(
                    projects[index]['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(projects[index]['description']!),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Contact Screen
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Me'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              FadeIn(
                delay: 0.1,
                child: Text(
                  'Let\'s build something amazing together!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              FadeIn(
                delay: 0.2,
                child: _buildContactCard(
                  context,
                  Icons.email,
                  'Email',
                  'mehboobcodes@gmail.com',
                  'mailto:mehboobcodes@gmail.com',
                ),
              ),
              const SizedBox(height: 15),
              FadeIn(
                delay: 0.3,
                child: _buildContactCard(
                  context,
                  Icons.language,
                  'Website',
                  'Visit Appo Matrix',
                  'https://appomatrix.com',
                ),
              ),
              const SizedBox(height: 15),
              FadeIn(
                delay: 0.4,
                child: _buildContactCard(
                  context,
                  Icons.chat,
                  'WhatsApp',
                  'Message me on WhatsApp',
                  'https://wa.me/+923171981460',
                ),
              ),
              const SizedBox(height: 15),
              FadeIn(
                delay: 0.5,
                child: _buildContactCard(
                  context,
                  Icons.business_center,
                  'LinkedIn',
                  'Connect on LinkedIn',
                  'https://www.linkedin.com/in/mehboob-alam-lone/',
                ),
              ),
              const SizedBox(height: 15),
              FadeIn(
                delay: 0.6,
                child: _buildContactCard(
                  context,
                  Icons.work,
                  'Upwork',
                  'Hire me on Upwork',
                  'https://upwork.com',
                ),
              ),
              const SizedBox(height: 30),
              FadeIn(
                delay: 0.7,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Handle hire me action
                  },



                  icon: const Icon(Icons.send),
                  label: const Text('Hire Me / Contact Me'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    String url,
  ) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(
          Icons.open_in_new,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: () async {
          try {
            final Uri uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Could not open: $e')),
              );
            }
          }
        },
      ),
    );
  }
}

// Fade In Animation Widget
class FadeIn extends StatefulWidget {
  final Widget child;
  final double delay;

  const FadeIn({
    super.key,
    required this.child,
    this.delay = 0.0,
  });

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    Future.delayed(Duration(milliseconds: (widget.delay * 1000).round()), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(_animation),
        child: widget.child,
      ),
    );
  }
}
