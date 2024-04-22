import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final uid=FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:Text("Chat",style: TextStyle(color: Colors.white),),



      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("request").where("postUserID",isEqualTo:uid ).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data=snapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    title: Text("You have recieved request from ${data["senderName"]}"),
                    subtitle:
                    data["request"]!="accepted" ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(onPressed: ()async{
                          await FirebaseFirestore.instance.collection("request").doc(data["senderId"]).delete();
                        }, child: Text("Reject")),
                      TextButton(onPressed: ()async{
                          print(data["senderNumber"]);
                          await FirebaseFirestore.instance.collection("request").doc(data["senderId"]).update({
                            "request":"accepted"
                          });
                        }, child: Text("Accept")),
                      ],
                    ) : Center(child: Text(data["senderNumber"])),
                  ),
                );
              },
            );
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
