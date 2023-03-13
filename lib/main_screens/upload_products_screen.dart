import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sat_app/auth/auth_widgets/snackbar/snackbar_widget.dart';
import 'package:sat_app/utilities/categ_list.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UploadProductsScreen extends StatefulWidget {
  const UploadProductsScreen({Key? key}) : super(key: key);

  @override
  _UploadProductsScreenState createState() => _UploadProductsScreenState();
}

class _UploadProductsScreenState extends State<UploadProductsScreen> {
  late double price;
  late int quantity;
  late String proName;
  late String proDesc;
  late String proId;
  bool processing = false;
  String mainCategValue = 'select category';
  String subCategValue = 'subcategory';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  final ImagePicker _picker = ImagePicker();
  List<XFile>? imagesFileList = [];
  List<String> imagesUrlList = [];
  List<String> subCategList = [];
  dynamic _pickedImageError;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      /* Stack(
                        children: [
                         
                          imagesFileList!.isEmpty
                              ? SizedBox()
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      imagesFileList = [];
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                  ),
                                ),
                        ],
                      ),
                      */
                      Container(
                        color: Colors.blueGrey.shade100,
                        height: size.height * 0.28,
                        width: size.width * 0.5,
                        child: imagesFileList != null
                            ? previewImages()
                            : Center(
                                child: Text(
                                  'you have not \n \n picked images yet !',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: size.height * 0.28,
                        width: size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '* select main category',
                                  style: TextStyle(color: Colors.red),
                                ),
                                DropdownButton(
                                  iconSize: 40,
                                  iconEnabledColor: Colors.red,
                                  dropdownColor: Colors.yellow.shade400,
                                  value: mainCategValue,
                                  // items: ['men', 'women', 'shoes', 'bags']
                                  items: maincateg
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),

                                  onChanged: (String? value) {
                                    selectedMainCateg(value);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '* select subcategory',
                                  style: TextStyle(color: Colors.red),
                                ),
                                DropdownButton(
                                  iconSize: 40,
                                  iconEnabledColor: Colors.red,
                                  iconDisabledColor: Colors.black,
                                  dropdownColor: Colors.yellow.shade400,
                                  menuMaxHeight: 500,
                                  disabledHint: Text('select category'),
                                  value: subCategValue,
                                  // items: ['men', 'women', 'shoes', 'bags']
                                  items: subCategList
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),

                                  onChanged: (String? value) {
                                    log('$value');
                                    setState(() {
                                      subCategValue = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.yellow,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: TextFormField(
                        // onChanged: (value) {
                        onSaved: (value) {
                          price = double.parse(value!);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter price';
                          } else if (value.isValidPrice() != true) {
                            return 'Invalid Price';
                          }
                          return null;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: textFormDecoration.copyWith(
                          labelText: 'price',
                          hintText: 'price .. \$',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        onSaved: (value) {
                          quantity = int.parse(value!);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter quantity';
                          } else if (value.isValidQuantity() != true) {
                            return 'not valid quantity';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Quantity',
                          hintText: 'Add Quantity',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        onSaved: (value) {
                          proName = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter product name';
                          } else {
                            return null;
                          }
                        },
                        maxLength: 100,
                        maxLines: 3,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'product name',
                          hintText: 'Enter product name',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        onSaved: (value) {
                          proDesc = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter description ';
                          } else {
                            return null;
                          }
                        },
                        maxLength: 800,
                        maxLines: 5,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'product description',
                          hintText: ' Enter product description ',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            /* imagesFileList!.isEmpty
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          imagesFileList = [];
                        });
                      },
                      backgroundColor: Colors.yellow,
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  */
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FloatingActionButton(
                  onPressed: imagesFileList!.isEmpty
                      ? () {
                          pickProductImages();
                        }
                      : () {
                          setState(() {
                            imagesFileList = [];
                          });
                        },
                  backgroundColor: Colors.yellow,
                  child: imagesFileList!.isEmpty
                      ? Icon(
                          Icons.photo_library,
                          color: Colors.black,
                        )
                      : Icon(
                          Icons.delete_forever,
                          color: Colors.black,
                        )),
            ),
            FloatingActionButton(
              onPressed: processing ? null : uploadProduct,
              backgroundColor: Colors.yellow,
              child: processing == true
                  ? CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.upload,
                      color: Colors.black,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void selectedMainCateg(String? value) {
    if (value == 'select category') {
      subCategList = [];
    } else if (value == 'men') {
      subCategList = men;
    } else if (value == 'women') {
      subCategList = women;
    } else if (value == 'electronics') {
      subCategList = electronics;
    } else if (value == 'accessories') {
      subCategList = accessories;
    } else if (value == 'shoes') {
      subCategList = shoes;
    } else if (value == 'home & garden') {
      subCategList = homeandgarden;
    } else if (value == 'beauty') {
      subCategList = beauty;
    } else if (value == 'kids') {
      subCategList = kids;
    } else if (value == 'bags') {
      subCategList = bags;
    }
    setState(() {
      mainCategValue = value!;
      subCategValue = 'subcategory';
    });
  }

  void pickProductImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );
      setState(() {
        imagesFileList = pickedImages;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      log(_pickedImageError);
    }
  }

  Future<void> uploadImages() async {
    if (mainCategValue != 'select category' || subCategValue != 'subcategory') {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (imagesFileList!.isNotEmpty) {
          setState(() {
            processing = true;
          });
          try {
            for (var image in imagesFileList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${path.basename(image.path)}');
              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imagesUrlList.add(value);
                });
              });
            }
          } catch (e) {
            log('$e');
          }
        } else {
          MyMessageHandler.showSnackBar(
              _scaffoldKey, 'Please pick images first!');
        }
      } else {
        MyMessageHandler.showSnackBar(_scaffoldKey, 'please fill all fields');
      }
    } else {
      MyMessageHandler.showSnackBar(_scaffoldKey, 'please Select Categories');
    }
  }

  void uploadData() async {
    if (imagesUrlList.isNotEmpty) {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('products');
      proId = Uuid().v4();
      await collectionRef
          .doc(
        // FirebaseAuth.instance.currentUser!.uid,
        proId,
      )
          .set({
        'proid': proId,
        'maincateg': mainCategValue,
        'subcateg': subCategValue,
        'price': price,
        'instock': quantity,
        'proname': proName,
        'prodesc': proDesc,
        'sId': FirebaseAuth.instance.currentUser!.uid,
        'proimages': imagesUrlList,
        'discount': 0,
      }).whenComplete(() {
        setState(() {
          processing = false;
          imagesFileList = [];
          mainCategValue = 'select category';
          // subCategValue = 'subcategory';
          subCategList = [];
          imagesFileList = [];
        });
        _formKey.currentState!.reset();
      });
    }
  }

  void uploadProduct() async {
    await uploadImages().whenComplete(() => uploadData());
  }
/* void uploadProduct1() async {
    /* && - both has to be worked || -one may be not selected*/
    if (mainCategValue != 'select category' || subCategValue != 'subcategory') {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (imagesFileList!.isNotEmpty) {
          try {
            for (var image in imagesFileList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${path.basename(image.path)}');
              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imagesUrlList.add(value);
                }).whenComplete(() async {
                  CollectionReference collectionRef =
                      FirebaseFirestore.instance.collection('product');
                  await collectionRef
                      .doc(
                    FirebaseAuth.instance.currentUser!.uid,
                  )
                      .set({
                    'maincateg': mainCategValue,
                    'subcateg': subCategValue,
                    'price': price,
                    'quantity': quantity,
                    'proname': proName,
                    'prodesc': proDesc,
                    'sId': FirebaseAuth.instance.currentUser!.uid,
                    'proimages': imagesUrlList,
                    'discount': 0,
                  });
                });
                ;
              });
            }
          } catch (e) {
            log('$e');
          }

          log('Images picked');
          log('Valid');
          log('$price');
          log('$quantity');
          log('$proName');
          log('$proDesc');

          setState(() {
            imagesFileList = [];
            mainCategValue = 'select category';
            // subCategValue = 'subcategory';
            subCategList = [];
          });
          _formKey.currentState!.reset();
        } else {
          MyMessageHandler.showSnackBar(
              _scaffoldKey, 'Please pick images first!');
        }
      } else {
        MyMessageHandler.showSnackBar(_scaffoldKey, 'please fill all fields');
      }
    } else {
      MyMessageHandler.showSnackBar(_scaffoldKey, 'please Select Categories');
    }
  }

        */

  Widget previewImages() {
    if (imagesFileList!.isNotEmpty) {
      return ListView.builder(
          itemCount: imagesFileList!.length,
          itemBuilder: (context, index) {
            return Image.file(
              File(imagesFileList![index].path),
            );
          });
    } else {
      return Center(
        child: Text(
          'you have not \n \n picked images yet !',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'price',
  hintText: 'price .. \$',
  labelStyle: TextStyle(color: Colors.purple),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.yellow,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blueAccent,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10)),
);

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}
