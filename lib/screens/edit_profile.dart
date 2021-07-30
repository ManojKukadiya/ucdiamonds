import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucdiamonds/providers/auth_provider.dart';
import 'package:ucdiamonds/utilities/styles.dart';
import 'package:ucdiamonds/utilities/utility.dart';
import 'package:ucdiamonds/utilities/validators.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController mobileTextEditingController = TextEditingController();
  TextEditingController referralCodeTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        nameTextEditingController.text = provider.userModel.name ?? "";
        mobileTextEditingController.text = provider.userModel.mobile ?? "";
        return Scaffold(
          appBar: Utilities.appBar(context, "Edit Profile"),
          body: Form(
            key: _globalKey,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameTextEditingController,
                    validator: (value) => Validator.basicValidator(value),
                    decoration: InputDecoration(
                        hintText: "Name",
                        labelText: "Name",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: mobileTextEditingController,
                    validator: (value) => Validator.basicPhoneNumber(value),
                    decoration: InputDecoration(
                        hintText: "Mobile Number",
                        labelText: "Mobile Number",
                        counterText: "",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    controller: referralCodeTextEditingController,
                    validator: (value) => Validator.basicValidator(value),
                    decoration: InputDecoration(
                        hintText: "Referral Code",
                        counterText: "",
                        labelText: "Referral Code",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  generalButton("Update", () async {
                    if (referralCodeTextEditingController.text != null &&
                        referralCodeTextEditingController.text.length == 6) {
                      await provider.addReferralPoints(
                          context, referralCodeTextEditingController.text);
                    }
                    await provider.updateProfile(
                        nameTextEditingController.text,
                        mobileTextEditingController.text,
                        referralCodeTextEditingController.text);
                    Navigator.pop(context);
                  })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
