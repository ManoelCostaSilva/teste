import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/Breeds.dart';
import 'model/BreedsModel.dart';
import 'model/BreedsModelImage.dart';
import 'widget/texto.dart';
import 'package:get/get.dart';

class BreedImage extends StatefulWidget {
  @override
  _AdmPedidosState createState() => _AdmPedidosState();
}

class _AdmPedidosState extends State<BreedImage> {
  static List<BreedsFields> breedsFields = [];
  var breedsName='';
  dynamic lists;

  @override
  void dispose() {
    super.dispose();
  }

  Future<dynamic> geBreeds() async {
    breedsName =Get.arguments['imgName'] ?? null;
    String url='https://dog.ceo/api/breed/'+breedsName+'/images';

    final response = await http.get(
        Uri.parse(url)
    );

    final list = await imageFromJson(response.body);
    lists = list;
    breedsFields.clear();
    for (int i = 0; i < lists.message!.length; i++) {
      breedsFields.add(BreedsFields(lists.message[i]));
    }
   // print(lists.message[0]);
    //lists.message!.keys.forEach((k) => breedsFields.add(BreedsFields(k)));

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
        title:Texto(tit:'Dreeds '+breedsName,cor: Colors.white,),
      ),

        body: Column(
          children: <Widget>[
            Expanded(
              child:ListView.builder(
                  shrinkWrap: true,
                  itemCount: breedsFields.length,
                  itemBuilder: (context, index) {

                    return InkWell(
                      onTap: () {},
                      child:Padding(
                          padding: EdgeInsets.only(top: 10,bottom: 10,left:15,right: 8),
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
                        ),
                    );
                  }),
            ),
          ],
        )
    );
  }
}