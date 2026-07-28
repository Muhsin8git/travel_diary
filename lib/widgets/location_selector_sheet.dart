import 'package:flutter/material.dart';

class LocationSelectorSheet extends StatelessWidget {
  final String selectedLocation;
  final ValueChanged<String> onLocationSelected;

  const LocationSelectorSheet({
    super.key,
    required this.selectedLocation,
    required this.onLocationSelected,
  });

  static const List<Map<String, String>> locations = [
    {'name': 'Kochi', 'country': 'Kerala, India', 'icon': '🌴'},
    {'name': 'Bengaluru', 'country': 'Karnataka, India', 'icon': '🌳'},
    {'name': 'Mumbai', 'country': 'Maharashtra, India', 'icon': '🌊'},
    {'name': 'Dubai', 'country': 'UAE', 'icon': '🏙️'},
    {'name': 'Bali', 'country': 'Indonesia', 'icon': '🏝️'},
    {'name': 'Tokyo', 'country': 'Japan', 'icon': '🗼'},
    {'name': 'London', 'country': 'UK', 'icon': '🏰'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Location',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'The discovery wall will adapt to show nearby events & trips.',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final item = locations[index];
                final isSelected = item['name'] == selectedLocation;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected
                        ? Border.all(color: Theme.of(context).colorScheme.primary)
                        : Border.all(color: Colors.transparent),
                  ),
                  child: ListTile(
                    leading: Text(item['icon']!, style: const TextStyle(fontSize: 24)),
                    title: Text(
                      item['name']!,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Theme.of(context).colorScheme.primary : null,
                      ),
                    ),
                    subtitle: Text(item['country']!, style: const TextStyle(fontSize: 12)),
                    trailing: isSelected
                        ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
                        : const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
                    onTap: () {
                      onLocationSelected(item['name']!);
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
