import 'package:bioimetrics_auth/loginsuccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final LocalAuthentication auth;
  bool _supportState = false;
  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((isSupported) {
      setState(() {
        _supportState = isSupported;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 239, 239),
      appBar: AppBar(
        title: const Text(
          'Biometrics Example',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 450,
                width: 400,
                child: Column(
                  children: [
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (_supportState)
                      const Center(
                          child: Text(
                        'This device supports Biometric Authentication',
                        style: TextStyle(color: Colors.grey),
                      ))
                    else
                      const Text('This device is not supported'),
                    // Center(
                    //   child: ElevatedButton(
                    //       onPressed: _getavailableBiometrics,
                    //       child: Text('Get available biometrics by Clicking me')),
                    // ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Enter Email',
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            disabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Password',
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            disabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Login')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: _authenticate,
                          child: const Text('Authenticate via Biometrics')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _authenticate() async {
    try {
      bool authenticaated = await auth.authenticate(
          localizedReason:
              'Takes user to Home screen is authenticated/biometrics matches',
          // 'Returns true if the user successfully authenticated, false otherwise',
          options: const AuthenticationOptions(
              biometricOnly: true, stickyAuth: true));
      print('Authenticated : $authenticaated');
      if (authenticaated) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginSuccessful()));
      } else {
        return;
      }
    } on PlatformException catch (e) {
      print('Platform exception: ' + e.toString());
    }
  }

  Future<void> _getavailableBiometrics() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (!mounted) {
      return;
    }
    print('List of available biometrics $availableBiometrics');
  }
}
