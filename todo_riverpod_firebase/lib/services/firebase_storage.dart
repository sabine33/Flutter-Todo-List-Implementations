import '/services/storage_interface.dart';
import 'firebase_storage_service.dart';

Future<StorageServiceInterface> initializeFirebase() async {
  StorageServiceInterface firebaseStorageService =
      await FirebaseStorageService.initialize();
  return firebaseStorageService;
}
