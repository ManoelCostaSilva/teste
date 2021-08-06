import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/Breeds.dart';
import 'model/BreedsModel.dart';
import 'model/BreedsModelImage.dart';
import 'model/Favorite.dart';
import 'widget/texto.dart';
import 'package:get/get.dart';

class BreedFavorite extends StatefulWidget {
  @override
  _AdmPedidosState createState() => _AdmPedidosState();
}

class _AdmPedidosState extends State<BreedFavorite> {
  static List<Favorites> favorites = [];
  var breedsName='';
  dynamic lists;

  @override
  void dispose() {
    super.dispose();
  }

  Future<dynamic> geBreeds() async {
    String url='https://dog.ceo/api/breeds/list/all';

    final response = await http.get(
        Uri.parse(url)
    );

    final list = await breedsFromJson(response.body);
    lists = list;
    lists.message!.forEach( (breeds, favorite) {
      try{
        var stringList = favorite.join("#");
        if(stringList.toString().length>0) {
          getImage(breeds,stringList);
        }
      } catch (e) {
        print(e);

      }
      },
    );
    setState(() {});
  }

  getImage(String breeds,String favorite)async{
    String url='https://dog.ceo/api/breed/'+breeds+'/images';

    final response = await http.get(
        Uri.parse(url)
    );

    final list = await imageFromJson(response.body);
    lists = list;
    int c=0;
    String field=breeds + '-' +favorite;
    for (int i = 0; i < lists.message!.length; i++) {
      if(lists.message[i].toString().contains(field) && c<=4) {
        print(field+'====='+ lists.message[i]+' * '+c.toString());
        favorites.add(Favorites(breeds,favorite,lists.message[i]));
        c++;
      }
    }
  }

  @override
  void initState() {
    geBreeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:Texto(tit:'Dreeds '+breedsName,cor: Colors.white,),
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
                                Text(favorites[index].img.toString()),
                                ]
                          ),



/*
                          child:Container(
                            width: 80,
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:NetworkImage(breedsFields[index].name.toString()),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(100))
                            ),
                          ),

 */

                        ),
                    );
                  }),
            ),
          ],
        )
    );
  }
}