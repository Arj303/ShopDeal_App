
import 'package:buyrent/screens/feed_pages/postpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/profile_providers.dart';

class BuyPage extends StatefulWidget {
  const BuyPage({super.key});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {

  @override
  void initState() {
    Provider.of<UserController>(context,listen: false).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final uid=FirebaseAuth.instance.currentUser!.uid;
    final controller=Provider.of<UserController>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome ${controller.name}"),
        ),
        body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Post").where("userId",isNotEqualTo: uid).snapshots(),
          builder: (context, snapshot) {

            return snapshot.hasData?snapshot.data!.docs.isEmpty?const Center(child: Text("No products available"),):ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data=snapshot.data!.docs[index];
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
          },
        )



      );

  }
}
