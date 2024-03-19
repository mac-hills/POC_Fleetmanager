import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> fetchReservationIds() async {
  List<String> ids = [];
  // Reference to the 'reservation' collection
  CollectionReference<Map<String, dynamic>> reservationRef =
      FirebaseFirestore.instance.collection('reservation');
  try {
    // Get the reservation data
    QuerySnapshot<Map<String, dynamic>> reservationSnapshot =
        await reservationRef.get();
    // Check if there are any documents in the collection
    if (reservationSnapshot.docs.isNotEmpty) {
      // Reservation data found
      // Loop through the documents and add their IDs to the 'ids' list
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in reservationSnapshot.docs) {
        ids.add(doc.id);
      }
    }
  } catch (error) {
    print('Error fetching reservation IDs: $error');
    // Handle errors here
  }
  return ids;
}
