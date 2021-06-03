import 'package:calendar/index.dart';
import 'package:calendar/screens/profile/profile-provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_crop/image_crop.dart';

class ImageCropScreen extends StatefulWidget {
  ImageCropScreen({Key key, this.imageFile, this.twicePop = true})
      : super(key: key);
  final File imageFile;
  final bool twicePop;

  @override
  _ImageCropScreenState createState() => _ImageCropScreenState();
}

class _ImageCropScreenState extends State<ImageCropScreen> {
  final cropKey = GlobalKey<CropState>();

  List<firebase_storage.UploadTask> _uploadTasks = [];

  var _isLoading = false;

  String url;

  Future<firebase_storage.UploadTask> uploadFile(File file, String name) async {
    if (file == null) {
      return null;
    }

    firebase_storage.UploadTask uploadTask;

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profilepic')
        .child('/$name.jpg');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    uploadTask = ref.putFile(File(file.path), metadata);

    var dowurl = await (await uploadTask).ref.getDownloadURL();
    url = dowurl;
    print(dowurl);

    return Future.value(uploadTask);
  }

  Future<void> createData(String url) async {
    setState(() {
      Provider.of<ProfileProvider>(context,listen: false).setUrl = url;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              CustomAppBar(
                text: "Crop Image",
              ),
              Expanded(
                flex: 4,
                child: Container(
                  // color: Colors.black,
                  child: Crop.file(
                    widget.imageFile,
                    scale: 1,
                    maximumScale: 1,
                    key: cropKey,
                    aspectRatio: 1.0,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: const EdgeInsets.all(0),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0)),
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColor.cyan,
                            border: Border.all(color: AppColor.cyan, width: 5),
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        // takePicture();
                        final crop = cropKey.currentState;
                        final scale = crop.scale;
                        final area = crop.area;
                        print(scale);

                        if (area == null || scale == 1.0) {
                          CommonWidgets.showToast(
                              context, "Please Crop the Image");
                          return;
                        }
                        try {
                          final croppedFile = await ImageCrop.cropImage(
                            file: widget.imageFile,
                            area: crop.area,
                          );
                          final cred =
                              Provider.of<Credential>(context, listen: false);
                          String user = cred.userName.replaceAll("@", "");
                          user = user.replaceAll(".", "");

                          final p = await uploadFile(croppedFile, user);
                          await createData(url);

                          if (Navigator.canPop(context)) Navigator.pop(context,p);
                          if (widget.twicePop && Navigator.canPop(context))
                            Navigator.pop(context);
                        } catch (e) {}

                        setState(() {
                          _isLoading = false;
                        });
                      },
                      padding: const EdgeInsets.all(0),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0)),
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColor.cyan,
                            border: Border.all(color: AppColor.cyan, width: 5),
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        _isLoading
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container()
      ],
    );
  }
}
