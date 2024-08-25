import 'package:flutter/material.dart';
import 'login_form.dart';
import 'signup_form.dart';

class LoginSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Biodata Maker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFFb27409), // AppBar color to match the theme
        elevation: 0, // Remove AppBar shadow to keep it flat
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30), // Space from AppBar
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFb27409), width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      'Banner Image',
                      style: TextStyle(
                        color: Colors.grey[400], // Light grey color
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'learn more  →',
                        style: TextStyle(
                          color: Color(0xFFb27409),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40), // Space between banner and buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginForm()),
                );
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFb27409),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.0),
                minimumSize: Size(240, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 14), // Adjust spacing between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupForm()),
                );
              },
              child: Text('Signup'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFFb27409),
                side: BorderSide(color: Color(0xFFb27409), width: 1.5),
                padding: EdgeInsets.symmetric(vertical: 10.0),
                minimumSize: Size(240, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 150), // Space between buttons and product section
            Text(
              'Our Product',              
              style: TextStyle(
                color: Color(0xFFb27409),
                fontWeight: FontWeight.bold,    
                fontSize: 22 ,
              ),
            ),
            SizedBox(height: 20), // Space between text and product images
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProductImage('assets/images/SVG.png'),
                SizedBox(width: 10),
                _buildProductImage('assets/images/SVG.png'),
                SizedBox(width: 10),
                _buildProductImage('assets/images/SVG.png'),
                SizedBox(width: 10),
                _buildProductImage('assets/images/SVG.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String imagePath) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
