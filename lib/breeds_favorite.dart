import 'package:flutter/material.dart';
import 'model/Favorite.dart';
import 'widget/texto.dart';
import 'package:get/get.dart';

class BreedFavorite extends StatefulWidget {
  @override
  _AdmPedidosState createState() => _AdmPedidosState();
}

class _AdmPedidosState extends State<BreedFavorite> {
  static List<Favorites> favorites = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    favorites =Get.arguments['favorites'] ?? null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:Texto(tit:'Favorites ',cor: Colors.white,),
      ),

        body: Column(
          children: <Widget>[
            Expanded(
              child:ListView.builder(
                  shrinkWrap: true,
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {

                    return InkWell(
                      onTap: () {},
                      child:Padding(
                          padding: EdgeInsets.only(top: 10,bottom: 10,left:15,right: 8),

                          child:Column(
                              children: <Widget>[
                                Text(favorites[index].breeds.toString()),
                                Text(favorites[index].favorite.toString()),
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:NetworkImage(favorites[index].img.toString()),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(100))
                                  ),
                                ),

                              ]
                          ),

                        ),
                    );
                  }),
            ),
          ],
        )
    );
  }
}