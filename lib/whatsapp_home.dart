import 'package:flutter/material.dart';
import 'pages/call_screen.dart';
import 'pages/camera_screen.dart';
import 'pages/chat_screen.dart';
import 'pages/products_screen.dart';
import 'pages/create-chat_screen.dart';
import 'pages/settings_screen.dart';

class WhatsAppHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WhatsAppHomeState();
  }
}

class WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  Map<String, SliverAppBar> appBarList;
  String _currentAppBar = 'mainAppBar';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(initialIndex: 1, length: 4, vsync: this);

    SliverAppBar mainAppBar = SliverAppBar(
      pinned: true,
      floating: true,
      automaticallyImplyLeading: false,
      title: Text('واتس اپ'),
      elevation: 5.0,
      bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(
              text: 'چت ها',
            ),
            Tab(
              text: 'محصولات',
            ),
            Tab(
              text: 'تماس ها',
            )
          ]),
      actions: <Widget>[
        GestureDetector(
          child: Icon(Icons.search),
          onTap: () {
            setState(() {
              _currentAppBar = 'searchAppBar';
            });
          },
        ),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0)),
        PopupMenuButton<String>(onSelected: (String choice) {
          if (choice == 'settings') {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsScreen()));
          } else if (choice == 'new_group') {
//            Navigator.push(context,
//                MaterialPageRoute(builder: (context) => CreateChatScreen()));
//          OR:
            Navigator.pushNamed(context, '/settings');
          }
        }, itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
                value: 'new_group',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[Text('گروه جدید')],
                )),
            PopupMenuItem(
                value: 'settings',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[Text('تنظیمات')],
                )),
          ];
        }),
      ],
    );

    SliverAppBar searchAppBar = new SliverAppBar(
      pinned: true,
      title: TextField(
        decoration:
            InputDecoration(border: InputBorder.none, hintText: 'جستجو...'),
      ),
      elevation: 5.0,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(Icons.arrow_back, color: Color(0xff075e54)),
        ),
        onTap: () {
          setState(() {
            _currentAppBar = 'mainAppBar';
          });
        },
      ),
    );

    appBarList = <String, SliverAppBar>{
      'mainAppBar': mainAppBar,
      'searchAppBar': searchAppBar
    };
  }

  Future<bool> _onWillPop() {
    return showDialog(
            context: context,
            builder: (context) {
              return new AlertDialog(
                title: new Text('Exit?'),
                content: new Text('Press Yes to exit'),
                actions: <Widget>[
                  new FlatButton(onPressed: null, child: new Text('Yes')),
                  new FlatButton(onPressed: null, child: new Text('No')),
                ],
              );
            }) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
        child: new Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[appBarList[_currentAppBar]];
            },
            body: _currentAppBar == 'mainAppBar'
                ? TabBarView(controller: tabController, children: <Widget>[
                    CameraScreen(),
                    ChatScreen(),
                    ProductsScreen(),
                    CallScreen()
                  ])
                : Center(
                    child: Text('Search'),
                  ),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.chat,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CreateChatScreen();
                }));
              }),
        ),
        onWillPop: _onWillPop);
  }
}
