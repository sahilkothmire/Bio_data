import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'home_page.dart';
import 'login_form.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _agreeToTerms = false;
  String? _mobileNumber, _email, _password;
  String _verify = "Verify";

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      _formKey.currentState!.save();

      final dio = Dio();
      const String apiUrl =
          "https://techfluxsolutions.com/royal_maratha/api/register";

      try {
        print('Attempting to connect to: $apiUrl'); // Debug print

        final response = await dio.post(
          apiUrl,
          data: {
            "phone": _mobileNumber,
            "email": _email,
            "password": _password,
            "cpass_status": _verify,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            validateStatus: (status) =>
                true, // This will prevent Dio from throwing errors on non-200 status codes
          ),
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.data}');

        if (response.statusCode == 200) {
          final responseData = response.data;
          if (responseData["response"] == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            _showErrorDialog(responseData['error_msg'] ??
                'Registration failed. Please try again.');
          }
        } else {
          _showErrorDialog(
              'Server error: ${response.statusCode}. ${response.statusMessage}');
        }
      } on DioError catch (e) {
        print('DioError: $e');
        if (e.type == DioErrorType.connectionTimeout) {
          _showErrorDialog(
              'Connection timed out. Please check your internet connection and try again.');
        } else if (e.type == DioErrorType.receiveTimeout) {
          _showErrorDialog(
              'Receive timeout. The server took too long to respond.');
        } else if (e.error is SocketException) {
          _showErrorDialog(
              'Network error. Please check your internet connection and try again.');
        } else {
          _showErrorDialog('An unexpected error occurred: ${e.message}');
        }
      } catch (e) {
        print('Unexpected error: $e');
        _showErrorDialog(
            'An unexpected error occurred. Please try again later.');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Registration Error"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text("Okay"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign up',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Mobile Number';
                  }
                  return null;
                },
                onSaved: (value) => _mobileNumber = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                obscureText: _obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
                onSaved: (value) => _password = value,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _agreeToTerms = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      'I have read and agree to the privacy and terms',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _registerUser,
                child: Text('Sign up'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFb27409),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  minimumSize: Size(240, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginForm()),
                  );
                },
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
