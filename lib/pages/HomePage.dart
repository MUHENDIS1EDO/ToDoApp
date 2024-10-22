import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_todo/Service/Auth_Service.dart';
import 'package:mobile_app_todo/pages/AddTodo.dart';
import 'package:mobile_app_todo/pages/TodoCard.dart';
import 'package:mobile_app_todo/pages/profile.dart';
import 'package:mobile_app_todo/pages/view_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();

  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();
  List<Select> selected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Gunun Takvimi",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/logo.png"),
          ),
          SizedBox(
            width: 15,
          ),
        ],
        bottom: AppBar(
          backgroundColor: Colors.black87,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatCurrentTime().toString(),
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(221, 39, 32, 32),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ElevatedButton(
              onPressed: () {},
              child: SizedBox(
                height: 32,
                width: 32,
                child: Icon(
                  Icons.home,
                  size: 32,
                  color: Color.fromARGB(221, 39, 32, 32),
                ),
              ),
            ),
            label: "Ana Sayfa",
          ),
          BottomNavigationBarItem(
            icon: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddTodoPage()),
                );
              },
              child: SizedBox(
                height: 32,
                width: 32,
                child: Icon(
                  Icons.add,
                  size: 32,
                  color: Color.fromARGB(221, 39, 32, 32),
                ),
              ),
            ),
            label: "Not Ekle",
          ),
          BottomNavigationBarItem(
            icon: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
              child: SizedBox(
                height: 32,
                width: 32,
                child: Icon(
                  Icons.settings,
                  size: 32,
                  color: Color.fromARGB(221, 39, 32, 32),
                ),
              ),
            ),
            label: "Ayarlar",
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              IconData iconData;
              Color iconColor;
              Map<String, dynamic> document =
                  snapshot.data?.docs[index].data() as Map<String, dynamic>;
              switch (document["Category"]) {
                case "Yemek":
                  iconData = Icons.local_grocery_store;
                  iconColor = Colors.red;
                  break;
                case "Okul":
                  iconData = Icons.school;
                  iconColor = Colors.teal;
                  break;
                case "Tasarim":
                  iconData = Icons.design_services;
                  iconColor = Colors.green;
                  break;
                case "Seyahat":
                  iconData = Icons.travel_explore;
                  iconColor = Colors.blue;
                  break;
                case "Spor":
                  iconData = Icons.sports_football;
                  iconColor = Colors.pink;
                  break;
                default:
                  iconData = Icons.run_circle_outlined;
                  iconColor = Colors.blue;
              }
              selected.add(
                  Select(id: snapshot.data!.docs[index].id, checkValue: false));
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => ViewData(
                        document: document,
                        id: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                },
                child: TodoCard(
                  title: document["title"] == null
                      ? "Hey There"
                      : document["title"],
                  iconData: iconData,
                  iconColor: iconColor,
                  time: "",
                  check: selected[index].checkValue,
                  iconBgColor: Colors.white,
                  index: index,
                  onChange: onChange,
                ),
              );
            },
          );
        },
      ),
    );
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }
}

String _formatCurrentTime() {
  return DateFormat('EEEE, dd').format(DateTime.now());
}

class Select {
  String id;
  bool checkValue = false;
  Select({required this.id, required this.checkValue});
}
