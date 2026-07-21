import 'package:flutter/material.dart';
import '../../models/models.dart';

class GalleryTab extends StatelessWidget {
  final Trip trip;

  const GalleryTab({super.key, required this.trip});

  void _openFullScreen(BuildContext context, Photo photo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: InteractiveViewer(
              child: Image.network(
                photo.url,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (trip.gallery.isEmpty) {
      return Center(
        child: Text(
          'No photos yet',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: trip.gallery.length,
      itemBuilder: (context, index) {
        final photo = trip.gallery[index];
        return GestureDetector(
          onTap: () => _openFullScreen(context, photo),
          child: Hero(
            tag: 'photo_${photo.id}',
            child: Image.network(
              photo.url,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
