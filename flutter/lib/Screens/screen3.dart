import 'package:camoa/components/container.dart';
import 'package:flutter/material.dart';

class Textsuggest extends StatefulWidget {
  const Textsuggest({super.key});

  @override
  State<Textsuggest> createState() => _TextsuggestState();
}

class _TextsuggestState extends State<Textsuggest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Noise & Texture.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Here is some matching Typography",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Containercustom(
                          height: 600,
                          width: 400, imageUrl: '',
                        ),
                        SizedBox(width: 16),
                        Containercustom(
                          height: 600,
                          width: 400, imageUrl: '',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
