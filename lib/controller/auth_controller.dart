import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  var profileImage = Rx<File?>(null); // Stores the selected profile image

  Future<void> pickProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var conformPasswordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final RxBool isFirstNameValid = true.obs;

  final TextEditingController middleNameController = TextEditingController();
  final RxBool isMiddleNameValid = true.obs;

  final TextEditingController lastNameController = TextEditingController();
  final RxBool islastNameValid = true.obs;

  // filepath: e:\Mechodal\Registration Page\register_app\lib\controller\auth_controller.dart
  final TextEditingController address1Controller = TextEditingController();
  final RxBool isAddress1Valid = true.obs;

  final TextEditingController address2Controller = TextEditingController();
  final RxBool isAddress2Valid = true.obs;

  final TextEditingController address3Controller = TextEditingController();
  final RxBool isAddress3Valid = true.obs;

  // filepath: e:\Mechodal\Registration Page\register_app\lib\controller\auth_controller.dart
  final TextEditingController mobileNumberController = TextEditingController();
  final RxBool isMobileNumberValid = true.obs;

  final TextEditingController altMobileNumberController =
      TextEditingController();
  final RxBool isAltMobileNumberValid = true.obs;

  final TextEditingController officeNameController = TextEditingController();
  final RxBool isOfficeNameValid = true.obs;

  final TextEditingController officeAddressController = TextEditingController();
  final RxBool isOfficeAddressValid = true.obs;

  final TextEditingController officeNumberController = TextEditingController();
  final RxBool isOfficeNumberValid = true.obs;

  final TextEditingController officeEmailController = TextEditingController();
  final RxBool isOfficeEmailValid = true.obs;

  var selectedCountry = ''.obs; // Stores the selected country
  var isCountryValid = true.obs; // Validation flag for country
  var isEmailValid = true.obs;
  var isPasswordValid = true.obs;
  var isConformPasswordValid = true.obs;
  var selectedGender = ''.obs; // Stores the selected gender
  var isGenderValid = true.obs;
  // Validation flag for gender
  var selectedState = ''.obs; // Stores the selected state
  var isStateValid = true.obs; // Validation flag for state

  var selectedCity = ''.obs; // Stores the selected city
  var isCityValid = true.obs; // Validation flag for city
  var selectedHobbies = <String>[].obs; // Stores selected hobbies
  var isHobbiesValid = true.obs;
  var isProfileImageValid = true.obs;

  void signup() {
    String firstName = firstNameController.text.trim();
    String lastName = firstNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String conformPassword = conformPasswordController.text.trim();

    if (firstName.isEmpty) {
      isFirstNameValid.value = false;
    } else {
      isFirstNameValid.value = true;
    }

    if (profileImage.value == null) {
      isProfileImageValid.value = false;
    } else {
      isProfileImageValid.value = true;
    }

    if (selectedCountry.value.isEmpty) {
      isCountryValid.value = false;
    } else {
      isCountryValid.value = true;
    }

    if (selectedHobbies.isEmpty) {
      isHobbiesValid.value = false;
    } else {
      isHobbiesValid.value = true;
    }

    if (selectedGender.value.isEmpty) {
      isGenderValid.value = false;
    } else {
      isGenderValid.value = true;
    }

    if (lastName.isEmpty) {
      islastNameValid.value = false;
    } else {
      islastNameValid.value = true;
    }

    if (address1Controller.text.trim().isEmpty) {
      isAddress1Valid.value = false;
    } else {
      isAddress1Valid.value = true;
    }

    if (address2Controller.text.trim().isEmpty) {
      isAddress2Valid.value = false;
    } else {
      isAddress2Valid.value = true;
    }

    if (address3Controller.text.trim().isEmpty) {
      isAddress3Valid.value = false;
    } else {
      isAddress3Valid.value = true;
    }

    if (selectedState.value.isEmpty) {
      isStateValid.value = false;
    } else {
      isStateValid.value = true;
    }

    if (selectedCity.value.isEmpty) {
      isCityValid.value = false;
    } else {
      isCityValid.value = true;
    }

    if (mobileNumberController.text.trim().isEmpty ||
        !RegExp(r'^[0-9]{10}$').hasMatch(mobileNumberController.text.trim())) {
      isMobileNumberValid.value = false;
    } else {
      isMobileNumberValid.value = true;
    }

    if (altMobileNumberController.text.trim().isNotEmpty &&
        !RegExp(
          r'^[0-9]{10}$',
        ).hasMatch(altMobileNumberController.text.trim())) {
      isAltMobileNumberValid.value = false;
    } else {
      isAltMobileNumberValid.value = true;
    }

    if (email.isEmpty || !email.isEmail) {
      isEmailValid.value = false;
    } else {
      isEmailValid.value = true;
    }

    if (officeNameController.text.trim().isEmpty) {
      isOfficeNameValid.value = false;
    } else {
      isOfficeNameValid.value = true;
    }

    if (officeAddressController.text.trim().isEmpty) {
      isOfficeAddressValid.value = false;
    } else {
      isOfficeAddressValid.value = true;
    }

    if (officeNumberController.text.trim().isEmpty ||
        !RegExp(r'^[0-9]{10}$').hasMatch(officeNumberController.text.trim())) {
      isOfficeNumberValid.value = false;
    } else {
      isOfficeNumberValid.value = true;
    }

    if (officeEmailController.text.trim().isEmpty ||
        !officeEmailController.text.trim().isEmail) {
      isOfficeEmailValid.value = false;
    } else {
      isOfficeEmailValid.value = true;
    }

    if (password.isEmpty || password.length < 6) {
      isPasswordValid.value = false;
    } else {
      isPasswordValid.value = true;
    }

    if (conformPassword != password) {
      isConformPasswordValid.value = false;
    } else {
      isConformPasswordValid.value = true;
    }

    if (isFirstNameValid.value &&
        islastNameValid.value &&
        isAddress1Valid.value &&
        isAddress2Valid.value &&
        isAddress3Valid.value &&
        isMobileNumberValid.value &&
        isAltMobileNumberValid.value &&
        isOfficeNameValid.value &&
        isOfficeAddressValid.value &&
        isOfficeNumberValid.value &&
        isCountryValid.value &&
        isStateValid.value && // Include state validation
        isCityValid.value &&
        isOfficeEmailValid.value &&
        isEmailValid.value &&
        isProfileImageValid.value &&
        isPasswordValid.value &&
        isConformPasswordValid.value &&
        isHobbiesValid.value &&
        isGenderValid.value) {
      // Perform login action
      firstNameController.clear();
      middleNameController.clear();
      lastNameController.clear();
      mobileNumberController.clear();
      altMobileNumberController.clear();
      address1Controller.clear();
      address2Controller.clear();
      address3Controller.clear();
      emailController.clear();
      selectedHobbies.clear();
      officeNameController.clear();
      officeAddressController.clear();
      officeNumberController.clear();
      officeEmailController.clear();
      selectedState.value = ''; // Reset state after successful signup
      selectedCity.value = '';
      passwordController.clear();
      selectedGender.value = '';
      selectedCountry.value = '';
      conformPasswordController.clear();
      profileImage.value = null;
      Get.snackbar(
        "Success",
        "Signup successful",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Error",
        "Please check your credentials",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      final response = await post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': emailController.value.text,
          'password': passwordController.value.text,
        },
      );

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("Login successful: ${data['token']}");
        Get.snackbar(
          "Success",
          "Login successful",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        print("Login failed: ${data['error']}");
        Get.snackbar(
          "Error",
          "Invalid email or password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error: $e");
    }

    if (email.isEmpty || !email.isEmail) {
      isEmailValid.value = false;
    } else {
      isEmailValid.value = true;
    }

    if (password.isEmpty || password.length < 6) {
      isPasswordValid.value = false;
    } else {
      isPasswordValid.value = true;
    }

    // if (isEmailValid.value && isPasswordValid.value) {
    //   // Perform login action
    //   emailController.clear();
    //   passwordController.clear();
    //   Get.snackbar(
    //     "Success",
    //     "Login successful",
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.green,
    //     colorText: Colors.white,
    //   );
    // } else {
    //   Get.snackbar(
    //     "Error",
    //     "Invalid email or password",
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //   );
    // }
  }
}
