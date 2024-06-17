import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/utils/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../utils/date_util.dart';
import '../../../../../utils/networking_util.dart';
import '../../../../../widgets/snackbar_widget.dart';

class EditProfileController extends GetxController {
  final UserRepository _userRepository;

  EditProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final etFullName = TextEditingController();
  final etPhoneNumber = TextEditingController();
  final etEmail = TextEditingController();
  final etHeight = TextEditingController();
  final etWeight = TextEditingController();
  final etBirthDate = TextEditingController();

  final _countryCode = "".obs;

  String get countryCode => _countryCode.value;

  final _gender = ''.obs;

  String get gender => _gender.value;

  final _profilePictureUrlOrPath = ''.obs;

  String get profilePictureUrlOrPath => _profilePictureUrlOrPath.value;

  final _isLoadPictureFromPath = false.obs;

  bool get isLoadPictureFromPath => _isLoadPictureFromPath.value;

  final _isGenderFemale = false.obs;

  bool get isGenderFemale => _isGenderFemale.value;

  final _isFormValid = true.obs;

  final ImagePicker _picker = ImagePicker();

  XFile? _image;

  XFile? get image => _image;

  bool get isFormValid => _isFormValid.value;

  void setFormValidity(String value) {
    if (value.isEmpty || int.parse(value) <= 0) {
      _isFormValid.value = false;
    } else {
      _isFormValid.value = true;
    }
  }

  DateTime birthDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    loadUserFromServer();
    formValidity();
  }

  void loadUserFromServer() async {
    try {
      final response = await _userRepository.getUser();
      if (response.status == 0) {
        final localUser = response.data;
        etFullName.text = localUser.name;
        etPhoneNumber.text = localUser.phone;
        etEmail.text = localUser.email ?? '';
        etHeight.text = localUser.height?.toString() ?? '';
        etWeight.text = localUser.weight?.toString() ?? '';

        _countryCode.value = localUser.countryCode;

        _profilePictureUrlOrPath.value = localUser.profilePicture ?? '';
        _isLoadPictureFromPath.value = false;

        _gender.value = localUser.gender ?? '';
        if (gender.isNullOrEmpty || gender == 'laki_laki') {
          onChangeGender(false);
        } else {
          onChangeGender(true);
        }

        etBirthDate.text = '';
        if (localUser.dateOfBirth.isNullOrEmpty == false) {
          birthDate = DateUtil.getDateFromShortServerFormat(localUser.dateOfBirth!);
          etBirthDate.text = DateUtil.getBirthDate(birthDate);
        }
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      error.printError();
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  void changeImage(bool isCamera) async {
    //TODO: Implement change profile image

    if (isCamera == true) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _image = image;
        _profilePictureUrlOrPath.value = image.path.toString();
      }
    } else {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _image = image;
        _profilePictureUrlOrPath.value = image.path.toString();
      }
    }
  }

  void onChangeGender(bool isFemale) {
    if (isFemale) {
      _gender.value = 'perempuan';
    } else {
      _gender.value = 'laki_laki';
    }
    _isGenderFemale.value = isFemale;
  }

  void onChangeBirthDate(DateTime dateTime) {
    birthDate = dateTime;
    etBirthDate.text = DateUtil.getBirthDate(birthDate);
  }

  void saveData() async {
    //TODO: Implement edit user API
  }

  void formValidity() {
    if (etFullName.text.isEmpty) {
      _isFormValid.value = false;
    } else if (etEmail.text.isEmpty) {
      _isFormValid.value = false;
    } else if (etEmail.text.isEmpty || !etEmail.text.contains('@') || !etEmail.text.contains('.')) {
      {
        _isFormValid.value = false;
      }
    } else if (int.parse(etHeight.text) <= 0 || int.parse(etWeight.text) <= 0) {
      _isFormValid.value = false;
    }
    _isFormValid.value = true;
  }
}
