
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/post_providers.dart';
import '../../providers/profile_providers.dart';

class PostPage extends StatefulWidget {
   PostPage({super.key,
  required this.name,
  required this.dop,
  required this.sr,
  required this.amount,
  required this.dor,
  required this.imgUrl,
  required this.postUserId,
  });
  String name;
  String dop;
  String sr;
  String amount;
  String dor;
  String imgUrl;
  String postUserId;
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {


  

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UserController1>(context);
    final controller1 = Provider.of<UserController>(context);
    return Card(
      margin: const EdgeInsets.all(12),
      surfaceTintColor: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
      
              children: [
              Image.network(widget.imgUrl,height: 180,
               width: 200,),
      
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("Item: ${widget.name}"),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("Date of Purchase: ${widget.dop}"),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("Sell/Rent: ${widget.sr}"),
                ),
                const SizedBox(height: 4),
                widget.dop == "Rent" ?
                Column(
                  children:[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text("Amount: ${widget.amount}"),
                  ),
                  const SizedBox(height: 4),
                  ],
                )
                    :
      
      
                  Column(
                    children:[



                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("mode of rent: ${widget.dor}"),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Amount: ${widget.amount}"),
                      ),


                      const SizedBox(height: 4),
                    ],
                  ),
      
                const SizedBox(height: 10,),
      
                TextButton(
                    onPressed: (){
                      controller.request(widget.postUserId,controller1.name,controller1.number);
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ChatPage()),
                      // );
                    },
                    child: const Text("I'm Interested")),
      
      
      
      
      
      
      
      
      
      
      
              ],
            ),
    );



  }
}
