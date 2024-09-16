// import 'package:flutter/material.dart';
// import '../widget/cat_card.dart';
// import 'detail_screen.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class LandingScreen extends StatefulWidget {
//   @override
//   _LandingScreenState createState() => _LandingScreenState();
// }

// class _LandingScreenState extends State<LandingScreen> {
//   List catBreeds = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchCatBreeds();
//   }

//   Future<void> fetchCatBreeds() async {
//     final response = await http.get(
//       Uri.parse('https://api.thecatapi.com/v1/breeds'),
//       headers: {'x-api-key': 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'},
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         catBreeds = json.decode(response.body);
//         isLoading = false;
//       });
//     } else {
//       throw Exception('Failed to load cat breeds');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cat Breeds'),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: catBreeds.length,
//               itemBuilder: (context, index) {
//                 final cat = catBreeds[index];
//                 return CatCard(
//                   name: cat['name'],
//                   origin: cat['origin'],
//                   intelligence: cat['intelligence'].toString(),
//                   imageUrl: 'https://cdn2.thecatapi.com/images/${cat['reference_image_id']}.jpg',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailScreen(cat: cat),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../widget/cat_card.dart';
import 'detail_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List catBreeds = [];
  List filteredCatBreeds = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCatBreeds();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchCatBreeds() async {
    final response = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/breeds'),
      headers: {'x-api-key': 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'},
    );

    if (response.statusCode == 200) {
      setState(() {
        catBreeds = json.decode(response.body);
        filteredCatBreeds = catBreeds; // Cargar todos los datos al inicio
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load cat breeds');
    }
  }

  void _onSearchChanged() {
    // Actualizar los resultados de búsqueda cuando el usuario escribe
    setState(() {
      String searchText = searchController.text.toLowerCase();
      if (searchText.isEmpty) {
        filteredCatBreeds = catBreeds; // Mostrar todos los registros si no hay input
      } else {
        filteredCatBreeds = catBreeds
            .where((cat) => cat['name'].toLowerCase().contains(searchText))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Breeds'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Buscar por raza',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) => _onSearchChanged(), // Interactuar en cada input del teclado
            ),
          ),
          Expanded(
            child: isLoading
							? Center(child: CircularProgressIndicator())
							: filteredCatBreeds.isEmpty
								? Center(
										child: Text(
											'No se encontraron coincidencias.',
											style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
										),
									)
								: ListView.builder(
									itemCount: filteredCatBreeds.length,
									itemBuilder: (context, index) {
										final cat = filteredCatBreeds[index];
										return CatCard(
											name: cat['name'],
											origin: cat['origin'],
											intelligence: cat['intelligence'].toString(),
											imageUrl: 'https://cdn2.thecatapi.com/images/${cat['reference_image_id']}.jpg',
											onTap: () {
												Navigator.push(
													context,
													MaterialPageRoute(
														builder: (context) => DetailScreen(cat: cat),
													),
												);
											},
										);
									},
								),
          ),
        ],
      ),
    );
  }
}
