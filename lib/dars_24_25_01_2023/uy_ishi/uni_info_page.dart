import 'package:dars_20_01_2023_firebase/dars_24_25_01_2023/uy_ishi/university_model.dart';
import 'package:flutter/material.dart';

class UniInfoPage extends StatelessWidget {
  UniversityModel uni;
  UniInfoPage({Key? key, required this.uni}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Image.network(uni.image, fit: BoxFit.cover,),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(uni.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                    IconButton(
                        onPressed: (){}, icon: Icon(Icons.favorite_border)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Divider(thickness: 2,),
                ),
                Row(
                  children: [
                    Text("Logo:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                    SizedBox(width: 32,),
                    Container(
                      height: 50,
                      width: 50,
                      child: ClipOval(child: Image.network(uni.logo, fit: BoxFit.cover,),),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Divider(thickness: 2,),
                ),
                Text("📍 ${uni.location}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                SizedBox(height: 16,),
                Text("Tuition fee for international students: \$${uni.fee}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                SizedBox(height: 16,),
                Text("World Rank: ${uni.rank}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Divider(thickness: 2,),
                ),
                Text("Contacts:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                SizedBox(height: 16,),
                Text("Website: ${uni.website}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                SizedBox(height: 16,),
                Text("Phone number: ${uni.phone}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(24)
                    ),
                    child: Icon(Icons.arrow_back),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(24)
                  ),
                  child: Text("Apply now", style: TextStyle(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500, fontSize: 18),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
