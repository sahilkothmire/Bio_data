import 'package:bio_data_maker/template_selection_page.dart';
import 'package:flutter/material.dart';

class OtherDetailsPage extends StatefulWidget {
  @override
  _OtherDetailsPageState createState() => _OtherDetailsPageState();
}

class _OtherDetailsPageState extends State<OtherDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _fields = [];

  @override
  void initState() {
    super.initState();
    _fields.addAll([
      {'label': 'Email', 'controller': TextEditingController()},
      {'label': 'Contact', 'controller': TextEditingController()},
      {'label': 'Property', 'controller': TextEditingController()},
      {'label': 'Expectations', 'controller': TextEditingController()},
    ]);
  }

  Widget _buildTextField(String label, TextEditingController controller, {int? index}) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
          ),
        ),
        if (index != null) // Show move and delete buttons only for movable fields
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_upward, color: Colors.blueGrey),
                onPressed: () {
                  setState(() {
                    if (index > 0) {
                      final temp = _fields[index];
                      _fields[index] = _fields[index - 1];
                      _fields[index - 1] = temp;
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_downward, color: Colors.blueGrey),
                onPressed: () {
                  setState(() {
                    if (index < _fields.length - 1) {
                      final temp = _fields[index];
                      _fields[index] = _fields[index + 1];
                      _fields[index + 1] = temp;
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _fields.removeAt(index);
                  });
                },
              ),
            ],
          ),
      ],
    );
  }

  void _addNewField() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController fieldNameController = TextEditingController();
        return AlertDialog(
          title: Text('Add New Field'),
          content: TextFormField(
            controller: fieldNameController,
            decoration: InputDecoration(hintText: 'Enter field name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _fields.add({
                    'label': fieldNameController.text,
                    'controller': TextEditingController(),
                    'moveable': true,
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToPreviousPage() {
    // Logic for navigating to the previous page
  }

  void _navigateToNextPage() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TemplateSelectionPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Biodata',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
            color: Colors.white, // Set the text color to white
          ),
        ),
        backgroundColor: Color(0xFFB27409), 
         leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
           onPressed: () {
            Navigator.pop(context);
          },
        ),// Set the app bar color to #B27409
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Other Details Title with Arrows on Both Sides
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xFFB27409)),
                    onPressed: _navigateToPreviousPage,
                  ),
                  Text(
                    'Other Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // Increase font size
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward, color: Color(0xFFB27409)),
                    onPressed: _navigateToNextPage,
                  ),
                ],
              ),
              SizedBox(height: 20),
              for (int i = 0; i < _fields.length; i++)
                _buildTextField(_fields[i]['label'], _fields[i]['controller'], index: i),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFFB27409),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(325, 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _addNewField,
                child: Text('+ Add New Field'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFB27409),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(325, 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _navigateToNextPage,
                child: Text('Save and Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
