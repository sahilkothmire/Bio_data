import 'package:flutter/material.dart';

class TemplateSelectionPage extends StatelessWidget {
  // List of image paths for the frames
  final List<String> frames = [
    'assets/images/frame_1.png',
    'assets/images/frame_2.png',
    'assets/images/frame_3.png',
    'assets/images/frame_4.png',
    'assets/images/frame_5.png',
    'assets/images/frame_6.png',
    'assets/images/frame_7.png',
    'assets/images/frame_8.png',
    'assets/images/frame_9.png',
    'assets/images/frame_10.png',
    'assets/images/frame_11.png',
    'assets/images/frame_12.png',
    'assets/images/frame_13.png',
    'assets/images/frame_14.png',
    'assets/images/frame_15.png',
    'assets/images/frame_16.png',
    'assets/images/frame_17.png',
    'assets/images/frame_18.png',
    'assets/images/frame_19.png',
    'assets/images/frame_20.png',
    'assets/images/frame_21.png',
    'assets/images/frame_22.png',
    'assets/images/frame_23.png',
    'assets/images/frame_24.png',
    'assets/images/frame_25.png',
    'assets/images/frame_26.png',
    'assets/images/frame_27.png',
    'assets/images/frame_28.png',
    'assets/images/frame_29.png',
    'assets/images/frame_30.png',
    'assets/images/frame_31.png',
    'assets/images/frame_32.png',
    'assets/images/frame_33.png',
    'assets/images/frame_34.png',
    'assets/images/frame_35.png',
    'assets/images/frame_36.png',
    'assets/images/frame_37.png',
    'assets/images/frame_38.png',
    'assets/images/frame_39.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Template',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
            color: Colors.white, // Set the text color to white
          ),
        ),
        backgroundColor: Color(0xFFB27409), // Set the app bar color to #B27409
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: frames.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to the detailed template view with selected frame
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TemplateDetailPage(imagePath: frames[index]),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  image: DecorationImage(
                    image: AssetImage(frames[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TemplateDetailPage extends StatelessWidget {
  final String imagePath;

  TemplateDetailPage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Template',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
            color: Colors.white, // Set the text color to white
          ),
        ),
        backgroundColor: Color(0xFFB27409), // Set the app bar color to #B27409
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Display the selected frame with the image
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              height: 300,
              width: double.infinity,
              child: Stack(
                children: [
                  // Add the image here, replace with the actual image when data is provided
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/user_image.png', // Placeholder image for user's data
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Add the data like name, biodata, etc. on the template frame
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Biodata Info Here',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle what happens when the template is confirmed
                Navigator.pop(context);
              },
              child: Text('Confirm Template'),
            ),
          ],
        ),
      ),
    );
  }
}
