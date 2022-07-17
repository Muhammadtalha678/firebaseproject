import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: 
   DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    //  home: Mycrud(fullName: "bshadwq",company: "hwsgdhwqsabx",age: 1,documentID: "lHVizkRXW8J6Kt5m2Wal"),
    home: MyShow(documentID: "lHVizkRXW8J6Kt5m2Wal"),
    );
  }
}
class MyShow extends StatelessWidget {
   
  final String documentID;
  const MyShow({Key? key,required this.documentID}) : super(key: key);
 
  
  @override
  Widget build(BuildContext context) {
      CollectionReference users = FirebaseFirestore.instance.collection("users");
  //     Future<void> add()async {
  //     users.add(
  //       {
  //         "name" : fullName,
  //         "company" : company,
  //         "age" : age,
  //       }
  //     ).then((value) => print("added sucessfully"));
  // }
  // Async snapshot ka mtlb ha data arbhi rha ha or ni bh arha ha yani(?) js ki waja sy ham data!(nul safty ni lagaty)
 
   return Scaffold(
    //  body: FutureBuilder(
    //   future: users.doc(documentID).get(),
    //   builder: (BuildContext context,AsyncSnapshot snapshot){
    //     if(snapshot.hasError){print("Error");}
    //     if(snapshot.hasData){
    //       Map<String,dynamic>  data = snapshot.data.data() as Map<String,dynamic>;
    //       return Center(
    //         child: Text(data['name']),
    //       );
    //     }
    //     return Center(child: CircularProgressIndicator(),);
    //  }),
    body: FutureBuilder<QuerySnapshot>(
      future: users.get(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document){
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['name']),
            );
          }).toList(),
        );
      }),
   );
  }
}