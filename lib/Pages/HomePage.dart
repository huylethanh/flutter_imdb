import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_imdb/Pages/MovieDetailPage.dart';
import 'package:flutter_imdb/Providers/SearchProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  int _currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black.withOpacity(0.5)),
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.amber[700]),
                      decoration: InputDecoration(
                        focusColor: Colors.amber[700],
                        hintText: 'Search by name',
                        hintStyle: TextStyle(
                            color: Colors.amber[700].withOpacity(0.4)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.amber[700]),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _currentPage = 1;
                      Provider.of<SearchProvider>(context, listen: false)
                          .search(textSearch: _controller.text);
                    },
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Consumer<SearchProvider>(
                  builder: (context, provider, _) {
                    if (provider.searches == null) {
                      return Container();
                    }

                    if (provider.searches.length == 0) {
                      return Container(
                        child: Text(
                          "Not found",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 36),
                        ),
                      );
                    }

                    return Container(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (!provider.canLoadMore) {
                            return true;
                          }

                          if (!provider.isLoading &&
                              notification.metrics.pixels >=
                                  notification.metrics.maxScrollExtent) {
                            Provider.of<SearchProvider>(context, listen: false)
                                .search(
                                    textSearch: _controller.text,
                                    page: ++_currentPage);
                            return false;
                          }

                          return true;
                        },
                        child: ListView.separated(
                          itemCount: !provider.isLoading
                              ? provider.searches.length
                              : provider.searches.length + 1,
                          itemBuilder: (context, index) {
                            if (provider.isLoading) {
                              if (index > provider.searches.length - 1) {
                                return ListTile(
                                  title: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Loading...",
                                      style:
                                          TextStyle(color: Colors.amber[700]),
                                    ),
                                  ),
                                );
                              }
                            }

                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Hero(
                                  tag:
                                      'hero ${provider.searches[index].imdbID}',
                                  child: Image(
                                    image: NetworkImage(
                                        provider.searches[index].poster),
                                  ),
                                ),
                              ),
                              title: Text(
                                provider.searches[index].title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MovieDetailPage(
                                            provider.searches[index].imdbID)));
                              },
                              subtitle: Row(
                                children: [
                                  Text(
                                    'Year: ${provider.searches[index].year}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Type: ${provider.searches[index].type}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
