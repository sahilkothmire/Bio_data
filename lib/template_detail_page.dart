import 'package:flutter/material.dart';
import 'dart:io';

class TemplateDetailPage extends StatefulWidget {
  final List<String> imagePaths; // List of image paths to use for each template
  final List<UserDetails> userDetails; // List of user details for each template

  TemplateDetailPage({required this.imagePaths, required this.userDetails});

  @override
  _TemplateDetailPageState createState() => _TemplateDetailPageState();
}

class _TemplateDetailPageState extends State<TemplateDetailPage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Template Details'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              itemCount: widget.imagePaths.length, // Number of templates
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return _buildTemplate(widget.imagePaths[index], widget.userDetails[index]);
              },
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
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildTemplate(String imagePath, UserDetails userDetails) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              image: DecorationImage(
                image: AssetImage('assets/frame.png'), // Placeholder frame image
                fit: BoxFit.cover,
              ),
            ),
            height: 300,
            width: double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.file(
                    File(imagePath), // Display the user's image
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${userDetails.name}\n${userDetails.bio}', // Display user details
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.imagePaths.length, (index) {
        return _buildIndicator(index);
      }),
    );
  }

  Widget _buildIndicator(int pageIndex) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      width: _currentPage == pageIndex ? 12.0 : 8.0,
      height: _currentPage == pageIndex ? 12.0 : 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == pageIndex ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class UserDetails {
  final String name;
  final String bio;
  // Add other fields as necessary

  UserDetails({required this.name, required this.bio});
}
