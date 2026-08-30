import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:impulse_app/constants/app_assets.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/widgets/glass_container.dart';
import 'package:impulse_app/widgets/privacy_policy_dialog.dart';
import 'package:impulse_app/widgets/tactile_button.dart';

class AboutUsScreen extends ConsumerWidget {
  const AboutUsScreen({super.key});

  static const String websiteUrl = 'https://www.impulseagrisciencelimited.com';
  static const String supportEmail = 'impulseagriscienceltd@gmail.com';
  static const String supportPhone = '+880-1629-389015';

  Future<void> _launchUrl(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open $urlString'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final lang = ref.watch(languageSettingProvider);

    final isBn = lang == 'bn';

    final journeyItems = isBn
        ? [
            (
              year: '২০০৯',
              title: 'আদিয়ান এগ্রো লিমিটেড প্রতিষ্ঠা',
              description:
                  'আদিয়ান এগ্রো লিমিটেড (Adyan Agro Limited) ২০০৯ সালে প্রতিষ্ঠিত হয়। তখন থেকেই এটি গবাদি পশু, পোল্ট্রি এবং মৎস্য চাষ শিল্পে সেবা প্রদান করে আসছে।',
              icon: Icons.foundation_rounded,
            ),
            (
              year: 'আন্তর্জাতিক চুক্তি',
              title: 'বিশ্বমানের অংশীদারিত্ব',
              description:
                  'এটি বিশ্বমানের ওষুধ এবং পুষ্টি উপাদান, ফিড-অ্যাডিটিভস ইত্যাদি উৎপাদনকারী বিদেশি কোম্পানিগুলোর সাথে চুক্তি স্বাক্ষর শুরু করে।',
              icon: Icons.handshake_rounded,
            ),
            (
              year: 'শিল্পে বিস্তার',
              title: 'বিস্তৃত সরবরাহ নেটওয়ার্ক',
              description:
                  'এটি প্রায় সব নামকরা পশুখাদ্য উৎপাদনকারী প্রতিষ্ঠান ও খামারে মানসম্মত পণ্য সরবরাহ করেছে, কিন্তু গ্রামীণ কৃষকদের কাছে পৌঁছানোর ক্ষেত্রে সমস্যার সম্মুখীন হচ্ছিল।',
              icon: Icons.local_shipping_rounded,
            ),
            (
              year: '২০২২',
              title: 'ইম্পালস এগ্রিসায়েন্স লিমিটেড প্রতিষ্ঠা',
              description:
                  'গ্রামীণ পর্যায়ে নিজেদের পণ্য পৌঁছে দেওয়ার লক্ষ্যে ২০২২ সালে একটি সহযোগী প্রতিষ্ঠান হিসেবে Impulse Agriscience Ltd. প্রতিষ্ঠিত হয়।',
              icon: Icons.spa_rounded,
            ),
            (
              year: 'নেটওয়ার্ক সম্প্রসারণ',
              title: 'দেশব্যাপী বিস্তার',
              description:
                  'গ্রামীণ গ্রাহকদের কাছে পৌঁছানোর লক্ষ্যে বাংলাদেশের সর্বত্র নতুন নতুন কেন্দ্র স্থাপনের মাধ্যমে ইম্পালস এগ্রিসায়েন্স (Impulse Agriscience) তাদের কার্যক্রম সম্প্রসারণ শুরু করে।',
              icon: Icons.hub_rounded,
            ),
            (
              year: '২০২৬',
              title: 'জেপি ফার্মা লিমিটেড প্রতিষ্ঠা',
              description:
                  '২০২৬ সালে JP Pharma Ltd. নামে আরও একটি সিস্টার কনসার্ন প্রতিষ্ঠিত হয়। শীঘ্রই এটি ওষুধ উৎপাদন শুরু করবে।',
              icon: Icons.medication_liquid_rounded,
            ),
          ]
        : [
            (
              year: '2009',
              title: 'Adyan Agro Limited Established',
              description:
                  'Adyan Agro Limited was established in 2009. Since then, it has been serving the livestock, poultry, and Aquaculture industry.',
              icon: Icons.foundation_rounded,
            ),
            (
              year: 'Partnerships',
              title: 'Global Collaborations',
              description:
                  'It started signing agreements with world class pharmaceuticals and nutritional, feed-additives etc. producer foreign companies.',
              icon: Icons.handshake_rounded,
            ),
            (
              year: 'Distribution',
              title: 'Industry Distribution',
              description:
                  'It has distributed quality products in almost all the reknown feed producers and farms but was facing issues to reach rural farmers.',
              icon: Icons.local_shipping_rounded,
            ),
            (
              year: '2022',
              title: 'Impulse Agriscience Ltd. Established',
              description:
                  'To distribute its products at the rural level, Impulse Agriscience Ltd. was established as a sister concern in 2022.',
              icon: Icons.spa_rounded,
            ),
            (
              year: 'Expansion',
              title: 'Nationwide Expansion',
              description:
                  'Impulse agriscience started expanding by creating new bases all over Bangladesh to reach rural customers.',
              icon: Icons.hub_rounded,
            ),
            (
              year: '2026',
              title: 'JP Pharma Ltd. Established',
              description:
                  'In 2026, JP Pharma Ltd. was also established as a sister concern. Soon, it will start production of pharmaceutical products.',
              icon: Icons.medication_liquid_rounded,
            ),
          ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isBn ? 'আমাদের সম্পর্কে' : 'About Us',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        actions: [
          IconButton(
            icon: Text(
              isBn ? 'EN' : 'বাংলা',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            onPressed: () =>
                ref.read(languageSettingProvider.notifier).toggle(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. App Header Card (Spatial Glass & Brand Emblem)
            GlassContainer(
              borderRadius: 24,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.primary.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withValues(alpha: 0.15),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      AppAssets.appLogo,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.inventory_2_rounded,
                        size: 40,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Impulse',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isBn
                        ? 'ইম্পালস এগ্রিসায়েন্স লিমিটেড অফিশিয়াল ডিরেক্টরি'
                        : 'Official Product & Stakeholder Directory',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: colorScheme.primary.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified_outlined,
                          size: 14,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'v1.0.0 (Build 1)',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 2. Sister Concerns / Group Logos (Adyan -> Impulse -> JP Pharma)
            _buildSectionHeader(
              context,
              title: isBn ? 'সহযোগী প্রতিষ্ঠানসমূহ' : 'Our Companies',
              icon: Icons.corporate_fare_rounded,
            ),
            const SizedBox(height: 10),
            GlassContainer(
              borderRadius: 20,
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: _buildCompanyLogoTile(
                      context,
                      imagePath: AppAssets.logoAdyan,
                      name: isBn ? 'আদিয়ান এগ্রো' : 'Adyan Agro',
                      year: isBn ? '২০০৯' : '2009',
                      isPrimary: false,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildCompanyLogoTile(
                      context,
                      imagePath: AppAssets.logoImpulse,
                      name: isBn ? 'ইম্পালস এগ্রি' : 'Impulse Agri',
                      year: isBn ? '২০২২' : '2022',
                      isPrimary: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildCompanyLogoTile(
                      context,
                      imagePath: AppAssets.logoJpPharma,
                      name: isBn ? 'জেপি ফার্মা' : 'JP Pharma',
                      year: isBn ? '২০২৬' : '2026',
                      isPrimary: false,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 3. About Company Card
            _buildSectionHeader(
              context,
              title: isBn ? 'কোম্পানি পরিচিতি' : 'About Company',
              icon: Icons.business_rounded,
            ),
            const SizedBox(height: 10),
            GlassContainer(
              borderRadius: 20,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isBn
                        ? 'প্রাণী চিকিৎসা ও প্রাণিসম্পদ সেবায় দীর্ঘদিনের আস্থার প্রতীক ‘আদিয়ান এগ্রো লিমিটেড’-এর একটি সহযোগী প্রতিষ্ঠান হিসেবে ২০২২ সালে ‘ইম্পালস এগ্রিসায়েন্স লিমিটেড’ (Impulse Agriscience LTD) প্রতিষ্ঠিত হয়। আমাদের লক্ষ্য অত্যন্ত সহজ: বাংলাদেশের কৃষকরা যেন তাঁদের প্রয়োজনীয় মানসম্মত পণ্যগুলো ঠিক যখন প্রয়োজন, তখনই হাতের কাছে পান—তা নিশ্চিত করা। পণ্য সংগ্রহ ও বিতরণের দায়িত্ব আমরাই পালন করি, যাতে স্থানীয় কৃষকরা তাঁদের মূল কাজে—অর্থাৎ খামার পরিচালনায়—পুরোপুরি মনোযোগ দিতে পারেন।'
                        : 'Established in 2022 as a sister concern of Adyan Agro Limited—a name long trusted in veterinary care—Impulse Agriscience LTD was created with a simple purpose: to make sure farmers across Bangladesh can get the quality products they need, whenever they need them. We handle the sourcing and distribution side of things so our local farming community can focus on what they do best—running their farms.',
                    textAlign: TextAlign.justify,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isBn
                        ? 'স্থানীয় খামারিদের প্রকৃত সুফল পৌঁছে দিতে আমরা ইউরোপ ও আমেরিকার শীর্ষস্থানীয় উৎপাদকদের সাথে সরাসরি অংশীদারিত্ব গড়ে তুলেছি এবং পোল্ট্রি, গবাদি পশু ও মৎস্যচাষের জন্য নির্ভরযোগ্য সব সমাধান সরাসরি আমাদের বাজারে নিয়ে আসছি। গ্রাহকদের চাহিদার প্রতি আমরা সর্বদা সজাগ ও মনোযোগী; আর তাই, গবাদি পশুর স্বাস্থ্য সুরক্ষা এবং সারা দেশের খামারিদের জীবিকা নিরাপদ রাখার লক্ষ্যে আমরা সম্প্রতি নির্ভরযোগ্য ও উচ্চমানের টিকা (ভ্যাকসিন) সংগ্রহের কার্যক্রমও শুরু করেছি।'
                        : 'To bring real value to local growers, we partner directly with top-tier producers across Europe and the Americas, bringing dependable poultry, cattle, and aquaculture solutions straight to our markets. We’re constantly listening to what our customers need, which is why we\'ve recently expanded into sourcing trusted, high-grade vaccines to keep livestock healthy and safeguard farm livelihoods nationwide.',
                    textAlign: TextAlign.justify,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 4. Our Mission Card
            _buildSectionHeader(
              context,
              title: isBn ? 'আমাদের লক্ষ্য ও উদ্দেশ্য' : 'Our Mission',
              icon: Icons.track_changes_rounded,
            ),
            const SizedBox(height: 10),
            GlassContainer(
              borderRadius: 20,
              padding: const EdgeInsets.all(20),
              child: Text(
                isBn
                    ? 'বিশ্বমানের ওষুধ, নিউট্রিশনাল পণ্য, ফিড অ্যাডিটিভ এবং প্রয়োজনীয় টিকা সরবরাহের মাধ্যমে বাংলাদেশের কৃষি সম্প্রদায়কে ক্ষমতায়িত করা। আপসহীন গুণগতমান, নির্ভরযোগ্য সেবা এবং গবাদি পশুর স্বাস্থ্য ও উৎপাদনশীলতার প্রতি গভীর অঙ্গীকারের মাধ্যমে কৃষক ও ফিড উৎপাদনকারীদের সাথে অটুট আস্থা গড়ে তুলতে আমরা প্রতিশ্রুতিবদ্ধ।'
                    : 'To empower Bangladesh\'s agricultural community by delivering world-class medicines, nutritional products, feed additives, and essential vaccines. We are dedicated to building absolute trust with farmers and feed producers through uncompromising quality, reliable service, and a deep commitment to the health and productivity of their livestock.',
                textAlign: TextAlign.justify,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: colorScheme.onSurface,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 4. Our Journey Card
            _buildSectionHeader(
              context,
              title: isBn ? 'আমাদের পথচলা' : 'Our Journey',
              icon: Icons.timeline_rounded,
            ),
            const SizedBox(height: 10),
            GlassContainer(
              borderRadius: 20,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: List.generate(
                  journeyItems.length,
                  (index) => _buildJourneyTimelineItem(
                    context,
                    item: journeyItems[index],
                    isFirst: index == 0,
                    isLast: index == journeyItems.length - 1,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 5. Core Features Bento Grid
            _buildSectionHeader(
              context,
              title: isBn ? 'মূল সুবিধাসমূহ' : 'Key Capabilities',
              icon: Icons.widgets_rounded,
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.35,
              children: [
                _buildFeatureTile(
                  context,
                  icon: Icons.flash_on_rounded,
                  title: isBn ? 'দ্রুত অফলাইন সার্চ' : 'Instant Offline Search',
                  subtitle: isBn
                      ? 'FTS5 ও হাইব্রিড সার্চ'
                      : 'FTS5 & Hybrid RRF Engine',
                ),
                _buildFeatureTile(
                  context,
                  icon: Icons.inventory_2_rounded,
                  title: isBn ? 'সম্পূর্ণ ক্যাটালগ' : 'Complete Directory',
                  subtitle: isBn
                      ? 'উপাদান ও ব্র্যান্ড তথ্য'
                      : 'Active Composition Details',
                ),
                _buildFeatureTile(
                  context,
                  icon: Icons.contacts_rounded,
                  title: isBn ? 'প্রতিনিধি কন্টাক্টস' : 'Sales Representatives',
                  subtitle: isBn
                      ? 'সরাসরি ফোন ও কন্টাক্ট সেভ'
                      : 'Direct Call & Save Contact',
                ),
                _buildFeatureTile(
                  context,
                  icon: Icons.security_rounded,
                  title: isBn ? 'নিরাপদ ডেটা' : 'Private & Local Data',
                  subtitle: isBn
                      ? '১০০% লোকাল ডিভাইসে সংরক্ষিত'
                      : '100% On-Device SQLite DB',
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 6. Interactive Contact & Official Links
            _buildSectionHeader(
              context,
              title: isBn ? 'যোগাযোগ ও সাপোর্ট' : 'Contact & Support',
              icon: Icons.support_agent_rounded,
            ),
            const SizedBox(height: 10),
            GlassContainer(
              borderRadius: 20,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                children: [
                  _buildContactListTile(
                    context,
                    icon: Icons.language_rounded,
                    title: isBn ? 'ওয়েবসাইট ভিজিট করুন' : 'Official Website',
                    subtitle: 'www.impulseagrisciencelimited.com',
                    onTap: () => _launchUrl(context, websiteUrl),
                  ),
                  Divider(
                    height: 1,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                  ),
                  _buildContactListTile(
                    context,
                    icon: Icons.email_outlined,
                    title: isBn ? 'সাপোর্ট ইমেইল' : 'Customer Support Email',
                    subtitle: supportEmail,
                    onTap: () => _launchUrl(context, 'mailto:$supportEmail'),
                  ),
                  Divider(
                    height: 1,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                  ),
                  _buildContactListTile(
                    context,
                    icon: Icons.phone_in_talk_rounded,
                    title: isBn ? 'হটলাইন কল' : 'Hotline Call',
                    subtitle: supportPhone,
                    onTap: () => _launchUrl(context, 'tel:+8801629389015'),
                  ),
                  Divider(
                    height: 1,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                  ),
                  _buildContactListTile(
                    context,
                    icon: Icons.privacy_tip_outlined,
                    title: isBn ? 'প্রাইভেসি পলিসি ও পলিসি তথ্য' : 'Privacy Policy & Terms',
                    subtitle: isBn ? 'ডেটা নীতি দেখুন' : 'View Data & Privacy Details',
                    onTap: () {
                      HapticFeedback.selectionClick();
                      showDialog<void>(
                        context: context,
                        builder: (context) => const PrivacyPolicyDialog(),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 7. Footer & Copyright Notice
            Center(
              child: Column(
                children: [
                  Text(
                    isBn
                        ? '© ২০২৬ ইম্পালস এগ্রিসায়েন্স লিমিটেড'
                        : '© 2026 Impulse Agriscience Ltd.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isBn
                        ? 'সর্বস্বত্ব সংরক্ষিত। সকল অধিকার সংরক্ষিত।'
                        : 'All Rights Reserved. Built with Flutter & Drift.',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildJourneyTimelineItem(
    BuildContext context, {
    required ({String year, String title, String description, IconData icon})
        item,
    required bool isFirst,
    required bool isLast,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator & line
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    item.icon,
                    size: 14,
                    color: colorScheme.primary,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: colorScheme.primary.withValues(alpha: 0.25),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item.year,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.description,
                    textAlign: TextAlign.justify,
                    style: theme.textTheme.bodySmall?.copyWith(
                      height: 1.5,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyLogoTile(
    BuildContext context, {
    required String imagePath,
    required String name,
    required String year,
    required bool isPrimary,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPrimary
              ? colorScheme.primary.withValues(alpha: 0.5)
              : colorScheme.outlineVariant.withValues(alpha: 0.35),
          width: isPrimary ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
          if (isPrimary)
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 44,
            child: Center(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.business_rounded,
                  size: 28,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Est. $year',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isPrimary
                  ? colorScheme.primary
                  : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GlassContainer(
      borderRadius: 16,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: colorScheme.primary),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 11,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TactileButton(
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: colorScheme.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

