import 'package:firebase_performance/firebase_performance.dart';

class FirestoreReadWriteTracker {
  static final performance = FirebasePerformance.instance;

  static void start() {
    performance.newTrace("firestore_read_write_tracker");
  }
}
