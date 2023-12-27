import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:taxi_driver/common/color_extension.dart';
import 'package:taxi_driver/common/service_call.dart';
import 'package:taxi_driver/common_widget/line_text_field.dart';
import 'package:taxi_driver/common_widget/round_button.dart';
import 'package:taxi_driver/view/login/bank_detail_view.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  FlCountryCodePicker countryCodePicker = const FlCountryCodePicker();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  late CountryCode countryCode;

  @override
  void initState() {
    super.initState();

    txtName.text = "${ServiceCall.userObj["name"]}";
    txtEmail.text = "${ServiceCall.userObj["email"]}";
    txtMobile.text = "${ServiceCall.userObj["mobile"]}";

    countryCode = countryCodePicker.countryCodes
        .firstWhere((element) => element.name == "India");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Image.asset(
            "assets/img/back.png",
            width: 25,
            height: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit profile",
                style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 25,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 30,
              ),
              LineTextField(
                title: "Name",
                hintText: "Ex: Amit Bisht",
                controller: txtName,
              ),
              const SizedBox(
                height: 8,
              ),
              LineTextField(
                title: "Email",
                hintText: "Ex: 123@gmail.com",
                keyboardType: TextInputType.emailAddress,
                controller: txtEmail,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Mobile Number",
                style: TextStyle(color: TColor.placeholder, fontSize: 14),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      final code =
                          await countryCodePicker.showPicker(context: context);
                      if (code != null) {
                        countryCode = code;
                        setState(() {});
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 20,
                          child: countryCode.flagImage,
                        ),
                        Text(
                          "  ${countryCode.dialCode}",
                          style: TextStyle(
                              color: TColor.primaryText, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: txtMobile,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "9876543210",
                      ),
                    ),
                  )
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 15,
              ),
              RoundButton(
                onPressed: () {},
                title: "UPDATE",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ServiceCall
  void getServiceZoneList() {
    
      ServiceCall.post({
        "user_type": userType,
        "mobile_code": mobileCode,
        "mobile": mobile,
        "os_type": Platform.isIOS
            ? "i"
            : Platform.isAndroid
                ? "a"
                : "w",
        "push_type": "",
        "socket_id": "",
      }, SVKey.svLogin, withSuccess: (responseObj) async {
        if ((responseObj[KKey.status] as String? ?? "") == "1") {
          ServiceCall.userObj = responseObj[KKey.payload] as Map;
          ServiceCall.userType = ServiceCall.userObj["user_type"] as int? ?? 1;

          Globs.udSet(ServiceCall.userObj, Globs.userPayload);
          Globs.udBoolSet(true, Globs.userLogin);

          emit(LoginApiResultState());
          emit(LoginInitialState());
        } else {
          emit(
            LoginErrorState(responseObj[KKey.message] ?? MSG.fail),
          );
        }
  }
}
