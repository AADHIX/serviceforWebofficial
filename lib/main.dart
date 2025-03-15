
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel_slider
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => LanguageController(),
    child: const MarketingApp(),
  ),
);

class MarketingApp extends StatelessWidget {
  const MarketingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoSpace ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0x00B9FF66),
        scaffoldBackgroundColor: const Color(0xF3F3F3F3),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: LandingPage(), // Removed const
    );
  }
}

class LanguageController extends ChangeNotifier {
  String _currentLanguage = 'en';
  
  String get currentLanguage => _currentLanguage;

  void setLanguage(String language) {
    _currentLanguage = language;
    notifyListeners();
  }
}





class LandingPage extends StatelessWidget {
  // Remove const from constructor since child widgets aren't const
  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: ClipOval(
                child: Image.asset('assets/images/logo1.png', height: 32),
              ),
            ),
            const SizedBox(width: 8),
            const Text('AutoSpace',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),
            const SizedBox(height: 80),
            _buildGridSection(context, 'Services', services),
            const SizedBox(height: 80),
            _buildOfferCarddsSection(),
            const SizedBox(height: 80),
            _buildYoutubeSection(),
            const SizedBox(height: 80),
            const TeamSection(), // Removed const since TeamSection isn't const
            const SizedBox(height: 80),
            _buildReviewSection(),
            const SizedBox(height: 80),
            _buildFooterSection(context),
          ],
        ),
      ),
    );
  }


  Widget _buildHeroSection(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isSmallScreen = constraints.maxWidth < 800;
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          children: [
            if (isSmallScreen) ...[
              _buildHeroContent(),
              const SizedBox(height: 40),
              _buildHeroImage(context),
            ] else
              Row(
                children: [
                  Expanded(child: _buildHeroContent()),
                  Expanded(child: _buildHeroImage(context)),
                ],
              ),
          ],
        ),
      );
    },
  );
}

// Extract hero content to separate method
Widget _buildHeroContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Navigating the\n',
              style: GoogleFonts.openSans(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: 'digital landscape\n',
              style: GoogleFonts.openSans(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: 'for success',
              style: GoogleFonts.openSans(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(227, 144, 240, 70),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      Text(
        'Our AutoSpace helps\nto navigate seamlessly\nsecurely and efficiently.',
        textAlign: TextAlign.justify,
        style: GoogleFonts.mPlus1Code(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          height: 1.6,
          letterSpacing: 0.5,
          color: Colors.black87,
        ),
      ),
    ],
  );
}

// Extract hero image to separate method
Widget _buildHeroImage(BuildContext context) {
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
        maxHeight: 400,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/hero.png',
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  
// Update the grid section building methods



Widget _buildGridSection(BuildContext context, String title, List<ServiceItem> items) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isSmallScreen = constraints.maxWidth < 600;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(title),
                const SizedBox(height: 12),
                _buildSectionDescription(),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isSmallScreen ? 6 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isSmallScreen ? 1.5 : 2.0, // Adjusted ratio since cards are now shorter
            ),
            itemBuilder: (context, index) => _buildResponsiveInfoCard(items[index], index),
          ),
        ],
      );
    },
  );
}


// Add this helper method for responsive info cards
final List<Color> sectionTitleColors = [
  const Color(0xFFE6F4EA),  // Light mint
  const Color(0xFFFCE8E6),  // Light coral
  const Color(0xFFE8F0FE),  // Light blue
];



final List<Color> cardTitleColors = [
  const Color(0xFF49DC13),  // gr
  const Color(0xEB9EA09B),  // wh
  const Color(0xEB9EA09B),  // wh
  const Color(0xFF49DC13),  // gr
  const Color(0xEB9EA09B),  // wh
  const Color(0xFF49DC13),  // gr
];

final List<Color> cardBackgroundColors = [
  const Color(0xEB9EA09B),  // Light grey
  const Color(0xFF49DC13),  // Green
  const Color(0xB6151A38),  // Blue
  const Color(0xEB4C4D4A),  // Light grey
  const Color(0xFF49DC13),  // Green
  const Color(0xB6151A38),  // Blue
];

Widget _buildResponsiveInfoCard(ServiceItem item, int index) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    color: cardBackgroundColors[index % cardBackgroundColors.length],
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(
            item.icon,
            size: 24,
            color: Colors.black87,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: item.title,
                    style: GoogleFonts.viga(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      backgroundColor: cardTitleColors[index % cardTitleColors.length],
                    ),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

// Add this helper method for section titles
Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: RichText(
      text: TextSpan(
        text: title,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          backgroundColor: const Color(0xFF49DC13),
        ),
      ),
    ),
  );
}



Widget _buildSectionDescription() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Text(
      ' Our comprehensive services are designed to streamline your parking experience, offering real-time information, navigation assistance, and advanced features like pre-booking and automatic entry/exit.',
      style: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.black87,
        height: 1.6,
        
      ),
    ),
  );
}





//.............///
Widget _buildYoutubeSection() {
  return Consumer<LanguageController>(
    builder: (context, languageController, child) {
      // Define video IDs for different languages
      final Map<String, String> videoIds = {
        'en': 'U5fcrFz6Ma0', // Example video ID for English
        'ml': '46IpbQ_0FUw', // Example video ID for Malayalam
      };

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Replaced Container with RichText for title with background color
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: youtubeTranslations[languageController.currentLanguage]!['channel_title']!,
                      style: GoogleFonts.inter(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold,
                        backgroundColor: const Color.fromARGB(255, 102, 239, 72),
                      ),
                    ),
                  ],
                ),
              ),
              // Removed the subscribe_text section
              const Spacer(),
              // Language Selector
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 102, 239, 72),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: languageController.currentLanguage,
                    icon: const Icon(Icons.language, color: Colors.green),
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('English',
                        textAlign: TextAlign.justify, 
                          style: GoogleFonts.inter(fontSize: 14, color: Colors.black87)),
                      ),
                      DropdownMenuItem(
                        value: 'ml',
                        child: Text('മലയാളം',
                        textAlign: TextAlign.justify, 
                          style: GoogleFonts.inter(fontSize: 14, color: Colors.black87)),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        languageController.setLanguage(newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          // Added description below the title
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: Text(
              youtubeTranslations[languageController.currentLanguage]!['channel_description'] ?? 'Watch our latest videos on car maintenance and repair tips.',
              style: GoogleFonts.inter(fontSize: 14, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 16),
          // Main content - YouTube Player on a Card
          Align(
            alignment: Alignment.center,
            child: Card(
              // Card with border radius
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                width: 500,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video title
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        youtubeTranslations[languageController.currentLanguage]!['video_title'] ?? 'Featured Video',
                        style: GoogleFonts.inter(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // YouTube Player
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 300,
                        color: Colors.grey.shade200,
                        child: YoutubePlayerWidget(
                          videoId: videoIds[languageController.currentLanguage]!,
                        ),
                      ),
                    ),
                    // Video description and actions
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        youtubeTranslations[languageController.currentLanguage]!['video_description'] ?? 
                            'Learn about car maintenance tips in this informative video.',
                        style: GoogleFonts.inter(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.thumb_up_outlined),
                          label: Text(
                            youtubeTranslations[languageController.currentLanguage]!['like_button'] ?? 'Like',
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color.fromARGB(255, 102, 239, 72),
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined),
                          label: Text(
                            youtubeTranslations[languageController.currentLanguage]!['share_button'] ?? 'Share',
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      );
    },
  );
}




Widget _buildFooterSection(BuildContext context) {
  return Container(
    color: const Color(0xFF111827), // Dark background color
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left section - Contact information
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contact us button
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8BE249), // Green button
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Contact us',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Email
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Email: ',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 254, 254, 254),
                            ),
                          ),
                          TextSpan(
                            text: 'info@positivus.com',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Phone
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Phone: ',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 253, 253, 253),
                            ),
                          ),
                          TextSpan(
                            text: '855-507-8801',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 250, 248, 248),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Address
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Address: ',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 253, 253, 253),
                            ),
                          ),
                          TextSpan(
                            text: '1234 Main St\nMoonstone City, Stardust State 12345',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 255, 255, 255),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Right section - Newsletter subscription
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B), // Darker container
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subscribe to news',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 247, 247, 247),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          // Email Input
                          Expanded(
                            child: Container(
                              height: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Color.fromARGB(255, 253, 253, 253)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 254, 254, 254),
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.only(bottom: 10),
                                  ),
                                  style: GoogleFonts.poppins(color: Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 10),
                          
                          // Subscribe Button
                          Container(
                            height: 42,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF8BE249),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                'Subscribe to news',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 40),
          
          // Divider
          const Divider(color: Color.fromARGB(255, 250, 250, 250), thickness: 1),
          const SizedBox(height: 20),
          
          // Footer bottom section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Copyright
              Text(
                '© 2023 Positivus. All Rights Reserved.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Color.fromARGB(255, 250, 249, 249),
                ),
              ),
              
              // Privacy Policy
              Text(
                'Privacy Policy',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Color.fromARGB(255, 250, 249, 249),
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Top navigation bar
Widget _buildTopNavigation() {
  return Container(
    color: const Color(0xFF111827),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo
        Row(
          children: [
            Icon(Icons.square, color: Color.fromARGB(255, 250, 249, 249), size: 20),
            const SizedBox(width: 8),
            Text(
              'Positivus',
              style: GoogleFonts.poppins(
                color: Color.fromARGB(255, 250, 248, 248),
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
        
        // Navigation links
        Row(
          children: [
            _navLink('About us'),
            _navLink('Services'),
            _navLink('Use Cases'),
            _navLink('Pricing'),
            _navLink('Blog'),
          ],
        ),
        
        // Social icons
        Row(
          children: [
            _socialIcon(FontAwesomeIcons.linkedin),
            _socialIcon(FontAwesomeIcons.facebook),
            _socialIcon(FontAwesomeIcons.twitter),
          ],
        ),
      ],
    ),
  );
}

Widget _navLink(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Text(
      text,
      style: GoogleFonts.poppins(
        color: Color.fromARGB(255, 247, 247, 247),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

Widget _socialIcon(IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Icon(icon, color: Color.fromARGB(255, 253, 252, 252), size: 18),
  );
}

//--------------------------//


 Widget _buildReviewSection() {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section with Responsive Layout
          Container(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Simple Text with Background and Padding
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Reviews',
                      style: GoogleFonts.viga(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        backgroundColor: const Color.fromARGB(255, 102, 239, 72),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                // Expanded Text now placed below the title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Read what our customers have to say about their experiences with AutoSpace.',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Reviews Carousel with Flow Protection
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: 16,
                    left: index == 0 ? (isMobile ? 0 : 16) : 0,
                  ),
                  child: _buildReviewCard(reviews[index], constraints),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}
//-------------------------//
Widget _buildReviewCard(Map<String, String> review, BoxConstraints constraints) {
  final cardWidth = constraints.maxWidth < 600 ? 
                    constraints.maxWidth * 0.85 : 
                    constraints.maxWidth < 900 ? 300.0 : 320.0;
                    
  return ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: cardWidth,
      minWidth: 280,
    ),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(185, 225, 255, 202),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(184, 20, 22, 18).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DottedBorder(
        color: const Color.fromARGB(214, 143, 231, 71),
        strokeWidth: 2,
        borderType: BorderType.RRect,
        radius: const Radius.circular(30),
        dashPattern: const [6, 3],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar and Name Row
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green.shade100,
                    child: Text(
                      review['name']?[0] ?? '',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      review['name'] ?? 'No Name',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Feedback Text
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    review['feedback'] ?? 'No Feedback',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              
              // Rating Stars
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(
                    5,
                    (index) => const Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 133, 83, 240),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


//-------------------//

 Widget _buildOfferCarddsSection() {
    final offers = [
      {
        'title': '50% Off on First Booking',
        'description': 'Get 50% off on your first parking slot booking.',
        'image': 'assets/cards/offer1.png',
      },
      {
        'title': 'Free Parking on Weekends',
        'description': 'Enjoy free parking on weekends for the first month.',
        'image': 'assets/cards/offer2.png',
      },
      {
        'title': 'Refer & Earn',
        'description': 'Refer a friend and earn free parking credits.',
        'image': 'assets/cards/offer3.png',
      },
      {
        'title': 'Monthly Subscription Discount',
        'description': 'Get 20% off on monthly subscription plans.',
        'image': 'assets/cards/offer4.png',
      },
    ];
         return Column(
      children: [
        // Updated Title Section - Removed BoxDecoration and using RichText with TextSpan
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: RichText(
                text: TextSpan(
                  text: 'More Services',
                  style: GoogleFonts.viga(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    backgroundColor: const Color.fromARGB(255, 102, 239, 72),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Description Container with modified layout
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Check out our latest parking slot and special offers just for you',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 5, 2, 2),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        CarouselSlider.builder(
          itemCount: offers.length,
          itemBuilder: (context, index, realIndex) {
            final offer = offers[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 5,
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      image: DecorationImage(
                        image: AssetImage(offer['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.7)],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          offer['title']!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          offer['description']!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 3.5,
            viewportFraction: 0.6,
          ),
        ),
      ],
    );
  }
}


//-------------------------//



  // Updated More Offers Section with Carousel Slider
  


class YoutubePlayerWidget extends StatefulWidget {
  final String videoId;

  const YoutubePlayerWidget({super.key, required this.videoId});

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(showControls: true, showFullscreenButton: true),
    )..loadVideoById(videoId: widget.videoId);
  }

  @override
  void didUpdateWidget(YoutubePlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoId != widget.videoId) {
      _controller.loadVideoById(videoId: widget.videoId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: _controller, aspectRatio: 16 / 9);
  }
}

//,,,,,,,,,,,,,,,//

class TeamSection extends StatelessWidget {
  const TeamSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: RichText(
                text: TextSpan(
                  text: 'Team',
                  style: GoogleFonts.viga(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    backgroundColor: const Color.fromARGB(255, 102, 239, 72),
                  ),
                ),
              ),
            ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 4,
                height: 32,
                color: const Color(0xFFB6F492),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Meet the skilled and experienced team behind our successful digital marketing strategies',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = screenWidth > 900 ? 3 : screenWidth > 600 ? 2 : 1;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: _buildTeamCards(),
              );
            },
          ),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1C1E),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'See all team',
                textAlign: TextAlign.justify,
                style: GoogleFonts.inter(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTeamCards() {
    final teamMembers = [
      {
        'name': 'John Smith',
        'role': 'CEO and Founder',
        'experience': '10+ years of experience in digital marketing. Expertise in SEO, PPC, and content strategy',
      },
      {
        'name': 'Jane Doe',
        'role': 'Director of Operations',
        'experience': '7+ years of experience in project management and team leadership. Strong organizational and communication skills',
      },
      {
        'name': 'Michael Brown',
        'role': 'Senior SEO Specialist',
        'experience': '5+ years of experience in SEO and content creation. Proficient in keyword research and on-page optimization',
      },
      {
        'name': 'Emily Johnson',
        'role': 'PPC Manager',
        'experience': '3+ years of experience in paid search advertising. Skilled in campaign management and performance analysis',
      },
      {
        'name': 'Brian Williams',
        'role': 'Social Media Specialist',
        'experience': '4+ years of experience in social media marketing. Proficient in creating and scheduling content, analyzing metrics, and building engagement',
      },
      {
        'name': 'Sarah Kim',
        'role': 'Content Creator',
        'experience': '2+ years of experience in writing and editing. Skilled in creating compelling, SEO-optimized content for various industries',
      },
    ];

    return teamMembers.map((member) => _buildTeamCard(member)).toList();
  }

  Widget _buildTeamCard(Map<String, String> member) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFB6F492),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.link,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            member['name']!,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            member['role']!,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              member['experience']!,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceItem {
  final String title;
  final String description;
  final String imagePath;
  final IconData icon;

  ServiceItem({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.icon,
  });
}

final List<ServiceItem> services = [
  ServiceItem(
    title: 'Real-time Parking Info',
    icon: Icons.directions_car,
    description: 'Get real-time updates on parking availability.',
    imagePath: 'assets/cards/Cardgrey.png'
  ),
  ServiceItem(
    title: 'Pre-Booking',
    icon: Icons.book_online,
    description: 'Reserve a parking spot in advance.',
    imagePath: 'assets/cards/Cardgreen.png'
  ),
  ServiceItem(
    title: 'Automatic Entry & Exit',
    icon: Icons.sensor_door,
    description: 'Seamless parking access with automated barriers.',
    imagePath: 'assets/cards/Cardblue.png'
  ),
  ServiceItem(
    title: 'Parking History',
    icon: Icons.sensor_door,
    description: 'Seamless parking access with automated barriers.',
    imagePath: 'assets/cards/Cardgreen.png'
  ),
  ServiceItem(
    title: 'On site Parking',
    icon: Icons.sensor_door,
    description: 'Seamless parking access with automated barriers.',
    imagePath: 'assets/cards/Cardgrey.png'
  ),
  ServiceItem(
    title: 'Effective Parking ',
    icon: Icons.sensor_door,
    description: 'Seamless parking access with automated barriers.',
    imagePath: 'assets/cards/Cardgrey.png'
  ),
];


final List<Map<String, String>> reviews = [
  {'name': 'John Doe', 'feedback': 'Great SEO services!'},
  {'name': 'Rahul Smith', 'feedback': 'Social media marketing success!'},
  {'name': 'Madhu S', 'feedback': 'Social media marketing success!'},
];

// New More Offers Data
final List<Map<String, dynamic>> moreOffers = [
  {'title': 'Elecric Charging Station', 'icon': Icons.code, 'description': 'Build responsive websites.'},
  {'title': 'Subscription for Parking Slots', 'icon': Icons.phone_android, 'description': 'Develop custom mobile apps.'},
  {'title': 'Nearby Preferences', 'icon': Icons.search, 'description': 'Optimize your website for search engines.'},
  {'title': '24/7 Customer Care Support', 'icon': Icons.thumb_up, 'description': 'Engage customers via social media.'},
];


final Map<String, Map<String, String>> youtubeTranslations = {
  'en': {
    'channel_title': 'Auto Spaze Channel',
    'subscribe_text': 'Subscribe to our channel for the latest updates and tutorials.',
    'language_select': 'Select Language'
  },
  'ml': {
    'channel_title': 'ഓട്ടോ സ്പേസ് ചാനൽ',
    'subscribe_text': 'ഏറ്റവും പുതിയ അപ്ഡേറ്റുകൾക്കും ട്യൂട്ടോറിയലുകൾക്കുമായി ഞങ്ങളുടെ ചാനൽ സബ്സ്ക്രൈബ് ചെയ്യൂ.',
    'language_select': 'ഭാഷ തിരഞ്ഞെടുക്കുക'
     
  }


  
};