import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/models.dart';
import '../widgets/discovery_card.dart';
import '../widgets/location_selector_sheet.dart';
import '../widgets/trip_card.dart';
import '../widgets/create_trip_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedLocation = 'Kochi';
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  late List<Trip> _userTrips;

  final List<String> _categoryChips = [
    'All',
    'Nearby',
    'Events',
    'Trips',
    'Destinations',
    'Food',
    'Adventure',
    'Camping',
    'Festivals',
    'Family',
    'Luxury',
    'Nature',
    'Road Trips',
    'Beach',
    'Mountains',
  ];

  @override
  void initState() {
    super.initState();
    _userTrips = List.from(dummyTrips);
    _searchController.addListener(() {
      setState(() {});
    });
  }

  void _openLocationSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LocationSelectorSheet(
        selectedLocation: _selectedLocation,
        onLocationSelected: (newLoc) {
          setState(() {
            _selectedLocation = newLoc;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Feed updated for location: Near $newLoc 📍')),
          );
        },
      ),
    );
  }

  void _openCreateTripSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateTripSheet(
        onTripCreated: () {
          setState(() {
            _userTrips.insert(
              0,
              Trip(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                destination: 'New Adventure',
                coverUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&q=80&w=800',
                startDate: DateTime.now().add(const Duration(days: 14)),
                endDate: DateTime.now().add(const Duration(days: 21)),
                budget: 1500.0,
                status: 'Planning',
                isPublic: false,
                isOwner: true,
                routeEndpoint: 'Kochi ➔ New Adventure',
                members: [dummyMembers[0]],
                chatMessages: [],
                activities: [],
                gallery: [],
              ),
            );
          });
        },
      ),
    );
  }

  List<DiscoveryItem> _getFilteredItems() {
    final query = _searchController.text.toLowerCase().trim();

    return dummyDiscoveryItems.where((item) {
      // Location Filtering (If Nearby chip selected or matching cityTag)
      final matchesLocation = (_selectedCategory == 'Nearby')
          ? item.cityTag == _selectedLocation
          : (item.cityTag == _selectedLocation || item.cityTag != _selectedLocation);

      // Category Filtering
      bool matchesCategory = true;
      if (_selectedCategory != 'All') {
        if (_selectedCategory == 'Nearby') {
          matchesCategory = item.cityTag == _selectedLocation;
        } else {
          matchesCategory = item.tags.any((t) => t.toLowerCase() == _selectedCategory.toLowerCase()) ||
              item.type.name.toLowerCase().contains(_selectedCategory.toLowerCase());
        }
      }

      // Search Query Filtering
      bool matchesQuery = true;
      if (query.isNotEmpty) {
        matchesQuery = item.title.toLowerCase().contains(query) ||
            item.location.toLowerCase().contains(query) ||
            item.subtitle.toLowerCase().contains(query) ||
            item.tags.any((t) => t.toLowerCase().contains(query));
      }

      return matchesLocation && matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredDiscoveryList = _getFilteredItems();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top Bar & Location Selector Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Good Morning 👋',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Ready for your next adventure?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        // Location Selector Pill
                        InkWell(
                          onTap: _openLocationSelector,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Near $_selectedLocation',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                const Icon(Icons.arrow_drop_down, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search destinations, events, cities, countries...',
                          prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () => _searchController.clear(),
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                          hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Horizontal Category Chips (Sticky feel)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _categoryChips.length,
                  itemBuilder: (context, index) {
                    final chipLabel = _categoryChips[index];
                    final isSelected = _selectedCategory == chipLabel;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(chipLabel),
                        selected: isSelected,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        side: BorderSide.none,
                        onSelected: (val) {
                          if (val) {
                            setState(() {
                              _selectedCategory = chipLabel;
                            });
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            // The Discovery Feed ("The Wall")
            if (filteredDiscoveryList.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return DiscoveryCard(item: filteredDiscoveryList[index]);
                    },
                    childCount: filteredDiscoveryList.length,
                  ),
                ),
              )
            else
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                  child: Column(
                    children: [
                      Icon(Icons.explore_off, size: 54, color: Colors.grey[400]),
                      const SizedBox(height: 12),
                      Text(
                        'No experiences found in $_selectedCategory for "$_selectedLocation"',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _selectedCategory = 'All';
                            _searchController.clear();
                          });
                        },
                        child: const Text('Reset Filters'),
                      ),
                    ],
                  ),
                ),
              ),
            // Personal Section: "Continue Planning" towards bottom
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 40),
                    const Text(
                      'Continue Planning',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your upcoming itineraries and saved trips.',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            if (_userTrips.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final trip = _userTrips[index];
                      return TripCard(
                        trip: trip,
                        onTripLeft: () {
                          setState(() {
                            _userTrips.removeAt(index);
                          });
                        },
                        onTripDeleted: () {
                          setState(() {
                            _userTrips.removeAt(index);
                          });
                        },
                      );
                    },
                    childCount: _userTrips.length,
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateTripSheet,
        icon: const Icon(Icons.add),
        label: const Text('Create Trip'),
      ),
    );
  }
}
