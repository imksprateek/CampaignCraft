import 'package:flutter/material.dart';
import 'package:camoa/components/container.dart'; // Assuming Containercustom is defined here
import 'package:camoa/components/txtbutton.dart';

List<String> images = [
  "https://s3.amazonaws.com/hecker-bucket/03012f2b-aa71-44c2-974c-8d1efa0e812f",
  "https://s3.amazonaws.com/hecker-bucket/073e873f-1bc8-41f2-85e5-6f6114b13b9f",
  "https://s3.amazonaws.com/hecker-bucket/08dfdbfd-d7b5-410a-9401-8fd1337f3848",
  "https://s3.amazonaws.com/hecker-bucket/10cdfa9b-9e86-4183-af65-5564dd71727e",
  "https://s3.amazonaws.com/hecker-bucket/21b57f76-ac40-4422-a523-10a222892d5c",
  "https://s3.amazonaws.com/hecker-bucket/4a4168f3-7384-4ede-8aa1-ac3d9c205fab",
];

class Imagesgenerated extends StatefulWidget {
  const Imagesgenerated({super.key});

  @override
  State<Imagesgenerated> createState() => _ImagesgeneratedState();
}

class _ImagesgeneratedState extends State<Imagesgenerated> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/Noise & Texture.jpg",
              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Centers the row content
                    children: [
                      const Expanded(
                        child: Text(
                          "These are some of the images that might suit your idea",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Textbutton(
                        Inputtext: "Proceed",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Containercustom(imageUrl: images[0], height: 200, width: 240),
                        const SizedBox(width: 16), // Spacing between containers
                        Containercustom(imageUrl: images[1], height: 200, width: 240),
                        const SizedBox(width: 16),
                        Containercustom(imageUrl: images[2], height: 200, width: 240),
                      ],
                    ),
                    const SizedBox(height: 16), // Spacing between rows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Containercustom(imageUrl: images[3], height: 200, width: 240),
                        const SizedBox(width: 16),
                        Containercustom(imageUrl: images[4], height: 200, width: 240),
                        const SizedBox(width: 16),
                        Containercustom(imageUrl: images[5], height: 200, width: 240),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  width: 600,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(89, 255, 255, 255), // Background color of the text field
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.generating_tokens,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
