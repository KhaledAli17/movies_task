import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:task/data/model/move_trend_model.dart';
import 'package:task/data/server/api_call.dart';
import 'package:task/ui/screens/details.dart';

class TrendMoviesData extends StatefulWidget {
  const TrendMoviesData({Key? key}) : super(key: key);

  @override
  State<TrendMoviesData> createState() => _TrendMoviesDataState();
}

class _TrendMoviesDataState extends State<TrendMoviesData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Trending Movies'),
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder<MovieTrends?>(
        future: ApiCall().getTrendData(),
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
                                            builder: (context) => MoviesDetails(
                                                  id: snapshot
                                                      .data!.results![index].id,
                                                )));
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
                                            indicatorType: Indicator.ballBeat,
                                            strokeWidth: 1,
                                            colors: [
                                              Colors.redAccent,
                                              Colors.black,
                                              Colors.white
                                            ],
                                          ),
                                        )),
                                        errorWidget: (context, url, error) =>
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
                                        '${snapshot.data!.results![index].name}',
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
      ),
    );
  }
}
