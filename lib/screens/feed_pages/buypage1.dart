import 'package:buyrent/screens/feed_pages/postpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class BuyPageUser extends StatefulWidget {
  const BuyPageUser({super.key});

  @override
  State<BuyPageUser> createState() => _BuyPageUserState();
}

class _BuyPageUserState extends State<BuyPageUser> {



  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Post").where("userId" ,isEqualTo: uid).snapshots(),
        builder: (context,snapshot) {

            return snapshot.hasData?snapshot.data!.docs.isEmpty?const Center(child: Text("No products available"),):ListView.builder(
              itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                final data = snapshot.data!.docs[index];
              return PostPage(
                name: data["name"],
                amount:data["amount"] ,
                dop: data["dop"],
                dor: data["dor"],
                imgUrl: data["imageURL"],
                sr: data["sr"],
                postUserId: data["userId"],

              );
    }
            ):const CircularProgressIndicator();

        }

      ),
    );
  }
}
