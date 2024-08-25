import 'package:flutter/material.dart';
import 'family_details_page.dart'; // Import the FamilyDetailsPage

class EducationOccupationPage extends StatefulWidget {
  @override
  _EducationOccupationPageState createState() => _EducationOccupationPageState();
}

class _EducationOccupationPageState extends State<EducationOccupationPage> {
  final _formKey = GlobalKey<FormState>();

  late final List<Map<String, dynamic>> _fields;

  @override
  void initState() {
    super.initState();

    _fields = [
      {'label': 'Education Level', 'controller': TextEditingController()},
      {'label': 'Education', 'controller': TextEditingController()},
      {'label': 'Occupation', 'controller': TextEditingController()},
      {'label': 'Annual Income', 'controller': TextEditingController()},
    ];
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

  Widget _buildTextField(Map<String, dynamic> field, int index) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: field['controller'],
            decoration: InputDecoration(
              labelText: field['label'],
              border: UnderlineInputBorder(),  // Use an underline instead of a box
              contentPadding: EdgeInsets.only(bottom: 5),  // Adjust padding as needed
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter ${field['label']}';
              }
              return null;
            },
          ),
        ),
        SizedBox(width: 10),
        if (index != 0) // Exclude 'Education Level' from move/delete buttons
          Row(
            children: [
              GestureDetector(
                onPanUpdate: (details) {
                  // Logic to handle drag and drop movement
                },
                child: Icon(
                  Icons.drag_indicator,
                  color: Color(0xFFB27409), // Match the drag handle color from the image
                  size: 24,
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red, size: 24),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB27409),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(  // Center the title
          child: Text(
            'Create Biodata',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold, // Make the text bold
              color: Colors.white, // Set the text color to white
            ),
          ),
        ),
        centerTitle: true, // Center the "Create Biodata" text
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Personal Details Title with Arrows on Both Sides
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xFFB27409)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Education And Occupation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Decreased font size
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward, color: Color(0xFFB27409)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FamilyDetailsPage()), // Route to FamilyDetailsPage
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _fields.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        _buildTextField(_fields[index], index),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FamilyDetailsPage()), // Route to FamilyDetailsPage
                    );
                  }
                },
                child: Text('Save and Continue'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFB27409),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(325, 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
