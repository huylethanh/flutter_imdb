import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_imdb/Models/MovieDetail.dart';
import 'package:flutter_imdb/Services/ImdbSevice.dart';
import 'package:flutter_imdb/Widgets/CustomVerticalDivider.dart';

class MovieDetailPage extends StatefulWidget {
  final String imdbID;

  MovieDetailPage(this.imdbID);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  Future<MovieDetails> _futureMovieDetail;

  @override
  void initState() {
    super.initState();
    _futureMovieDetail = ImdbService().getDetail(widget.imdbID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[700],
        title: Text('Details'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: _futureMovieDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                MovieDetails detail = snapshot.data;
                return createContent(detail);
              }

              return Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.amber[700],
                      strokeWidth: 2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Data is loading...'),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget createContent(MovieDetails details) {
    return Container(
      child: Column(children: [
        Container(
          color: Colors.grey[850],
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(children: [
            createTitle(details),
            createPoster(details),
          ]),
        ),
        createPlotContent(details),
      ]),
    );
  }

  Widget createTitle(MovieDetails details) {
    return Column(children: [
      Row(
        // first row
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            details.title,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            '(${details.year})',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          Spacer(),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber[700],
                ),
              ),
              CustomVerticalDivider(
                color: Colors.grey[400],
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        details.imdbRating,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        '/10',
                        style: TextStyle(color: Colors.grey[600], fontSize: 10),
                      )
                    ],
                  ),
                  Text(
                    details.imdbVotes,
                    style: TextStyle(color: Colors.grey[400], fontSize: 10),
                  ),
                ],
              )
            ],
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        // second row
        children: [
          Text(
            details.rated,
            style: TextStyle(color: Colors.grey[400], fontSize: 10),
          ),
          CustomVerticalDivider(color: Colors.grey[400], height: 10),
          Text(
            details.runtime,
            style: TextStyle(color: Colors.grey[400], fontSize: 10),
          ),
          CustomVerticalDivider(color: Colors.grey[400], height: 10),
          Text(
            details.genre,
            style: TextStyle(color: Colors.grey[400], fontSize: 10),
          ),
          CustomVerticalDivider(color: Colors.grey[400], height: 10),
          Text(
            details.released,
            style: TextStyle(color: Colors.grey[400], fontSize: 10),
          ),
        ],
      )
    ]);
  }

  Widget createPoster(MovieDetails details) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Image(
          image: NetworkImage(details.poster),
        ),
      ),
    );
  }

  Widget createPlotContent(MovieDetails details) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        Text(
          details.plot,
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Text(
              'Director:',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              details.director,
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Write:',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                details.writer,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stars:',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                details.actors,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
