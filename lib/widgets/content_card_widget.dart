import 'package:flutter/material.dart';
import 'package:movie_show_tracker/models/media.dart';
import 'package:movie_show_tracker/screens/movie_page.dart';
import 'package:movie_show_tracker/screens/show_page.dart';

class ContentCardWidget extends StatelessWidget {
  final Media data;
  final bool isMovie;
  const ContentCardWidget({
    super.key,
    required this.data,
    required this.isMovie,
  });

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
                data.poster,
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
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              (isMovie) ? MoviePage(id: data.id) : ShowPage(id: data.id),
        ),
      ),
    );
  }
}
