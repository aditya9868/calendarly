import 'package:calendar/index.dart';
import 'package:calendar/screens/profile/profile-provider.dart';
import 'package:calendar/utils/custom-datepicker.dart';
import 'package:calendar/utils/custom-textfield.dart';
import 'package:calendar/utils/image-crop.dart';
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

  bool isLoading = false;
  bool readOnly = false;

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
                      builder: (context, profile, _) => UserAvatarContainer(
                        imageUrl: profile.url,
                        showEdit: !readOnly,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
              setState(() {
                readOnly = !readOnly;
              });
              FocusScope.of(context).unfocus();
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
                CommonWidgets.showToast(context, "Enter Title", duration: 2);
                return;
              }
              if (year.text == "") {
                CommonWidgets.showToast(context, "Enter Title", duration: 2);
                return;
              }
              // if (username.text == "") {
              //   CommonWidgets.showToast(context, "Enter Title", duration: 2);
              //   return;
              // }

              setState(() {
                isLoading = true;
              });
              final profile =
                  Provider.of<ProfileProvider>(context, listen: false);
              final response = await profile.addProfile(ProfileModel(
                  codechef: codechef.text,
                  codeforces: codeforces.text,
                  college: college.text,
                  dob: startDate,
                  first: first.text,
                  last: last.text,
                  leetCode: leet.text,
                  url: profile.url,
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
  final picker = ImagePicker();
  bool showEdit;
  final String imageUrl;
  UserAvatarContainer({
    this.showEdit = true,
    Key key,
    this.imageUrl,
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
                child: Consumer<ProfileProvider>(
                  builder: (context, profile, _) => Container(
                      alignment: Alignment.center,
                      child: imageUrl == null
                          ? Icon(
                              Icons.person,
                              size: 83,
                              color: AppColor.white,
                            )
                          : Image.network(
                              profile.picUrl,
                              fit: BoxFit.cover,
                              height: 100,
                            )),
                ),
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
                      onTap: () async {
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
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 5,
                                    decoration: BoxDecoration(
                                        color: AppColor.grey,
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextButton(
                                      text: "Take Photo",
                                      onPressed: () async {
                                        // Navigator.pop(context);
                                        final image = await picker.getImage(
                                            source: ImageSource.camera,
                                            preferredCameraDevice:
                                                CameraDevice.front);

                                        if (image != null) {
                                          print(image.path);
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        ImageCropScreen(
                                                          imageFile:
                                                              File(image.path),
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
                                        final image = await picker.getImage(
                                            source: ImageSource.gallery);

                                        if (image != null) {
                                          print(image.path);
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        ImageCropScreen(
                                                          imageFile:
                                                              File(image.path),
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
