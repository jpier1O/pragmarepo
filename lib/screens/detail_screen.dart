import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> cat;

  DetailScreen({required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat['name']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            'https://cdn2.thecatapi.com/images/${cat['reference_image_id']}.jpg',
            height: 360,
							width: double.infinity,
							fit: BoxFit.cover,
							errorBuilder: (context, error, stackTrace) {
								return Image.network(
									'https://cdn2.thecatapi.com/images/${cat['reference_image_id']}.png',
									height: 360,
									width: double.infinity,
									fit: BoxFit.cover,
									errorBuilder: (context, error, stackTrace) {
										return Icon(Icons.error, size: 100);
									},
								);
							},
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre del Pais: ${cat['origin']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Inteligencia: ${cat['intelligence']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Descripción:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    cat['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
