import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:task/data/model/result_model.dart';
import 'package:task/data/server/api_call.dart';

class MoviesDetails extends StatelessWidget {
  const MoviesDetails({Key? key, required this.id}) : super(key: key);
  final int? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text('Details Movie'),
      backgroundColor: Colors.blueGrey,),
      body: FutureBuilder<ResultModel?>(
        future: ApiCall().getPopularDetailesData(),
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.hasData) {
            print(snapshot.connectionState);
            print(snapshot.data!.title);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://image.tmdb.org/t/p/original/${snapshot.data!.posterPath}',
                    placeholder: (context, url) => const Center(
                        child: SizedBox(
                      width: 100,
                      height: 250,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballBeat,
                        strokeWidth: 1,
                        colors: [Colors.redAccent, Colors.black, Colors.white],
                      ),
                    )),
                    errorWidget: (context, url, error) => const Image(
                      image: AssetImage('assets/images/step.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('${snapshot.data!.title}'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('${snapshot.data!.overview}'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('${snapshot.data!.adult}'),
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
