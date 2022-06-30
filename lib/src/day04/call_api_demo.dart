import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:social_api/models/random_user.dart';

import 'download_img_demo.dart';

class CallApiDemoPage extends StatefulWidget {
  const CallApiDemoPage({Key? key}) : super(key: key);

  @override
  _CallApiDemoPageState createState() => _CallApiDemoPageState();
}

class _CallApiDemoPageState extends State<CallApiDemoPage>
    with DownloadImgMixinStateful {
  final urlString = 'https://randomuser.me/api/?results=10';
  Future<List<RandomUser>?>? _value;
  final double sizeAvatar = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call API Demo'),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Center(
          //     child: ElevatedButton(
          //       // onPressed: _useDio,
          //       onPressed: _useHttp,
          //       // onPressed: _useFutureBuilder,
          //       child: const Text('Call API'),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                // onPressed: _useDio,
                onPressed: () {
                  downloadImg('Ahihihihihi',
                      'https://randomuser.me/api/portraits/men/75.jpg');
                },
                child: const Text('Download'),
              ),
            ),
          ),
          FutureBuilder<List<RandomUser>?>(
            // future: _getUsers(),
            future: _value,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong!!!');
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        final user = snapshot.data![index];
                        return ListTile(
                          title: Text(
                            user.displayName,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          leading: Container(
                            width: sizeAvatar,
                            height: sizeAvatar,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: user.avatarUrl,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data?.length ?? 0,
                    ),
                  );
                }
                return const Text('Empty data');
              }
              return Text('State: ${snapshot.connectionState}');
            },
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  Future<void> _useDio() async {
    try {
      final res = await Dio().get(urlString);

      _value =
          res.data['results'].map((json) => RandomUser.fromJson(json)).toList();
      debugPrint('_value=$_value');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // ignore: unused_element
  Future<void> _useHttp() async {
    try {
      final res = await http.get(Uri.parse(urlString));

      final users = jsonDecode(res.body)['results']
          .map((json) => RandomUser.fromJson(json))
          .toList();
      debugPrint('users=$users');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // ignore: unused_element
  Future<void> _useFutureBuilder() async {
    _value = _getUsers();
    setState(() {});
  }

  Future<List<RandomUser>?> _getUsers() async {
    try {
      final res = await Dio().get(urlString);

      return (res.data['results'] as List)
          .map((json) => RandomUser.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
