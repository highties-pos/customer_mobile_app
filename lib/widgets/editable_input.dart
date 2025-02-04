import 'package:flutter/material.dart';

class EditableInput extends StatelessWidget {
  var hint;
  var title;

  EditableInput({
    super.key,
    required this.controller,
    required this.hint,
    required this.title,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16 * textScale,
              fontFamily: 'FontMain',
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 50,
          child: TextFormField(
            style: TextStyle(
                fontFamily: 'FontMain',
                fontWeight: FontWeight.bold,
                fontSize: 15 * textScale),
            obscureText: false,
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff832B29),
                ),
              ),
              hintText: hint,
              hintStyle: TextStyle(
                  fontFamily: 'FontMain',
                  color: Colors.grey,
                  fontSize: 15 * textScale,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}




// Card(
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 25, vertical: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           children: [
//                             const Text(
//                               "Aadhar Card",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   fontFamily: 'FontMain'),
//                             ),
//                             const SizedBox(height: 15),
//                             Container(
//                               height: 100,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey[400],
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: const Center(
//                                   child: Text(
//                                 "Preview",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                     fontFamily: 'FontMain'),
//                               )),
//                             ),
//                           ],
//                         ),
//                         IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.camera_alt))
//                       ],
//                     ),
//                   ),
//                 ),
//                 Card(
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 25, vertical: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "PanCard",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   fontFamily: 'FontMain'),
//                             ),
//                             const SizedBox(height: 15),
//                             Container(
//                               height: 100,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey[400],
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: const Center(
//                                   child: Text(
//                                 "Preview",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                     fontFamily: 'FontMain'),
//                               )),
//                             ),
//                           ],
//                         ),
//                         IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.camera_alt))
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 Card(
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 25, vertical: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Passport (International)",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   fontFamily: 'FontMain'),
//                             ),
//                             const SizedBox(height: 15),
//                             Container(
//                               height: 100,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey[400],
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: const Center(
//                                   child: Text(
//                                 "Preview",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                     fontFamily: 'FontMain'),
//                               )),
//                             ),
//                           ],
//                         ),
//                         IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.camera_alt))
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 Card(
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 25, vertical: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Drivers License",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   fontFamily: 'FontMain'),
//                             ),
//                             const SizedBox(height: 15),
//                             Container(
//                               height: 100,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey[400],
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: const Center(
//                                   child: Text(
//                                 "Preview",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                     fontFamily: 'FontMain'),
//                               )),
//                             ),
//                           ],
//                         ),
//                         IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.camera_alt))
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 Card(
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 25, vertical: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Local ID Proof",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   fontFamily: 'FontMain'),
//                             ),
//                             const SizedBox(height: 15),
//                             Container(
//                               height: 100,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey[400],
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: const Center(
//                                   child: Text(
//                                 "Preview",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                     fontFamily: 'FontMain'),
//                               )),
//                             ),
//                           ],
//                         ),
//                         IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.camera_alt))
//                       ],
//                     ),
//                   ),
//                 ),