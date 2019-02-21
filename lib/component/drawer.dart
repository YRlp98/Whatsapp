import 'package:flutter/material.dart';
import 'package:whatsapp/pages/map_screen.dart';
import 'package:whatsapp/pages/third_map_screen.dart';

Drawer buildDrawerLayout(BuildContext context) {
  return new Drawer(
    child: new ListView(
      children: <Widget>[
        new DrawerHeader(
            padding: EdgeInsets.zero,
            child: new Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(colors: <Color>[
                const Color(0xff075e54),
                const Color(0xff05433c)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: new Stack(
                children: <Widget>[
                  new Align(
                      alignment: Alignment.bottomRight,
                      child: new Padding(
                        padding: const EdgeInsets.only(right: 16, bottom: 16),
                        child: Text(
                          'مجله آموزشی اقا یوسف!',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      )),
                  new Align(
                    alignment: Alignment.topRight,
                    child: new ListTile(
                      leading: new CircleAvatar(
                        backgroundImage: new NetworkImage(
                            'https://avatars2.githubusercontent.com/u/25505523?s=460&v=4'),
                      ),
                      title: new Text(
                        'یوسف روشندل',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )),
        new ListTile(
          trailing: new Text(
            '5',
            style: TextStyle(color: Color(0xFFFF3800), fontSize: 20),
          ),
          leading: new Icon(
            Icons.shopping_basket,
            color: const Color(0xff00D054),
          ),
          title: new Text(
            'سبد خرید',
            style: TextStyle(color: const Color(0xff00D054)),
          ),
          onTap: () {},
        ),
        new ListTile(
          trailing: new Text('278'),
          leading: new Icon(
            Icons.shopping_cart,
          ),
          title: new Text(
            'محصولات',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        new ListTile(
          trailing: new Text('17'),
          leading: new Icon(
            Icons.favorite,
          ),
          title: new Text(
            'مورد علاقه',
          ),
          onTap: () {},
        ),
        new ListTile(
          leading: new Icon(
            Icons.location_on,
          ),
          title: new Text(
            'گوگل مپ',
          ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => MapScreen()));
          },
        ),
        new ListTile(
          leading: new Icon(
            Icons.map,
          ),
          title: new Text(
            'مپ باکس',
          ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => SecondMapScreen()));
          },
        ),
        new ListTile(
          leading: new Icon(
            Icons.call,
          ),
          title: new Text(
            'پشتیبانی',
          ),
          onTap: () {},
        ),
      ],
    ),
  );
}
