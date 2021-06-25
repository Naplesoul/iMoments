import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'galleryShow.dart';
import 'dart:math';
import 'package:imoments/theme.dart';
import 'package:imoments/userInfo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class GalleryPage extends StatefulWidget {
  @override
  GalleryPageState createState() => new GalleryPageState();
}

class GalleryPageState extends State<GalleryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _imageCounter = -1;
  int number = 0;
  var loadTimes = 0;
  var ran = new Random();
  List<Image> _images = [];
  List<int> _imageNumbers = [];
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  var headerColor = currentTheme;

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () {
      _imageCounter = -1;
      _imageNumbers.clear();
      _images.clear();
      loadTimes = 0;
      this.setState(() {

      });
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () {
      loadTimes++;
      this.setState(() {

      });
    });
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.photo_library),
        title: Text(
          'Gallery',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30.0,
              //color: Colors.black,
              semanticLabel: 'search',
            ),
            onPressed: () {
              showSearch(context: context, delegate: SearchBar());
            },
          ),
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(waterDropColor: Colors.black,),
        footer: ClassicFooter(idleText: "加载更多", loadStyle: LoadStyle.ShowWhenLoading,),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: StaggeredGridView.countBuilder(
          padding: EdgeInsets.all(4.0),
          crossAxisCount: 3,
          itemCount: 51*(loadTimes+1),
          itemBuilder: (context, index) {
            if(index ~/ 50 > _imageCounter) {
              number = ran.nextInt(1500) + 1;
              List<Image> _moreImages = List<Image>.generate(
                50, (i) => Image.network(
                gallery_url + 'resource/img/3/${number + 10 * i}.jpg',
                fit: BoxFit.cover,
              ),
              );
              List<int> _theNumbers = List<int>.generate(50, (i) => number + 10 * i);

              _images.addAll(_moreImages);
              _imageNumbers.addAll(_theNumbers);

              _imageCounter++;
            }

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return GalleryShowPage(index: index , total: 51*(loadTimes + 1), imageNumbers: _imageNumbers,);
                  },
                ));
              },
              child: _images[index],
            );
          },
          staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(index % 18 == 0 || index % 18 == 10 ? 2 : 1, index % 18 == 0 || index % 18 == 10 ? 2 : 1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class SearchBar extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        },
        );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      //todo: add search results
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      //todo: search suggestions
      child: Center(
        child: Text('suggestions'),
      )
    );
  }
}