import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yum_burger/Controllers/burger_controller.dart';
import 'package:yum_burger/Controllers/drink_controller.dart';
import 'package:yum_burger/l10n//app_localizations.dart';

class DrinkAdminPage extends StatefulWidget {
  const DrinkAdminPage({super.key});

  @override
  State<DrinkAdminPage> createState() => _DrinkAdminPageState();
}

class _DrinkAdminPageState extends State<DrinkAdminPage> {
  DrinkController drinkController = new DrinkController();
  CollectionReference<Object?>? drinkList;

  @override
  void initState() {
    super.initState();
    loadDrinkCollection();
  }

  Future<void> loadDrinkCollection() async {
    var drinks = await drinkController.getDrinksCollection();
    setState(() {
      drinkList = drinks;
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
                  t.drinks,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _showAddDrinkDialog();
                  },
                  label: Text(t.addDrink),
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
                stream: drinkList?.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text(t.noData));
                  }
                  final drinks = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: drinks.length,
                    itemBuilder: (context, index) {
                      var doc = drinks[index];
                      var data = doc.data() as Map<String, dynamic>;
                      String drinkId = doc.id;

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
                                bool deleted = await drinkController
                                    .deleteDrink(drinkId);
                                if (deleted == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t.deletedDrink,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t.deletedDrink,
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
                                _showEditDrinkDialog(drinkId, data);
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

  void _showAddDrinkDialog() {
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
          title: Text(t.addDrink),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: t.drinkName),
              ),
              SizedBox(height: 12),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: t.drinkPrice),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: t.drinkDescription),
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

                await drinkController.addDrink(nameController.text, price, descriptionController.text, imageBase!);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(t.drinkAdded)),
                );
              },
              child: Text(t.addDrink),
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

  void _showEditDrinkDialog(String burgerId, Map<String, dynamic> data) {
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
          title: Text(t.editDrink),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: t.drinkName, hintText: data['name']),
              ),
              SizedBox(height: 12),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: t.drinkPrice, hintText: "${data['price'].toStringAsFixed(2)}"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: t.drinkDescription, hintText: data['description']),
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
                await drinkController.updateDrink(burgerId, nameController.text, descriptionController.text, imageBase!, price);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.editedDrink)));
              },
              child: Text(t.save),
            )
          ],
        ),
      ),
    );
  }
}