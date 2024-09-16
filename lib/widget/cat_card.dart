import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  final String name;
  final String origin;
  final String intelligence;
  final String imageUrl;
  final VoidCallback onTap;

  CatCard({
    required this.name,
    required this.origin,
    required this.intelligence,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  imageUrl,
                  height: 360,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Si hay un error, intenta con la extensión .png
                    return Image.network(
                      imageUrl.replaceFirst('.jpg', '.png'),
                      height: 360,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Si aún falla, muestra una imagen de error por defecto
                        return Icon(Icons.error, size: 100);
                      },
                    );
                  },
                ),
                Positioned(
                  top: 8.0,
                  left: 8.0,
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Text(
                    'Más...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'País de origen: $origin',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Inteligencia: $intelligence',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
