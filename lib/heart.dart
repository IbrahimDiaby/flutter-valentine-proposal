import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  const Heart({super.key});

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _sizeAnimation;
  late double heartSize;

  bool waiting = true;
  bool response = false;
  String text = "";

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 2),
    );
    _sizeAnimation = Tween(begin: 100.0, end: 200.0).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: GestureDetector(
                child: Icon(
                  (waiting) ? Icons.mark_as_unread_sharp : (response) ? Icons.favorite : Icons.heart_broken,
                  size: _sizeAnimation.value,
                  color: (waiting) ? Colors.blue : Colors.red,
                ),
              ),
            ),
            const Text("Will you want to be my valentine ?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      waiting = false;
                      response = true;
                    });
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                    padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
                  ),
                  child: const Text(
                    "Yes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        waiting = false;
                        response = false;
                      });
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                      padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
                    ),
                    child: const Text(
                      "No",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 10,),
            Text((waiting) ? "I'm waiting for your response..." : (response) ? "I LOVE YOU TOO :)" : "YOU BROKE MY HEART :(", style: TextStyle(
              backgroundColor: (response) ? Colors.green : Colors.red,
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
