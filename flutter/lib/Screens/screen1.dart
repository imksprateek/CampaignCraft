import 'package:camoa/Screens/screen2.dart';
import 'package:flutter/material.dart';

List<String> images = [
  "https://s3.amazonaws.com/hecker-bucket/03012f2b-aa71-44c2-974c-8d1efa0e812f",
  "https://s3.amazonaws.com/hecker-bucket/073e873f-1bc8-41f2-85e5-6f6114b13b9f",
  "https://s3.amazonaws.com/hecker-bucket/08dfdbfd-d7b5-410a-9401-8fd1337f3848",
  "https://s3.amazonaws.com/hecker-bucket/10cdfa9b-9e86-4183-af65-5564dd71727e",
  "https://s3.amazonaws.com/hecker-bucket/21b57f76-ac40-4422-a523-10a222892d5c",
  "https://s3.amazonaws.com/hecker-bucket/4a4168f3-7384-4ede-8aa1-ac3d9c205fab",
  "https://s3.amazonaws.com/hecker-bucket/52dfe6a7-e498-46d8-ae42-0d713bc8d173",
  "https://s3.amazonaws.com/hecker-bucket/5e904127-1c8e-4fc1-8850-6c552d63226d",
];

TextEditingController searchbarController = TextEditingController();
late String test = 'kedar';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
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
                SizedBox(height: 140),
                Center(
                  child: Text(
                    "The Gen-AI Based Solution For Your",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Text(
                  "Campaigning Needs",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: 720,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: searchbarController,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            // fetchCurrentImage(searchbarController.text.toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Imagesgenerated()));
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        hintText: '   Enter Your Idea ..',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  test,
                  style: TextStyle(color: Colors.white),
                ),
                Center(
                  child: Text(
                    "User Generated Ideas and Campaigns",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: GridView.count(
                      crossAxisCount: 4, // 4 items per row
                      shrinkWrap: true, // Let GridView fit the available space
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 30,
                      children: List.generate(images.length, (index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.error,
                                color: Colors.red,
                              );
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Add some space below the grid
              ],
            ),
          ),
        ),
      ),
    );
  }
}
