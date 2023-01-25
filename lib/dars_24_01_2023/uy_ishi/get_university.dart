import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_20_01_2023_firebase/dars_24_01_2023/uy_ishi/uni_info_page.dart';
import 'package:dars_20_01_2023_firebase/dars_24_01_2023/uy_ishi/university_model.dart';
import 'package:flutter/material.dart';

class GetUniversity extends StatefulWidget {
  const GetUniversity({Key? key}) : super(key: key);

  @override
  State<GetUniversity> createState() => _GetUniversityState();
}

class _GetUniversityState extends State<GetUniversity> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<UniversityModel> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Universities", style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Color(0xffEBF4F1),
        ),
        body: FutureBuilder(
          future: firestore.collection("university").get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              list.clear();
              snapshot.data?.docs.forEach((element) {
                list.add(UniversityModel.fromJson(element));
              });
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      margin: EdgeInsets.only(top: 32, right: 16, left: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0,10),
                            spreadRadius: 0,
                            blurRadius: 20
                          )
                        ]
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            child: ClipOval(child: Image.network(list[index].logo),),
                          ),
                          SizedBox(width: 16,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(list[index].name, overflow: TextOverflow.ellipsis, maxLines: 1,),
                              SizedBox(height: 8,),
                              Text(list[index].country, overflow: TextOverflow.ellipsis, maxLines: 1,)
                            ],
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: (){}, icon: Icon(Icons.favorite_border)),
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Color(0xffEBF4F1),
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Icon(Icons.arrow_forward, color: Colors.black,),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=> UniInfoPage(uni: list[index],)));
                                },
                              ),
                            ],
                          )

                        ],
                      )
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
