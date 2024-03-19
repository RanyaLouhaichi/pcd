import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserProfileScreen extends StatefulWidget {
  final String username;
  final String email;

  const UserProfileScreen({Key? key, required this.username, required this.email}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool _isEditing = false;
  Map<String, dynamic>? _userData;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }


  void _fetchUserData() async {
    try {
      Map<String, dynamic>? userData = await _firestoreService.getUserDataByUsername(widget.username);
      if (userData != null) {
        setState(() {
          _userData = userData;
          _nameController.text = userData['username'] ?? '';
          _addressController.text = userData['address'] ?? '';
          _emailController.text = widget.email;
        });
      } else {
        print('User data not found');
        // Set _userData to an empty map
        _userData = {};
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Your Profile',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey[200],
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.username,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildTextField('Name', _nameController, Icons.person),
            _buildTextField('Address', _addressController, Icons.location_on),
            _buildTextField('Email', _emailController, Icons.email),
            SizedBox(height: 20),
            _isEditing ? _buildSaveButton() : _buildEditButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      readOnly: !_isEditing,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget _buildEditButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isEditing = true;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
      ),
      child: Text(
        'Edit Profile',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isEditing = false;
              _saveUserData();
            });
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
          child: Text(
            'Save',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 20),
        TextButton(
          onPressed: () {
            setState(() {
              _resetFields();
              _isEditing = false;
            });
          },
          style: TextButton.styleFrom(
            primary: Colors.black,
          ),
          child: Text('Cancel'),
        ),
      ],
    );
  }

  void _resetFields() {
    _nameController.text = _userData?['name'] ?? '';
    _addressController.text = _userData?['address'] ?? '';
    _emailController.text = widget.email;
  }

  void _saveUserData() async {
    try {
      // Check if the user data exists
      if (_userData != null) {
        await _firestoreService.updateUserData(
          widget.username, // Use the username as the document ID
          name: _nameController.text.trim(),
          address: _addressController.text.trim(),
          email: _emailController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User data saved successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        // User data does not exist, create a new document for the user
        print('User data not found. Creating a new document...');
        await _firestoreService.createUserData(
          name: _nameController.text.trim(),
          address: _addressController.text.trim(),
          email: _emailController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('New user data created successfully'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      print('Error saving user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error saving user data: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }




}
