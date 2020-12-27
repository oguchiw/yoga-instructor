import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sofia/screens/home_page.dart';

import 'screens/login_page.dart';
import 'screens/name_page.dart';
import 'utils/sign_in.dart';

/// For storing the list of cameras
List<CameraDescription> cameras = [];
void main() async {
  // Getting the available device cameras
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }

  // Starting point of the app
  runApp(MyApp());
}

/// For printing the camera error, if any occurs
void logError(String code, String message) => print('Error: $code\nError Message: $message');

/// First stateless widget to get loaded as soon as
/// the Dart engine runs
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    getUserInfo();
  }

  /// Checking if the user is already logged in
  /// and retrieve user info
  Future getUserInfo() async {
    await getUser();
    // await getUid();
    setState(() {});
    print(uid);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sofia: yoga trainer',
      // Redirect to the respective page as per the
      // authentication info
      home: (uid != null && authSignedIn != false)
          ? detailsUploaded
              ? HomePage()
              : NamePage()
          : LoginPage(),
    );
  }
}
