import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'breeds_favorite.dart';
import 'breeds_image.dart';
import 'model/Breeds.dart';
import 'model/BreedsModel.dart';
import 'model/BreedsModelImage.dart';
import 'model/Favorite.dart';
import 'widget/texto.dart';
import 'package:get/get.dart';

class BreedList extends StatefulWidget {
  @override
  _AdmPedidosState createState() => _AdmPedidosState();
}

class _AdmPedidosState extends State<BreedList> {
  static List<BreedsFields> breedsFields = [];
  static List<Favorites> favorites = [];
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
    dynamic lists = list;

    breedsFields.clear();
    lists.message!.keys.forEach((k) => breedsFields.add(BreedsFields(k)));

    setState(() {});
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
          centerTitle: true,
          title:Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Texto(tit:'Dreeds List ',cor: Colors.white,),

                    Transform.translate(
                      offset: Offset(15, 0),
                      child:IconButton(
                        color: Colors.white, icon: new Icon(Icons.settings,),
                        onPressed: () {
                          goToFavorites();
                          },
                      ),
                    ),
                  ],
                ),
              ]
          ),
        ),

        body: Column(
          children: <Widget>[
            Expanded(
              child:ListView.builder(
                  shrinkWrap: true,
                  itemCount: breedsFields.length,
                  itemBuilder: (context, index) {

                    return InkWell(
                      onTap: () {
                        Get.to(() => BreedImage(), arguments: {'imgName':breedsFields[index].name.toString()});
                      },
                      child:Card(
                        elevation:6,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey, width: 0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10,bottom: 10,left:15,right: 8),
                          child:Texto(tit:breedsFields[index].name.toString(), tam: 18.0 ,),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        )
    );
  }

  goToFavorites()async{
    await getFavorites();
    //Get.offAll(() => UserTermo(), arguments: {'tipo':'doar'});
    Get.to(() => BreedFavorite(), arguments: {'favorites':favorites});
  }
  Future<dynamic> getFavorites() async {
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
    },);
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
        favorites.add(Favorites(breeds,favorite,lists.message[i]));
        c++;
      }
    }
  }

}