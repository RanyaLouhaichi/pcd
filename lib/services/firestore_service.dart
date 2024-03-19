import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserDataByEmail(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data();
      } else {
        return null; // Return null if no user found with the provided email
      }
    } catch (e) {
      print('Error fetching user data: $e');
      throw Exception('Failed to fetch user data');
    }
  }

  Future<String?> getUsernameByEmail(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data()['username'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching username: $e');
      throw Exception('Failed to fetch username');
    }
  }

  Future<void> updateUserData(
      String username,
      {String? name, String? address, String? email}) async {
    try {
      await _firestore.collection('users').doc(username).update({
        'name': name,
        'address': address,
        'email': email,
      });
    } catch (e) {
      print('Error updating user data: $e');
      throw e;
    }
  }

  Future<void> createUserData(
      {String? name, String? address, String? email}) async {
    try {
      await _firestore.collection('users').add({
        'name': name,
        'address': address,
        'email': email,
      });
    } catch (e) {
      print('Error creating user data: $e');
      throw e;
    }
  }




  Future<Map<String, dynamic>?> getUserDataByUsername(String username) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data();
      } else {
        return null; // Return null if no user found with the provided username
      }
    } catch (e) {
      print('Error fetching user data: $e');
      throw Exception('Failed to fetch user data');
    }
  }



// Add more methods for CRUD operations or other Firestore interactions as needed
}
