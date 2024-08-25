import 'package:flutter/material.dart';
import 'personal_details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showBannerImage = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleMenuItemClick(String value) {
    switch (value) {
      case 'share':
        // Handle share app action
        break;
      case 'products':
        // Handle our products action
        break;
      case 'delete':
        // Handle delete account action
        break;
      case 'logout':
        // Handle logout action
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Biodata Maker',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xFFb27409),
         leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
           onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _handleMenuItemClick,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'share',
                  child: Text('Share App'),
                ),
                PopupMenuItem(
                  value: 'products',
                  child: Text('Our Products'),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete Account'),
                ),
                PopupMenuItem(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
            icon: Icon(Icons.menu, color: Colors.white), // Change icon to three straps
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          tabs: [
            Tab(text: 'English'),
            Tab(text: 'Hindi'),
            Tab(text: 'Bengali'),
            Tab(text: 'Gujarati'),
            Tab(text: 'Kannada'),
            Tab(text: 'Marathi'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Adjust padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PersonalDetailsPage()),
                      );
                    },
                    icon: Icon(Icons.brush),
                    label: Text('Create Biodata'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFb27409),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _showBannerImage = false;
                      });
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add Sample'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFb27409),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40), // Adjust height to move down the buttons
            _showBannerImage
                ? Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFb27409)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(child: Text('Banner Image')),
                        Positioned(
                          bottom: 10,
                          child: Text(
                            'Learn more →',
                            style: TextStyle(
                              color: Color(0xFFb27409),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : _buildSampleBio(), // Display sample bio when the banner is hidden
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {
            // Action for FAB
          },
          backgroundColor: Color(0xFFb27409),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: SizedBox(
        height: 30,
      ),
    );
  }

  Widget _buildSampleBio() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/dummy.jpeg'),
                radius: 30,
              ),
              title: Text(
                'pratik patil',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Cast : Hindu DOB : 01-07-1993'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Action to create or edit biodata
                },
                child: Text('Create'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFFb27409),
                  side: BorderSide(color: Color(0xFFb27409)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBioOptionButton(Icons.edit, 'Edit', () {
                  // Edit the dummy bio
                }),
                _buildBioOptionButton(Icons.copy, 'Copy', () {
                  // Copy the dummy bio details
                }),
                _buildBioOptionButton(Icons.delete, 'Delete', () {
                  // Delete the dummy bio
                }),
                _buildBioOptionButton(Icons.file_copy, 'Template', () {
                  // Change the template of the dummy bio
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBioOptionButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.grey[700]),
          onPressed: onPressed,
        ),
        Text(label, style: TextStyle(color: Colors.grey[700])),
      ],
    );
  }
}
