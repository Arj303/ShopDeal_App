import 'dart:io';
import 'package:buyrent/screens/home/feed_home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/post_providers.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  String? _selectedDate;
  String? _selectedValue;
  String _selectedTime="";

  List<String> _values = ['Sell', 'Rent'];
  List<String> _times = ['Weekly', 'Monthly', 'Yearly'];
  var inputFormat = DateFormat('dd/MM/yyyy');

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = inputFormat.format(picked).toString();
      });
      print(_selectedDate);
    }
  }

  String? img;






  final TextEditingController name1 = TextEditingController();
  final TextEditingController amount1 = TextEditingController();






  @override
  Widget build(BuildContext context) {
    final controller1 = Provider.of<UserController1>(context);
    final controller2 = Provider.of<UserController1>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0095FF),
        title: Text(
          "Post",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              img == null
                  ? SizedBox(
                width: 8.0,
              )
                  : Image.network(img!),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.camera);
                      print('${file?.path}');

                      if (file == null) return;
                      String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                      referenceRoot.child('images');

                      //Create a reference for the image to be stored
                      Reference referenceImageToUpload =
                      referenceDirImages.child(uniqueFileName + ".png");

                      //Handle errors/success
                      try {
                        //Store the file
                        await referenceImageToUpload.putFile(File(file.path));
                        //Success: get the download URL
                        var imageUrl =
                        await referenceImageToUpload.getDownloadURL();

                        print(imageUrl);
                        setState(() {
                          img = imageUrl;
                        });
                      } catch (error) {
                        print(error);
                      }
                    },
                    child: Text("press")),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Name of Item:",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: name1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("name"),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Date of Purchase:',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      child: Text(
                        _selectedDate == null
                            ? "select a date"
                            : _selectedDate!,
                        textAlign: TextAlign.center,
                      ),
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                    )),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sell/Rent:',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  width: 200,
                  child: DropdownButtonFormField<String>(
                    value: _selectedValue,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _selectedValue = value;
                        _selectedValue.toString();
                      });
                    },
                    items: _values.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select Option',
                    ),
                  ),
                ),
              ),
              _selectedValue == "Rent"
                  ? Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Amount:",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: amount1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Rs"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        value: _selectedTime,
                        onChanged: (value) {
                          setState(() {
                            _selectedTime = value!;
                            _selectedTime.toString();
                          });
                          print(_selectedTime);
                        },
                        items: _times.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Select Option',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            controller1.addUser1(name: name1.text,dop: _selectedDate.toString(),sr: _selectedValue,amount: amount1.text,dor: _selectedTime,imgUrl: img);
                            controller1.fetchData1();
                            controller2.fetchData1();
                            // BuyPage();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => FeedPage()),
                            );

                          }, child: Text("Submit")),
                    ),
                  ],
                ),
              )
                  : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Amount:",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: amount1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Rs"),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {

                            controller1.addUser1(name: name1.text,dop: _selectedDate.toString(),sr: _selectedValue,amount: amount1.text,dor: _selectedTime,imgUrl: img);
                            controller1.fetchData1();
                            controller2.fetchData1();
                            // BuyPage();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => FeedPage()),
                            );
                          },
                          child: Text("Submit")),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }





}