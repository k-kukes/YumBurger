import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yum_burger/Controllers/burger_controller.dart';
import 'package:yum_burger/l10n//app_localizations.dart';

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
    final t = AppLocalizations.of(context)!;
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
                  t.burgers,
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
                  label: Text(t.addBurger),
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
                    return Center(child: Text(t.noData));
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
                          "${data['description']}\n ${t.price}${data['price'].toStringAsFixed(2)}\$",
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
                                        t.deletedBurger,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t.deletedBurger,
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
    final t = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    File? selectedImage;
    String? imageBase;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: Text(t.addBurger),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: t.burgerName),
              ),
              SizedBox(height: 12),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: t.burgerPrice),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: t.burgerDescription),
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
                label: Text(t.pickImage),
              ),
              SizedBox(height: 8),
              selectedImage != null
                  ? Image.file(
                      selectedImage!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    )
                  : Text(t.noImage),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(t.cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    priceController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    imageBase == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.fillFields)),
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
                  SnackBar(content: Text(t.addedBurger)),
                );
              },
              child: Text(t.addBurger),
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
    final t = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    File? selectedImage;
    String? imageBase = data['image'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: Text(t.editBurger),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: t.burgerName, hintText: data['name']),
              ),
              SizedBox(height: 12),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: t.burgerPrice, hintText: "${data['price'].toStringAsFixed(2)}"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: t.burgerDescription, hintText: data['description']),
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
                label: Text(t.pickImage),
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
                child: Text(t.cancel),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                  priceController.text.isEmpty ||
                  descriptionController.text.isEmpty ||
                  imageBase == null
                  ) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.fillFields)));
                    return;
                  }

                  final price = double.parse(priceController.text);
                  await burgerController.updateBurger(burgerId, nameController.text, descriptionController.text, imageBase!, price);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.editedBurger)));
                },
                child: Text(t.save),
            )
          ],
        ),
      ),
    );
  }
}
