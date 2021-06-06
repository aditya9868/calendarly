import 'package:calendar/index.dart';
import 'package:calendar/screens/profile/profile-provider.dart';
import 'package:calendar/utils/custom-datepicker.dart';
import 'package:calendar/utils/custom-textfield.dart';
import 'package:calendar/user-utils/image-crop.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController first = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController college = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController codechef = TextEditingController();
  TextEditingController codeforces = TextEditingController();
  TextEditingController leet = TextEditingController();

  DateTime startDate;

  changeStartDate(DateTime date) {
    startDate = date;
  }

  String url;

  bool isLoading = false;
  bool isChecking = false;
  bool readOnly = false;
  bool isValid = false;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(
          text: "Profile",
          showPrefix: false,
        ),
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Consumer<ProfileProvider>(
                      builder: (context, profile, _) =>
                          FutureBuilder<ProfileModel>(
                        future: profile.getProfile(),
                        initialData: ProfileModel(),
                        builder: (context, snapshot) {
                          url = snapshot.data.url;
                          return UserAvatarContainer(
                            imageUrl: snapshot.data.url,
                            showEdit: !readOnly,
                            func: () async {
                              showModalBottomSheet(
                                backgroundColor: AppColor.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SafeArea(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(30))),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 5,
                                          decoration: BoxDecoration(
                                              color: AppColor.grey,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextButton(
                                            text: "Take Photo",
                                            onPressed: () async {
                                              // Navigator.pop(context);
                                              final image =
                                                  await picker.getImage(
                                                source: ImageSource.camera,
                                                preferredCameraDevice:
                                                    CameraDevice.front,
                                                imageQuality: 50,
                                              );

                                              if (image != null) {
                                                print(image.path);
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ImageCropScreen(
                                                            imageFile: File(
                                                                image.path),
                                                            twicePop: false,
                                                          ),
                                                      fullscreenDialog: true),
                                                );

                                                Navigator.pop(context);
                                              }
                                            }),
                                        CustomTextButton(
                                            text: "Select From Gallery",
                                            onPressed: () async {
                                              final image =
                                                  await picker.getImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 50,
                                              );

                                              if (image != null) {
                                                print(image.path);
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ImageCropScreen(
                                                            imageFile: File(
                                                                image.path),
                                                            twicePop: false,
                                                          ),
                                                      fullscreenDialog: true),
                                                );
                                                Navigator.pop(context);
                                                // Navigator.pop(context);
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Consumer<ProfileProvider>(
                          builder: (context, profile, _) => CustomTextField(
                            hint: "Username*",
                            controller: username,
                            readOnly: readOnly,
                            onchange: (text) async {
                              if (!isChecking) {
                                isChecking = true;
                                if (!CommonWidgets.checkUserName(
                                    context, text)) {
                                  setState(() {
                                    isValid = false;
                                  });
                                  isChecking = false;
                                  return;
                                }
                                final res =
                                    await profile.checkValidUserName(text);
                                setState(() {
                                  isValid = res;
                                });
                                isChecking = false;
                              }
                            },
                            suffix: username.text == ""
                                ? Container()
                                : Icon(
                                    isValid ? Icons.done : Icons.error_outline,
                                    color:
                                        isValid ? AppColor.cyan : AppColor.red,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hint: "First Name*",
                          controller: first,
                          readOnly: readOnly,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          hint: "Last Name",
                          controller: last,
                          readOnly: readOnly,
                        ),
                      ),
                    ],
                  ),
                  CustomDatePicker(
                    text: "Date of Birth*",
                    startDate: startDate,
                    changeDate: changeStartDate,
                    maxDate: DateTime.now(),
                    minDate: DateTime(1980, 01, 01),
                    readOnly: readOnly,
                  ),
                  CustomTextField(
                    hint: "College*",
                    controller: college,
                    readOnly: readOnly,
                  ),
                  CustomTextField(
                    hint: "year*",
                    controller: year,
                    keyboardType: TextInputType.datetime,
                    readOnly: readOnly,
                  ),
                  CustomTextField(
                    hint: "CodeChef Username",
                    controller: codechef,
                    readOnly: readOnly,
                  ),
                  CustomTextField(
                    hint: "CodeForces Username",
                    controller: codeforces,
                    readOnly: readOnly,
                  ),
                  CustomTextField(
                    hint: "Leetcode Username",
                    controller: leet,
                    readOnly: readOnly,
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            func: () async {
              // setState(() {
              //   readOnly = !readOnly;
              // });
              FocusScope.of(context).unfocus();
              if (url == null) {
                CommonWidgets.showToast(context, "Upload Profile Photo",
                    duration: 2);
                return;
              }
              if (username.text == "") {
                CommonWidgets.showToast(context, "Enter Username", duration: 2);
                return;
              }

              if (!isValid) {
                CommonWidgets.showToast(
                    context, "Username is not valid or it already exists.",
                    duration: 2);
                return;
              }

              if (first.text == "") {
                CommonWidgets.showToast(context, "Enter First Name",
                    duration: 2);
                return;
              }

              if (startDate == null) {
                CommonWidgets.showToast(context, "Choose Date of Birth",
                    duration: 2);
                return;
              }
              if (college.text == "") {
                CommonWidgets.showToast(context, "Enter College", duration: 2);
                return;
              }
              if (year.text == "") {
                CommonWidgets.showToast(context, "Enter Year", duration: 2);
                return;
              }

              setState(() {
                isLoading = true;
              });
              final profile =
                  Provider.of<ProfileProvider>(context, listen: false);
              final cred = Provider.of<Credential>(context, listen: false);
              final response = await profile.addProfile(ProfileModel(
                  codechef: codechef.text,
                  codeforces: codeforces.text,
                  college: college.text,
                  dob: startDate,
                  first: first.text,
                  last: last.text,
                  leetCode: leet.text,
                  url: profile.url,
                  userName: username.text,
                  id: cred.userCredential.id,
                  year: year.text));
              setState(() {
                isLoading = false;
              });
              CommonWidgets.showToast(context, response.message);
              Future.delayed(Duration(seconds: 3));
              await Provider.of<Credential>(context, listen: false).getuser();
              if (response.isSuccess) {
                Navigator.pop(context);
              }
            },
            text: "Save",
            isLoading: false,
          ),
          SizedBox(
            height: 10,
          ),
        ]);
  }
}

class UserAvatarContainer extends StatelessWidget {
  bool showEdit;
  final String imageUrl;
  final Function func;
  UserAvatarContainer({
    this.showEdit = true,
    Key key,
    this.imageUrl,
    this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: AppColor.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(70),
              border: Border.all(
                color: AppColor.white,
                width: 2,
              ),
            ),
            child: InkWell(
              onTap: () {
                // if (imageUrl != null)
                //   showDialog(
                //     context: context,
                //     builder: (context) => DetailScreen(
                //       imageUrl: imageUrl,
                //     ),
                //   );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(140 / 2),
                child: Container(
                    alignment: Alignment.center,
                    child: imageUrl == null
                        ? Icon(
                            Icons.person,
                            size: 83,
                            color: AppColor.white,
                          )
                        : Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            height: 100,
                          )),
              ),
            ),
          ),
          !showEdit
              ? Container()
              : Align(
                  alignment: Alignment(0.95, 0.8),
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: AppColor.cyan,
                      borderRadius: BorderRadius.circular(50 / 2),
                    ),
                    child: InkWell(
                      onTap: func,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
