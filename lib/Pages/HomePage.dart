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
                      Provider.of<SearchProvider>(context, listen: false)
                          .search(_controller.text);
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
                      child: ListView.separated(
                        itemCount: provider.searches.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    provider.searches[index].poster),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  'Type: ${provider.searches[index].type}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey,
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
