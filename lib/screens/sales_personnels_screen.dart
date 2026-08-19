import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_dex/models/distributor.dart';
import 'package:impulse_dex/models/app_maintenance.dart';
import 'package:impulse_dex/providers/app_maintenance_provider.dart';
import 'package:impulse_dex/providers/stakeholder_provider.dart';
import 'package:impulse_dex/widgets/skeleton_loader.dart';
import 'package:impulse_dex/widgets/favorite_button.dart';
import 'package:impulse_dex/utils/bilingual_string.dart';
import 'package:impulse_dex/widgets/animated_list_item.dart';
import 'package:impulse_dex/providers/search_history_provider.dart';
import 'package:impulse_dex/widgets/highlight_text.dart';
import 'package:impulse_dex/widgets/asset_fallback_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class SalesPersonnelsScreen extends ConsumerStatefulWidget {
  const SalesPersonnelsScreen({super.key});

  @override
  ConsumerState<SalesPersonnelsScreen> createState() =>
      _SalesPersonnelsScreenState();
}

class _SalesPersonnelsScreenState extends ConsumerState<SalesPersonnelsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    _searchController.addListener(_onSearchTextChange);
    _searchFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {});
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      setState(() {});
      _syncSearchQuery();
    }
  }

  void _onSearchTextChange() {
    setState(() {});
    _syncSearchQuery();
  }

  void _syncSearchQuery() {
    final query = _searchController.text;
    if (_tabController.index == 0) {
      ref.read(salesPersonnelSearchQueryProvider.notifier).updateQuery(query);
    } else {
      ref.read(vetDoctorsSearchQueryProvider.notifier).updateQuery(query);
    }
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    _searchController.removeListener(_onSearchTextChange);
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSearchHistoryChips(BuildContext context, WidgetRef ref) {
    if (!_searchFocusNode.hasFocus) {
      return const SizedBox.shrink();
    }

    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      final suggestionsAsync = _tabController.index == 0
          ? ref.watch(salesPersonnelSearchTrieSuggestionsProvider)
          : ref.watch(vetDoctorSearchTrieSuggestionsProvider);

      return suggestionsAsync.when(
        data: (items) {
          if (items.isEmpty) return const SizedBox.shrink();
          return SizedBox(
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final term = items[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ActionChip(
                    avatar: Icon(
                      Icons.auto_awesome,
                      size: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: Text(
                      term,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      _searchController.text = term;
                      _syncSearchQuery();
                      ref.read(searchHistoryProvider.notifier).addQuery(term);
                    },
                  ),
                );
              },
            ),
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (e, s) => const SizedBox.shrink(),
      );
    }

    final historyAsync = ref.watch(searchHistoryProvider);
    return historyAsync.when(
      data: (items) {
        if (items.isEmpty) return const SizedBox.shrink();
        return SizedBox(
          height: 36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final term = items[index];
              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: ActionChip(
                  avatar: const Icon(Icons.history, size: 14),
                  label: Text(
                    term,
                    style: const TextStyle(fontSize: 12),
                  ),
                  onPressed: () {
                    _searchController.text = term;
                    _syncSearchQuery();
                  },
                ),
              );
            },
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (e, s) => const SizedBox.shrink(),
    );
  }



  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lang = ref.watch(languageSettingProvider);

    final tabs = [
      lang == 'bn' ? 'প্রতিনিধি' : 'Representatives',
      lang == 'bn' ? 'ভেটেরিনারিয়ান' : 'Veterinarians',
    ];

    final hasChips = _searchFocusNode.hasFocus;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang == 'bn' ? 'যোগাযোগ' : 'Contacts',
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        actions: [
          IconButton(
            icon: Text(
              lang == 'bn' ? 'EN' : 'বাংলা',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            onPressed: () =>
                ref.read(languageSettingProvider.notifier).toggle(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(hasChips ? 138 : 98),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 2, 16, 4),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                    hintText: _tabController.index == 0
                        ? (lang == 'bn' ? 'প্রতিনিধি খুঁজুন...' : 'Search representatives...')
                        : (lang == 'bn' ? 'ভেটেরিনারিয়ান খুঁজুন...' : 'Search veterinarians...'),
                    isDense: true,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: colorScheme.primary,
                      size: 22,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 20),
                            onPressed: () {
                              _searchController.clear();
                              _syncSearchQuery();
                              FocusScope.of(context).unfocus();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.4),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 11,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color:
                            colorScheme.outlineVariant.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color:
                            colorScheme.outlineVariant.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              _buildSearchHistoryChips(context, ref),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: TabBar(
                  controller: _tabController,
                  labelColor: colorScheme.primary,
                  unselectedLabelColor:
                      colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                  indicatorColor: colorScheme.primary,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  tabs: tabs.map((t) => Tab(text: t)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _RepresentativesTab(lang: lang),
          _VeterinariansTab(lang: lang),
        ],
      ),
    );
  }
}

class _RepresentativesTab extends ConsumerWidget {
  final String lang;
  const _RepresentativesTab({required this.lang});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paginatedSalesPersonnelProvider);

    return state.when(
      data: (data) {
        if (data.items.isEmpty) {
          return Center(
            child: Text(
              lang == 'bn' ? 'কোনো প্রতিনিধি পাওয়া যায়নি' : 'No representatives found',
            ),
          );
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
              ref.read(paginatedSalesPersonnelProvider.notifier).fetchNextPage();
            }
            return false;
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data.items.length + (data.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == data.items.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final p = data.items[index];
              return AnimatedListItem(
                index: index,
                child: _SalesPersonnelCard(personnelWithAreas: p, lang: lang),
              );
            },
          ),
        );
      },
      loading: () => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        itemBuilder: (context, index) => const DistributorCardSkeleton(),
      ),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}

class _VeterinariansTab extends ConsumerWidget {
  final String lang;
  const _VeterinariansTab({required this.lang});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paginatedVetDoctorsProvider);

    return state.when(
      data: (data) {
        if (data.items.isEmpty) {
          return Center(
            child: Text(
              lang == 'bn' ? 'কোনো ভেটেরিনারিয়ান পাওয়া যায়নি' : 'No veterinarians found',
            ),
          );
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
              ref.read(paginatedVetDoctorsProvider.notifier).fetchNextPage();
            }
            return false;
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data.items.length + (data.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == data.items.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final doctor = data.items[index];
              return AnimatedListItem(
                index: index,
                child: _VetDoctorCard(doctorWithAreas: doctor, lang: lang),
              );
            },
          ),
        );
      },
      loading: () => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        itemBuilder: (context, index) => const DistributorCardSkeleton(),
      ),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}

class _SalesPersonnelCard extends ConsumerWidget {
  final SalesPersonnelWithAreas personnelWithAreas;
  final String lang;
  const _SalesPersonnelCard({required this.personnelWithAreas, required this.lang});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personnel = personnelWithAreas.personnel;
    final query = ref.watch(salesPersonnelSearchQueryProvider);

    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(
            alpha: Theme.of(context).brightness == Brightness.dark ? 0.45 : 0.65,
          ),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (personnel.photoUrl != null && personnel.photoUrl!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: ClipOval(
                      child: AssetFallbackImage(
                        imagePath: personnel.photoUrl!.startsWith('assets/')
                            ? personnel.photoUrl!
                            : 'assets/images/${personnel.photoUrl}',
                        width: 48,
                        height: 48,
                        fallbackIcon: Icons.person,
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HighlightText(
                        text: personnel.nameEn.resolve(personnel.nameBn, lang),
                        query: query,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      if (personnel.designation != null)
                        HighlightText(
                          text: personnel.designation!,
                          query: query,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 13,
                          ),
                        ),
                      const SizedBox(height: 8),
                      if (personnelWithAreas.regions.isNotEmpty || personnelWithAreas.areas.isNotEmpty || personnelWithAreas.bases.isNotEmpty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Icon(
                                Icons.location_on,
                                size: 14,
                                color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: HighlightText(
                                text: [
                                  if (personnelWithAreas.regions.isNotEmpty)
                                    'Region: ${personnelWithAreas.regions.map((r) => r.nameEn.resolve(r.nameBn, lang)).join(', ')}',
                                  if (personnelWithAreas.areas.isNotEmpty)
                                    'Area: ${personnelWithAreas.areas.map((a) => a.nameEn.resolve(a.nameBn, lang)).join(', ')}',
                                  if (personnelWithAreas.bases.isNotEmpty)
                                    'Base: ${personnelWithAreas.bases.map((b) => b.nameEn.resolve(b.nameBn, lang)).join(', ')}',
                                ].join(' | '),
                                query: query,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      if (personnel.mobile != null && personnel.mobile!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        HighlightText(
                          text: personnel.mobile!,
                          query: query,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                FavoriteButton(
                  refId: personnel.id,
                  type: FavoriteType.salesPersonnel,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () async {
                    final rawMobile = personnel.mobile;
                    if (rawMobile != null && rawMobile.trim().isNotEmpty) {
                      final cleanMobile = rawMobile.replaceAll(RegExp(r'[^\d+]'), '');
                      final Uri uri = Uri.parse('tel:$cleanMobile');
                      try {
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        } else {
                          await launchUrl(uri);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                lang == 'bn'
                                    ? 'কল করা সম্ভব হচ্ছে না: $cleanMobile'
                                    : 'Could not make call to $cleanMobile',
                              ),
                            ),
                          );
                        }
                      }
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              lang == 'bn'
                                  ? 'ফোন নম্বর পাওয়া যায়নি'
                                  : 'Phone number not available',
                            ),
                          ),
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.call, size: 18),
                  label: Text(lang == 'bn' ? 'কল করুন' : 'Call'),
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 36,
                color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () async {
                    try {
                      final newContact = Contact(
                        name: Name(first: personnel.nameEn.resolve(personnel.nameBn, lang)),
                        phones: [Phone(number: personnel.mobile ?? '')],
                        organizations: [
                          Organization(
                            name: 'Impulse',
                            jobTitle: personnel.designation ?? '',
                          )
                        ],
                      );
                      await FlutterContacts.native.showCreator(contact: newContact);
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.person_add, size: 18),
                  label: Text(lang == 'bn' ? 'সেভ করুন' : 'Save'),
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VetDoctorCard extends ConsumerWidget {
  final VetDoctorWithAreas doctorWithAreas;
  final String lang;
  const _VetDoctorCard({required this.doctorWithAreas, required this.lang});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctor = doctorWithAreas.doctor;
    final query = ref.watch(vetDoctorsSearchQueryProvider);

    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(
            alpha: Theme.of(context).brightness == Brightness.dark ? 0.45 : 0.65,
          ),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (doctor.photoUrl != null && doctor.photoUrl!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: ClipOval(
                      child: AssetFallbackImage(
                        imagePath: doctor.photoUrl!.startsWith('assets/')
                            ? doctor.photoUrl!
                            : 'assets/images/${doctor.photoUrl}',
                        width: 48,
                        height: 48,
                        fallbackIcon: Icons.medical_services,
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HighlightText(
                        text: doctor.nameEn.resolve(doctor.nameBn, lang),
                        query: query,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      if (doctor.qualification != null && doctor.qualification!.isNotEmpty)
                        HighlightText(
                          text: doctor.qualification!,
                          query: query,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 13,
                          ),
                        ),
                      if (doctor.specialization != null && doctor.specialization!.isNotEmpty)
                        HighlightText(
                          text: doctor.specialization!,
                          query: query,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 13,
                          ),
                        ),
                      const SizedBox(height: 8),
                      if (doctorWithAreas.regions.isNotEmpty || doctorWithAreas.areas.isNotEmpty || doctorWithAreas.bases.isNotEmpty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Icon(
                                Icons.location_on,
                                size: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant
                                    .withValues(alpha: 0.6),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: HighlightText(
                                text: [
                                  if (doctorWithAreas.regions.isNotEmpty)
                                    'Region: ${doctorWithAreas.regions.map((r) => r.nameEn.resolve(r.nameBn, lang)).join(', ')}',
                                  if (doctorWithAreas.areas.isNotEmpty)
                                    'Area: ${doctorWithAreas.areas.map((a) => a.nameEn.resolve(a.nameBn, lang)).join(', ')}',
                                  if (doctorWithAreas.bases.isNotEmpty)
                                    'Base: ${doctorWithAreas.bases.map((b) => b.nameEn.resolve(b.nameBn, lang)).join(', ')}',
                                ].join(' | '),
                                query: query,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      if (doctor.mobile != null && doctor.mobile!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        HighlightText(
                          text: doctor.mobile!,
                          query: query,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                FavoriteButton(
                  refId: doctor.id,
                  type: FavoriteType.vetDoctor,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () async {
                    final rawMobile = doctor.mobile;
                    if (rawMobile != null && rawMobile.trim().isNotEmpty) {
                      final cleanMobile =
                          rawMobile.replaceAll(RegExp(r'[^\d+]'), '');
                      final Uri uri = Uri.parse('tel:$cleanMobile');
                      try {
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        } else {
                          await launchUrl(uri);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                lang == 'bn'
                                    ? 'কল করা সম্ভব হচ্ছে না: $cleanMobile'
                                    : 'Could not make call to $cleanMobile',
                              ),
                            ),
                          );
                        }
                      }
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              lang == 'bn'
                                  ? 'ফোন নম্বর পাওয়া যায়নি'
                                  : 'Phone number not available',
                            ),
                          ),
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.call, size: 18),
                  label: Text(lang == 'bn' ? 'কল করুন' : 'Call'),
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 36,
                color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () async {
                    try {
                      final newContact = Contact(
                        name: Name(
                            first: doctor.nameEn.resolve(doctor.nameBn, lang)),
                        phones: [Phone(number: doctor.mobile ?? '')],
                        organizations: [
                          Organization(
                            name: 'Impulse',
                            jobTitle: doctor.specialization ?? '',
                          )
                        ],
                      );
                      await FlutterContacts.native
                          .showCreator(contact: newContact);
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.person_add, size: 18),
                  label: Text(lang == 'bn' ? 'সেভ করুন' : 'Save'),
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
