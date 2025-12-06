import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yum_burger/Controllers/burger_controller.dart';

class BurgerAdminPage extends StatefulWidget {
  const BurgerAdminPage({super.key});

  @override
  State<BurgerAdminPage> createState() => _BurgerAdminPageState();
}

class _BurgerAdminPageState extends State<BurgerAdminPage> {
  BurgerController burgerController = new BurgerController();
  CollectionReference<Object?>? burgerList;

  @override
  void initState() {
    super.initState();
    loadBurgerCollection();
  }

  Future<void> loadBurgerCollection() async {
    var burgers = await burgerController.getBurgersCollection();
    setState(() {
      burgerList = burgers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Burgers',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _showAddBurgerDialog();
                  },
                  label: Text('Add Burger'),
                  icon: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: burgerList?.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text('No data'));
                  }
                  final burgers = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: burgers.length,
                    itemBuilder: (context, index) {
                      var doc = burgers[index];
                      var data = doc.data() as Map<String, dynamic>;
                      String burgerId = doc.id;

                      return ListTile(
                        title: Text(data['name']),
                        subtitle: Text(
                          "${data['description']}\n Price: ${data['price'].toStringAsFixed(2)}\$",
                        ),
                        leading: data['image'].startsWith('assets/')
                            ? Image.asset(
                                data['image'],
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              )
                            : Image.memory(
                                base64Decode(data['image']),
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                bool deleted = await burgerController
                                    .deleteBurger(burgerId);
                                if (deleted == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Burger was successfully deleted!',
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Burger was successfully deleted!',
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(Icons.delete),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _showEditBurgerDialog(burgerId, data);
                              },
                              icon: Icon(Icons.edit),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddBurgerDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    File? selectedImage;
    String? imageBase;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: Text('Add New Burger'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Burger Name'),
              ),
              SizedBox(height: 12),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Burger Price'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Burger Description'),
              ),
              SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  File? image = await pickImage();
                  if (image != null) {
                    final bytes = await image.readAsBytes();
                    imageBase = base64Encode(bytes);
                    setStateDialog(() {
                      selectedImage = image;
                    });
                  }
                },
                icon: Icon(Icons.image),
                label: Text('Pick Image'),
              ),
              SizedBox(height: 8),
              selectedImage != null
                  ? Image.file(
                      selectedImage!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    )
                  : Text('No image'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    priceController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    imageBase == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill out all the fields!')),
                  );
                  return;
                }

                final price = double.parse(priceController.text);

                await burgerController.addBurger(
                  nameController.text,
                  price,
                  descriptionController.text,
                  imageBase!,
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Burger added successfully')),
                );
              },
              child: Text('Add Burger'),
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  }

  void _showEditBurgerDialog(String burgerId, Map<String, dynamic> data) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    File? selectedImage;
    String? imageBase = data['image'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: Text('Edit Burger'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Burger Name', hintText: data['name']),
              ),
              SizedBox(height: 12),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Burger Price', hintText: "${data['price'].toStringAsFixed(2)}"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Burger Description', hintText: data['description']),
              ),
              SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  File? image = await pickImage();
                  if (image != null) {
                    final bytes = await image.readAsBytes();
                    imageBase = base64Encode(bytes);
                    setStateDialog(() {
                      selectedImage = image;
                    });
                  }
                },
                icon: Icon(Icons.image),
                label: Text('Pick Image'),
              ),
              SizedBox(height: 8),
              selectedImage != null
                  ? Image.file(
                      selectedImage!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    )
                  : data['image'].startsWith('assets/')
                  ? Image.asset(
                      data['image'],
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    )
                  : Image.memory(
                      base64Decode(data['image']),
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                  priceController.text.isEmpty ||
                  descriptionController.text.isEmpty ||
                  imageBase == null
                  ) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all the fields')));
                    return;
                  }

                  final price = double.parse(priceController.text);
                  await burgerController.updateBurger(burgerId, nameController.text, descriptionController.text, imageBase!, price);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Burger edited successfully')));
                },
                child: Text('Save Changes'),
            )
          ],
        ),
      ),
    );
  }
}
