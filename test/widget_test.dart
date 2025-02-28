import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:servicenewi/main.dart';

void main() {
  group('Marketing Landing Page Tests', () {
    testWidgets('Renders app title and navigation items', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const MarketingApp());

      // Verify that the app title is present
      expect(find.text('Positivus'), findsOneWidget);

      // Verify that all navigation items are present
      expect(find.text('About us'), findsOneWidget);
      expect(find.text('Services'), findsOneWidget);
      expect(find.text('Use Cases'), findsOneWidget);
      expect(find.text('Pricing'), findsOneWidget);
      expect(find.text('Blog'), findsOneWidget);
      expect(find.text('Request a quote'), findsOneWidget);
    });

    testWidgets('Renders hero section content', (WidgetTester tester) async {
      await tester.pumpWidget(const MarketingApp());

      // Verify hero section heading
      expect(find.text('Navigating the\ndigital landscape\nfor success'), findsOneWidget);

      // Verify hero section description
      expect(
        find.text(
          'Our digital marketing agency helps businesses\n'
          'grow and succeed online through a range of\n'
          'services including SEO, PPC, social media marketing.',
        ),
        findsOneWidget,
      );

      // Verify CTA button
      expect(find.text('Book a consultation'), findsOneWidget);
    });

    testWidgets('Renders services section with cards', (WidgetTester tester) async {
      await tester.pumpWidget(const MarketingApp());

      // Verify services section title
      expect(find.text('Services'), findsOneWidget);

      // Verify service cards
      expect(find.text('Search Engine Optimization'), findsOneWidget);
      expect(find.text('Pay-per-click Advertising'), findsOneWidget);
      expect(find.text('Social Media Marketing'), findsOneWidget);
      expect(find.text('Email Marketing'), findsOneWidget);

      // Verify 'Learn more' buttons on service cards
      expect(find.text('Learn more'), findsNWidgets(4));
    });

    testWidgets('Renders team section with member cards', (WidgetTester tester) async {
      await tester.pumpWidget(const MarketingApp());

      // Verify team section title
      expect(find.text('Our Team'), findsOneWidget);

      // Verify team member cards
      expect(find.text('Jane Doe'), findsOneWidget);
      expect(find.text('Director of Operations'), findsOneWidget);
      expect(find.text('7+ years of experience in project management'), findsOneWidget);

      expect(find.text('Michael Brown'), findsOneWidget);
      expect(find.text('Senior SEO Specialist'), findsOneWidget);
      expect(find.text('5+ years of experience in SEO'), findsOneWidget);
    });

    testWidgets('Buttons are tappable', (WidgetTester tester) async {
      await tester.pumpWidget(const MarketingApp());

      // Test Request a quote button
      await tester.tap(find.text('Request a quote'));
      await tester.pump();

      // Test Book a consultation button
      await tester.tap(find.text('Book a consultation'));
      await tester.pump();

      // Test Learn more buttons
      final learnMoreButtons = find.text('Learn more');
      for (int i = 0; i < 4; i++) {
        await tester.tap(learnMoreButtons.at(i));
        await tester.pump();
      }

      // Note: In a real app, you would add expect() statements here
      // to verify the results of button taps
    });

    testWidgets('ScrollView works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MarketingApp());

      // Find the ScrollView
      final scrollView = find.byType(SingleChildScrollView);
      expect(scrollView, findsOneWidget);

      // Test scrolling
      await tester.drag(scrollView, const Offset(0.0, -500.0));
      await tester.pump();

      // Verify that content is still visible after scrolling
      expect(find.text('Our Team'), findsOneWidget);
    });
  });
}