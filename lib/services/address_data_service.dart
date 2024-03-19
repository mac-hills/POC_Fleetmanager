import 'package:cloud_firestore/cloud_firestore.dart';

class AddressService {
  Future<Map<String, dynamic>> fetchAddressData(String addressId) async {
    // Get address data
    DocumentSnapshot addressSnapshot = await FirebaseFirestore.instance
        .collection('address')
        .doc(addressId)
        .get();
    if (!addressSnapshot.exists) {
      return {};
    }
    Map<String, dynamic> addressData =
        addressSnapshot.data() as Map<String, dynamic>;
    return addressData;
  }
}
