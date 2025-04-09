import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoware/controller/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Create Account',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Color(0xFF493AD5),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Profile Picture',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF493AD5),
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => authController.pickProfileImage(),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            authController.profileImage.value != null
                                ? FileImage(authController.profileImage.value!)
                                : null,
                        child:
                            authController.profileImage.value == null
                                ? Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[700],
                                  size: 40,
                                )
                                : null,
                      ),
                    ),
                    if (authController.profileImage.value == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Tap to upload your profile picture',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    if (!authController.isProfileImageValid.value)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Please upload a profile picture',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              Obx(
                () => TextField(
                  controller: authController.firstNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Color(0xFF493AD5)),
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isFirstNameValid.value
                            ? null
                            : 'Please enter your first name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: authController.middleNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Color(0xFF493AD5)),
                    labelText: 'Middle Name',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isMiddleNameValid.value
                            ? null
                            : 'Please enter your Middle name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: authController.lastNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Color(0xFF493AD5)),
                    labelText: 'Last Name',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.islastNameValid.value
                            ? null
                            : 'Please enter your Last name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: authController.address1Controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.home, color: Color(0xFF493AD5)),
                    labelText: 'Address 1',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isAddress1Valid.value
                            ? null
                            : 'Please enter your address',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 2, // Makes the text box larger
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: authController.address2Controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.home, color: Color(0xFF493AD5)),
                    labelText: 'Address 2',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isAddress2Valid.value
                            ? null
                            : 'Please enter your address',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 2, // Makes the text box larger
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: authController.address3Controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.home, color: Color(0xFF493AD5)),
                    labelText: 'Address 3',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isAddress3Valid.value
                            ? null
                            : 'Please enter your address',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 2, // Makes the text box larger
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: authController.mobileNumberController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone, color: Color(0xFF493AD5)),
                    labelText: 'Mobile Number',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isMobileNumberValid.value
                            ? null
                            : 'Please enter a valid mobile number',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: authController.altMobileNumberController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone, color: Color(0xFF493AD5)),
                    labelText: 'Alternative Mobile Number',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isAltMobileNumberValid.value
                            ? null
                            : 'Please enter a valid alternative mobile number',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: authController.emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Color(0xFF493AD5)),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isEmailValid.value
                            ? null
                            : 'Please enter a valid email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: authController.officeNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.business, color: Color(0xFF493AD5)),
                    labelText: 'Office Name',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isOfficeNameValid.value
                            ? null
                            : 'Please enter your office name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: authController.officeAddressController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Color(0xFF493AD5),
                    ),
                    labelText: 'Office Address',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isOfficeAddressValid.value
                            ? null
                            : 'Please enter your office address',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 2,
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: authController.officeNumberController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone, color: Color(0xFF493AD5)),
                    labelText: 'Office Number',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isOfficeNumberValid.value
                            ? null
                            : 'Please enter a valid office number',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: authController.officeEmailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Color(0xFF493AD5)),
                    labelText: 'Office Email',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isOfficeEmailValid.value
                            ? null
                            : 'Please enter a valid office email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF493AD5),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text('Male'),
                            value: 'Male',
                            groupValue: authController.selectedGender.value,
                            onChanged: (value) {
                              authController.selectedGender.value = value!;
                              authController.isGenderValid.value = true;
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text('Female'),
                            value: 'Female',
                            groupValue: authController.selectedGender.value,
                            onChanged: (value) {
                              authController.selectedGender.value = value!;
                              authController.isGenderValid.value = true;
                            },
                          ),
                        ),
                      ],
                    ),
                    if (!authController.isGenderValid.value)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Please select your gender',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Country',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF493AD5),
                      ),
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value:
                          authController.selectedCountry.value.isEmpty
                              ? null
                              : authController.selectedCountry.value,
                      items:
                          [
                            'United States',
                            'India',
                            'Canada',
                            'Australia',
                            'United Kingdom',
                            'Germany',
                            'France',
                            'China',
                            'Japan',
                            'Brazil',
                            'South Africa',
                            'Russia',
                            'Mexico',
                            'Italy',
                            'Spain',
                            'South Korea',
                            'Indonesia',
                            'Saudi Arabia',
                            'Turkey',
                            'Argentina',
                          ].map((country) {
                            return DropdownMenuItem<String>(
                              value: country,
                              child: Text(country),
                            );
                          }).toList(),
                      onChanged: (value) {
                        authController.selectedCountry.value = value!;
                        authController.isCountryValid.value = true;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                      ),
                      hint: Text(
                        'Select your country',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    if (!authController.isCountryValid.value)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Please select your country',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'State',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF493AD5),
                      ),
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value:
                          authController.selectedState.value.isEmpty
                              ? null
                              : authController.selectedState.value,
                      items:
                          [
                            'California',
                            'Texas',
                            'New York',
                            'Florida',
                            'Illinois',
                            'Maharashtra',
                            'Karnataka',
                            'Tamil Nadu',
                            'Delhi',
                            'Gujarat',
                          ].map((state) {
                            return DropdownMenuItem<String>(
                              value: state,
                              child: Text(state),
                            );
                          }).toList(),
                      onChanged: (value) {
                        authController.selectedState.value = value!;
                        authController.isStateValid.value = true;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                      ),
                      hint: Text(
                        'Select your state',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    if (!authController.isStateValid.value)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Please select your state',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'City',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF493AD5),
                      ),
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value:
                          authController.selectedCity.value.isEmpty
                              ? null
                              : authController.selectedCity.value,
                      items:
                          [
                            'Los Angeles',
                            'Houston',
                            'Chicago',
                            'Miami',
                            'San Francisco',
                            'Mumbai',
                            'Bangalore',
                            'Chennai',
                            'Delhi',
                            'Ahmedabad',
                          ].map((city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                      onChanged: (value) {
                        authController.selectedCity.value = value!;
                        authController.isCityValid.value = true;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                      ),
                      hint: Text(
                        'Select your city',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    if (!authController.isCityValid.value)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Please select your city',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hobbies',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF493AD5),
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      children: [
                        CheckboxListTile(
                          title: Text('Reading'),
                          value: authController.selectedHobbies.contains(
                            'Reading',
                          ),
                          onChanged: (value) {
                            if (value == true) {
                              authController.selectedHobbies.add('Reading');
                            } else {
                              authController.selectedHobbies.remove('Reading');
                            }
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          title: Text('Traveling'),
                          value: authController.selectedHobbies.contains(
                            'Traveling',
                          ),
                          onChanged: (value) {
                            if (value == true) {
                              authController.selectedHobbies.add('Traveling');
                            } else {
                              authController.selectedHobbies.remove(
                                'Traveling',
                              );
                            }
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          title: Text('Gaming'),
                          value: authController.selectedHobbies.contains(
                            'Gaming',
                          ),
                          onChanged: (value) {
                            if (value == true) {
                              authController.selectedHobbies.add('Gaming');
                            } else {
                              authController.selectedHobbies.remove('Gaming');
                            }
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          title: Text('Cooking'),
                          value: authController.selectedHobbies.contains(
                            'Cooking',
                          ),
                          onChanged: (value) {
                            if (value == true) {
                              authController.selectedHobbies.add('Cooking');
                            } else {
                              authController.selectedHobbies.remove('Cooking');
                            }
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              Obx(
                () => TextField(
                  controller: authController.passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF493AD5)),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isEmailValid.value
                            ? null
                            : 'Password must be at least 6 characters',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: authController.conformPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF493AD5)),
                    labelText: 'Conform Password',
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText:
                        authController.isConformPasswordValid.value
                            ? null
                            : 'Password does not match',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => authController.signup(),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF493AD5),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 24),
              // TextButton(
              //   onPressed: () => Get.to(() => LoginScreen()),
              //   child: Text(
              //     'Already have an account? Login',
              //     style: TextStyle(color: Color.fromARGB(255, 198, 236, 6)),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
