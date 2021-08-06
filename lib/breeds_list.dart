import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'breeds_favorite.dart';
import 'breeds_image.dart';
import 'model/Breeds.dart';
import 'model/BreedsModel.dart';
import 'widget/texto.dart';
import 'package:get/get.dart';

class BreedList extends StatefulWidget {
  @override
  _AdmPedidosState createState() => _AdmPedidosState();
}

class _AdmPedidosState extends State<BreedList> {
  static List<BreedsFields> breedsFields = [];

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
        title:Texto(tit:'Dreeds List ',cor: Colors.white,),
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
                        //Get.to(() => BreedImage(), arguments: {'imgName':breedsFields[index].name.toString()});
                        Get.to(() => BreedFavorite(), arguments: {'imgName':breedsFields[index].name.toString()});

                      },
                      child:Card(
                        elevation:6,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey, width: 0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10,bottom: 10,left:15,right: 8),
                          child:Texto(tit:breedsFields[index].name.toString(), tam: 12.0 ,),
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