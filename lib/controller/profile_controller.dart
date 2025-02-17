import 'package:anuplal/app/models/profile_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../app/services/api_services.dart';

class ProfileController extends GetxController implements GetxService {
  final ApiService apiService = ApiService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  XFile? _pickedImage;

  XFile? get pickedImage => _pickedImage;

   User _profile = User(
    phoneVerified: false,
    emailVerified: false,
    isActive: false,
    profilePhoto: '',
    dateOfBirth: '',
    id: 0,
    name: '',
    phone: '',
  );

   User get profile => _profile;

  void pickImage({required bool isRemove}) async {
    if (isRemove) {
      _pickedImage = null;
    } else {
      _pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    update();
  }

  Future<void> getProfileInfo(ProfileController profile) async {
    dynamic fetchedProducts = await apiService.fetchProfileDetails(profile);
  }

  void setProfile(User user) {
    _profile = user;
    update();
  }

  Future<void> UpdateProfileInfo(ProfileController profile) async {
    dynamic fetchedProducts = await apiService.fetchProfileDetails(profile);
  }

}
