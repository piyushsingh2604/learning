import 'package:flutter/material.dart';
import 'package:learning/FetchProduct.dart';

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TakeProduct(),
    );
  }
}

// class PixabayService {

//   Future<List<Map<String, dynamic>>> fetchImages() async {
//     final String apiUrl = 'https://pixabay.com/api/';
//     final String apiKey = '43424556-4de29c0921a89224412a17d2e';

//     final response = await http.get(Uri.parse('$apiUrl?key=$apiKey'));
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body)['hits'];
//       return List<Map<String, dynamic>>.from(data.map((e) => {
//             'imageUrl': e['webformatURL'],
//             'likes': e['likes'],
//             'views': e['views']
//           }));
//     } else {
//       throw Exception('Failed to load images');
//     }
//   }
// }

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late Future<List<Map<String, dynamic>>> _imageList;

  @override
  void initState() {
    super.initState();
    _imageList = fetchImages();
  }

  Future<List<Map<String, dynamic>>> fetchImages() async {
    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=43424556-4de29c0921a89224412a17d2e'));
    if (response.statusCode == 200) {
      final List<dynamic> isondata = json.decode(response.body)['hits'];
      return List<Map<String, dynamic>>.from(isondata.map((data) => {
            'imageUrl': data['webformatURL'],
            'likes': data['likes'],
            'views': data['views']
          }));
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _imageList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: snapshot.data![index]['imageUrl'],
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data![index]['imageUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Likes: ${snapshot.data![index]['likes']}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Views: ${snapshot.data![index]['views']}',
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;
  final int likes;
  final int views;

  FullScreenImagePage({
    required this.imageUrl,
    required this.likes,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: imageUrl,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class test {
  int? total;
  int? totalHits;
  List<Hits>? hits;

  test({this.total, this.totalHits, this.hits});

  test.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalHits = json['totalHits'];
    if (json['hits'] != null) {
      hits = <Hits>[];
      json['hits'].forEach((v) {
        hits!.add(new Hits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['totalHits'] = this.totalHits;
    if (this.hits != null) {
      data['hits'] = this.hits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hits {
  int? id;
  String? pageURL;
  String? type;
  String? tags;
  String? previewURL;
  int? previewWidth;
  int? previewHeight;
  String? webformatURL;
  int? webformatWidth;
  int? webformatHeight;
  String? largeImageURL;
  int? imageWidth;
  int? imageHeight;
  int? imageSize;
  int? views;
  int? downloads;
  int? collections;
  int? likes;
  int? comments;
  int? userId;
  String? user;
  String? userImageURL;

  Hits(
      {this.id,
      this.pageURL,
      this.type,
      this.tags,
      this.previewURL,
      this.previewWidth,
      this.previewHeight,
      this.webformatURL,
      this.webformatWidth,
      this.webformatHeight,
      this.largeImageURL,
      this.imageWidth,
      this.imageHeight,
      this.imageSize,
      this.views,
      this.downloads,
      this.collections,
      this.likes,
      this.comments,
      this.userId,
      this.user,
      this.userImageURL});

  Hits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageURL = json['pageURL'];
    type = json['type'];
    tags = json['tags'];
    previewURL = json['previewURL'];
    previewWidth = json['previewWidth'];
    previewHeight = json['previewHeight'];
    webformatURL = json['webformatURL'];
    webformatWidth = json['webformatWidth'];
    webformatHeight = json['webformatHeight'];
    largeImageURL = json['largeImageURL'];
    imageWidth = json['imageWidth'];
    imageHeight = json['imageHeight'];
    imageSize = json['imageSize'];
    views = json['views'];
    downloads = json['downloads'];
    collections = json['collections'];
    likes = json['likes'];
    comments = json['comments'];
    userId = json['user_id'];
    user = json['user'];
    userImageURL = json['userImageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pageURL'] = this.pageURL;
    data['type'] = this.type;
    data['tags'] = this.tags;
    data['previewURL'] = this.previewURL;
    data['previewWidth'] = this.previewWidth;
    data['previewHeight'] = this.previewHeight;
    data['webformatURL'] = this.webformatURL;
    data['webformatWidth'] = this.webformatWidth;
    data['webformatHeight'] = this.webformatHeight;
    data['largeImageURL'] = this.largeImageURL;
    data['imageWidth'] = this.imageWidth;
    data['imageHeight'] = this.imageHeight;
    data['imageSize'] = this.imageSize;
    data['views'] = this.views;
    data['downloads'] = this.downloads;
    data['collections'] = this.collections;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['user_id'] = this.userId;
    data['user'] = this.user;
    data['userImageURL'] = this.userImageURL;
    return data;
  }
}

class TakeProduct extends StatefulWidget {
  const TakeProduct({super.key});

  @override
  State<TakeProduct> createState() => _TakeProductState();
}

class _TakeProductState extends State<TakeProduct> {
  late Future<List<Hits>> imageslist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageslist = fetchdata();
  }

  Future<List<Hits>> fetchdata() async {
    final response = await http.get(Uri.parse('https://pixabay.com/api/?key=43424556-4de29c0921a89224412a17d2e'));
    if (response.statusCode == 200) {
      List<dynamic> jsondata = jsonDecode(response.body)['hits'];
      return jsondata.map((data) => Hits.fromJson(data)).toList();
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Hits>>(
        future: imageslist,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error${snapshot.hasError}"),
            );
          } else if (snapshot.hasData) {
            final fetchdata = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) {
                final data = fetchdata[index];
                return ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(image: NetworkImage(data.userImageURL!),fit: BoxFit.cover)
                    ),
                  ),
                  title: Text(data.likes?.toString() ??""),
                                   subtitle:  Text(data.views?.toString() ??""),

                );
              },
            );
          } else {
            return Center(
              child: Text("No data"),
            );
          }
        },
      ),
    );
  }
}
