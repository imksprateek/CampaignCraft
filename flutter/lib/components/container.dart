import 'package:flutter/material.dart';

class Containercustom extends StatelessWidget {
  final String imageUrl; // URL of the image to be displayed
  final double height; // Custom height for the container
  final double width;  // Custom width for the container

  const Containercustom({
    super.key,
    required this.imageUrl,
    required this.height,   // Accepts height parameter
    required this.width,    // Accepts width parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height,   // Uses the provided height
        width: width,     // Uses the provided width
        decoration: BoxDecoration(
          color: const Color.fromARGB(86, 158, 158, 158), // Background color while loading
          borderRadius: BorderRadius.circular(10), // Rounded corners for the container
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10), // Ensures the image fits the rounded container
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover, // Ensures the image covers the container
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child; // Image is loaded, display the image
              } else {
                // Show circular progress indicator while the image is loading
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              // Display an error icon if the image fails to load
              return const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
