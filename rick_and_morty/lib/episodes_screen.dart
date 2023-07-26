import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EpisodesScreen extends StatelessWidget {
  final int id;

  const EpisodesScreen({required this.id});

  Future<List<String>> fetchEpisodes(int id) async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/episode'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> episodesDataList = data['results'];

      // Filter the episodes that contain the character with the given id in the 'characters' list
      List<String> episodes = episodesDataList
          .where((episode) => episode['characters']
              .contains('https://rickandmortyapi.com/api/character/$id'))
          .map((episode) => episode['name'].toString())
          .toList(); // Convert the episode names to strings

      return episodes;
    } else {
      throw Exception('Failed to load episodes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episodes'),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchEpisodes(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
