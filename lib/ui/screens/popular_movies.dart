import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:task/data/model/popular.dart';
import 'package:task/data/server/api_call.dart';
import 'package:task/ui/screens/details.dart';

class PopularMoviesData extends StatefulWidget {
  const PopularMoviesData({Key? key}) : super(key: key);

  @override
  State<PopularMoviesData> createState() => _PopularMoviesDataState();
}

class _PopularMoviesDataState extends State<PopularMoviesData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Popular Movies'),
        backgroundColor: Colors.blueGrey,
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return FutureBuilder<PopularMovies?>(
              future: ApiCall().getPopularData(),
              builder: (context, snapshot) {
                print(snapshot.connectionState);
                if (snapshot.hasData) {
                  print(snapshot.connectionState);
                  print(snapshot.data!.results);
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.results!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MoviesDetails(
                                                          id: snapshot
                                                              .data!
                                                              .results![index]
                                                              .id)));
                                        },
                                        child: Column(
                                          children: [
                                            CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/original/${snapshot.data!.results![index].posterPath}',
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child: SizedBox(
                                                width: 100,
                                                height: 250,
                                                child: LoadingIndicator(
                                                  indicatorType:
                                                      Indicator.ballBeat,
                                                  strokeWidth: 1,
                                                  colors: [
                                                    Colors.redAccent,
                                                    Colors.black,
                                                    Colors.white
                                                  ],
                                                ),
                                              )),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Image(
                                                image: AssetImage(
                                                    'assets/images/step.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${snapshot.data!.results![index].title}',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return Center(child: const CircularProgressIndicator());
              },
            );
          } else {
            return Center(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 30,
                    ),
                    Image(image: AssetImage('assets/images/warning.png')),
                    Text(
                      'Check your Internet',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
