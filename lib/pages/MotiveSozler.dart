import 'package:flutter/material.dart';
import 'package:mobile_app_todo/pages/profile.dart';

class MotiveSozler extends StatefulWidget {
  const MotiveSozler({super.key});

  @override
  State<MotiveSozler> createState() => _MotiveSozlerState();
}

class _MotiveSozlerState extends State<MotiveSozler> {
  final List<String> cumleler = [
    "İnan, başar!",
    "Hayallerinin pesinden git!",
    "Asla pes etme!",
    "Kendine inan!",
    "Mükemmel olmaya calisma, sadece en iyinin en iyisi ol!",
    "Dunyayi değiştirebilirsin!",
    "Senin icin mümkün olan her sey var!",
    "Hayal et, inan, yap!",
    "Bugun harika bir gun olacak!",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Motivasyon"),
      ),
      body: ListView.builder(
        itemCount: cumleler.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.primaries[index % Colors.primaries.length]
                  .withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              cumleler[index],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => Profile()),
                    (route) => false);
              },
              icon: Icon(
                Icons.arrow_left,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
