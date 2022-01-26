import '/services/storage_interface.dart';
import 'firebase_storage_service.dart';

late StorageServiceInterface firebaseStorageService;

Future<void> initializeFirebase() async {
  firebaseStorageService = await FirebaseStorageService.initialize();
}
