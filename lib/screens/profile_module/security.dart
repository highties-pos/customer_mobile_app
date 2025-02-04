import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Assuming Buttons widget is defined in the same file or imported correctly.

const String FontMain = 'FontMain';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _switchValue = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Security',
          style: TextStyle(
            fontFamily: FontMain,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xff2A6443),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xff2A6443),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Card(
              child: SwitchListTile(
                activeColor: const Color(0xff2A6443),
                title: const Text(
                  'Remember Me',
                  style: TextStyle(
                    fontFamily: FontMain,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: const Text(
                  'Turn this feature on/off',
                  style: TextStyle(
                    fontFamily: FontMain,
                  ),
                ),
                value: _switchValue,
                onChanged: (newValue) {
                  setState(() {
                    _switchValue = newValue;
                  });
                },
              ),
            ),
            Card(
              child: GestureDetector(
                onTap: () {
                  _showChangePasswordModal(context);
                },
                child: ListTile(
                  title: const Text(
                    'Change Password',
                    style: TextStyle(
                      fontFamily: FontMain,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      _showChangePasswordModal(context);
                    },
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    color: const Color(0xff2A6443),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Ensures modal remains visible above the keyboard
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            // Prevent closing modal on tap
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        fontFamily: FontMain,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xff2A6443),
                      ),
                    ),
                  ),
                  const Divider(height: 40),
                  const SizedBox(height: 20),
                  const Text(
                    'Current Password',
                    style: TextStyle(
                        fontFamily: FontMain,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    style: const TextStyle(
                        fontFamily: FontMain,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      hintText: 'Current Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'New Password',
                    style: TextStyle(
                        fontFamily: FontMain,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: _obscureText,
                    style: const TextStyle(
                        fontFamily: FontMain,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Re-enter Password',
                    style: TextStyle(
                        fontFamily: FontMain,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    style: const TextStyle(
                        fontFamily: FontMain,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Re-enter Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          // Toggle password visibility
                        },
                        icon: const Icon(Icons.visibility),
                      ),
                    ),
                  ),
                  const Divider(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              const Size(150, 50)), // Adjust the size as needed
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green[100]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context); // Close modal
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xff2A6443),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Fontmain',
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          minimumSize: const Size(150, 45),
                          maximumSize: const Size(150, 50),
                          backgroundColor: const Color(0xff2A6443),
                        ),
                        onPressed: () {
                          // Handle password update
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontMain),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
