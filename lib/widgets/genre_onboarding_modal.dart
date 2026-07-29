import 'package:flutter/material.dart';

class GenreOnboardingModal extends StatefulWidget {
  final List<String> selectedGenres;
  final Function(List<String>) onGenresSaved;

  const GenreOnboardingModal({
    super.key,
    required this.selectedGenres,
    required this.onGenresSaved,
  });

  @override
  State<GenreOnboardingModal> createState() => _GenreOnboardingModalState();
}

class _GenreOnboardingModalState extends State<GenreOnboardingModal> {
  late List<String> _currentSelection;

  final List<Map<String, dynamic>> _genreCatalog = [
    {
      'title': 'Biker & Moto Club',
      'icon': Icons.two_wheeler,
      'badge': '🏍️ Group Rides',
      'color': Colors.deepOrange,
      'image': 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Trekking & Backpacking',
      'icon': Icons.hiking,
      'badge': '🥾 High Peaks',
      'color': Colors.green,
      'image': 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Camping & Wilderness',
      'icon': Icons.cabin,
      'badge': '🏕️ Bonfires',
      'color': Colors.amber,
      'image': 'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Culinary & Street Food',
      'icon': Icons.restaurant,
      'badge': '🍲 Night Crawls',
      'color': Colors.redAccent,
      'image': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Beach & Coastal Jams',
      'icon': Icons.beach_access,
      'badge': '🏖️ Cliff Tents',
      'color': Colors.teal,
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Hidden Gems & Photo',
      'icon': Icons.camera_alt,
      'badge': '📸 Secret Spots',
      'color': Colors.indigo,
      'image': 'https://images.unsplash.com/photo-1512100356356-de1b84283e18?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Overnight Road Trips',
      'icon': Icons.directions_car,
      'badge': '🚗 Interstate',
      'color': Colors.purple,
      'image': 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Wildlife & Safaris',
      'icon': Icons.nature_people,
      'badge': '🐾 Nature Trails',
      'color': Colors.lightGreen,
      'image': 'https://images.unsplash.com/photo-1534445867742-43195f401b6c?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': '4x4 Off-Roading',
      'icon': Icons.terrain,
      'badge': '🚜 Mud & Dunes',
      'color': Colors.brown,
      'image': 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Solo Backpacker Meetups',
      'icon': Icons.person_pin_circle,
      'badge': '🎒 Hostels',
      'color': Colors.blueAccent,
      'image': 'https://images.unsplash.com/photo-1528605248644-14dd04022da1?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Festivals & Concerts',
      'icon': Icons.music_note,
      'badge': '🎵 Caravans',
      'color': Colors.pink,
      'image': 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Wellness & Retreats',
      'icon': Icons.spa,
      'badge': '🧘 Quiet Camps',
      'color': Colors.cyan,
      'image': 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=400',
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentSelection = List.from(widget.selectedGenres);
  }

  void _toggleGenre(String genre) {
    setState(() {
      if (_currentSelection.contains(genre)) {
        _currentSelection.remove(genre);
      } else {
        _currentSelection.add(genre);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Header Indicator & Title
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'What\'s Your Travel Vibe? 🚀',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${_currentSelection.length} Selected',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Select your preferred companion genres to personalize your Wall.',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const Divider(),
          // 12 Visual Cards Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.25,
              ),
              itemCount: _genreCatalog.length,
              itemBuilder: (context, index) {
                final item = _genreCatalog[index];
                final String title = item['title'];
                final isSelected = _currentSelection.contains(title);

                return GestureDetector(
                  onTap: () => _toggleGenre(title),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                              : Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Background Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child: Image.network(
                            item['image'],
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Dark Overlay
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.black.withOpacity(0.75),
                              ],
                            ),
                          ),
                        ),
                        // Badge Tag
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item['badge'],
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        // Checkbox Icon
                        Positioned(
                          top: 8,
                          right: 8,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: isSelected ? Theme.of(context).colorScheme.primary : Colors.black45,
                            child: Icon(
                              isSelected ? Icons.check : Icons.add,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // Title Bottom
                        Positioned(
                          bottom: 10,
                          left: 10,
                          right: 10,
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Save Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    widget.onGenresSaved(_currentSelection);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text(
                    'Tailor My Discovery Wall',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
