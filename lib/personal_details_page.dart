import 'package:flutter/material.dart';
import 'education_occupation_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PersonalDetailsPage extends StatefulWidget {
  final Map<String, String>? initialValues;

  PersonalDetailsPage({this.initialValues});

  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;

  late final TextEditingController biodataTitleController;

  late final List<Map<String, dynamic>> _fields;

  final List<String> days = List<String>.generate(31, (index) => (index + 1).toString());
  final List<String> months = List<String>.generate(12, (index) => (index + 1).toString());
  final List<String> years = List<String>.generate(100, (index) => (2023 - index).toString());

  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;

  @override
  void initState() {
    super.initState();

    biodataTitleController = TextEditingController(
      text: widget.initialValues?['Biodata Title'] ?? "|| Shree Ganeshaya Namah ||",
    );

    _fields = [
      {'label': 'Full Name', 'controller': TextEditingController(text: widget.initialValues?['Full Name'] ?? '')},
      {'label': 'Caste', 'controller': TextEditingController(text: widget.initialValues?['Caste'] ?? '')},
      {'label': 'Sub-caste', 'controller': TextEditingController(text: widget.initialValues?['Sub-caste'] ?? '')},
      {'label': 'Birth Date', 'controller': null}, // This will be handled separately
      {'label': 'Birth Time', 'controller': TextEditingController(text: widget.initialValues?['Birth Time'] ?? '')},
      {'label': 'Birth Place', 'controller': TextEditingController(text: widget.initialValues?['Birth Place'] ?? '')},
      {'label': 'Height', 'controller': TextEditingController(text: widget.initialValues?['Height'] ?? '')},
      {'label': 'Blood Group', 'controller': TextEditingController(text: widget.initialValues?['Blood Group'] ?? '')},
      {'label': 'Devak/Gotra', 'controller': TextEditingController(text: widget.initialValues?['Devak/Gotra'] ?? ''), 'moveable': true},
      {'label': 'Complexion', 'controller': TextEditingController(text: widget.initialValues?['Complexion'] ?? ''), 'moveable': true},
    ];

    selectedDay = widget.initialValues?['Day'];
    selectedMonth = widget.initialValues?['Month'];
    selectedYear = widget.initialValues?['Year'];
  }

  Widget _buildTextField(String label, TextEditingController? controller, {int? index}) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $label';
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

  Widget _buildBirthdayField() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Date'),
            value: selectedDay,
            items: days.map((String day) {
              return DropdownMenuItem<String>(
                value: day,
                child: Text(day),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedDay = newValue;
              });
            },
            validator: (value) => value == null ? 'Select Day' : null,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Month'),
            value: selectedMonth,
            items: months.map((String month) {
              return DropdownMenuItem<String>(
                value: month,
                child: Text(month),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedMonth = newValue;
              });
            },
            validator: (value) => value == null ? 'Select Month' : null,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Year'),
            value: selectedYear,
            items: years.map((String year) {
              return DropdownMenuItem<String>(
                value: year,
                child: Text(year),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedYear = newValue;
              });
            },
            validator: (value) => value == null ? 'Select Year' : null,
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
        MaterialPageRoute(builder: (context) => EducationOccupationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(  // Center the title
          child: Text(
            'Create Biodata',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold, // Make the text bold
              color: Colors.white, // Set the text color to white
            ),
          ),
        ),
        backgroundColor: Color(0xFFB27409),
          leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Personal Details Title with Arrows on Both Sides
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xFFB27409)),
                    onPressed: _navigateToPreviousPage,
                  ),
                  Text(
                    'Personal Details',
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
              // Biodata Title
              Center(
                child: Text(
                  'Biodata Title',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: biodataTitleController,
                decoration: InputDecoration(),
                textAlign: TextAlign.center, // Center the text inside the text field
              ),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey[700])
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildTextField('Full Name', _fields[0]['controller']),
              SizedBox(height: 10),
              _buildTextField('Caste', _fields[1]['controller']),
              SizedBox(height: 10),
              _buildTextField('Sub-caste', _fields[2]['controller']),
              SizedBox(height: 10),
              _buildBirthdayField(),
              SizedBox(height: 10),
              _buildTextField('Birth Time', _fields[4]['controller']),
              SizedBox(height: 10),
              _buildTextField('Birth Place', _fields[5]['controller']),
              SizedBox(height: 10),
              _buildTextField('Height', _fields[6]['controller']),
              SizedBox(height: 10),
              _buildTextField('Blood Group', _fields[7]['controller']),
              SizedBox(height: 10),
              for (int i = 8; i < _fields.length; i++) _buildTextField(_fields[i]['label'], _fields[i]['controller'], index: i),
              SizedBox(height: 10),
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
                child: Text('+ Add New Field',),
                
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                    child: Text('Save and Continue',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
