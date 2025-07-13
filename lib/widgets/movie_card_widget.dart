import 'package:flutter/material.dart';
import 'package:movie_show_tracker/models/movie.dart';
import 'package:movie_show_tracker/screens/movie_page.dart';

class MovieCardWidget extends StatelessWidget {
  final Movie data;
  const MovieCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: 170,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                data.posterImg,
                fit: BoxFit.cover,
                // frameBuilder: ,
              ),
            ),
            SizedBox(height: 10),
            Text(
              data.title,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      // onLongPress: () {
      //   print("Add this");
      // },
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MoviePage(movieId: data.id)),
      ),
    );
  }
}
