import 'package:flutter/material.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/homeHardPage.dart';
import 'package:Nameless/screens/homeSoftPgae.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();
  //fare il check che inserisca roba valida l'utente (tipo per il nome devono essere caratteri e non numeri)
  TextEditingController ageController = TextEditingController();

  TextEditingController weightController = TextEditingController();

  String? _selectedSex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('PERSONAL DATA')),
        body: Padding(
          padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'required name';
                          } else {
                            return null;
                          }
                        },
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'required surname';
                          } else {
                            return null;
                          }
                        },
                        controller: surnameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'surname',
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'required age';
                          } else {
                            return null;
                          }
                        },
                        controller: ageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'age',
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'required weight';
                          } else {
                            return null;
                          }
                        },
                        controller: weightController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'weight',
                        )),
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio<String>(
                            value: 'Male',
                            groupValue: _selectedSex,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedSex = value;
                              });
                            },
                          ),
                          const Text('Male'),
                          Radio<String>(
                              value: 'Female',
                              groupValue: _selectedSex,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedSex = value;
                                });
                              }),
                          const Text('Female'),
                        ]),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //const bool personalData = true;
    
                            final sp = await SharedPreferences.getInstance();
                            sp.setBool('personalData', true);
    
                            sp.setString('Name', nameController.text);
                            sp.setString('Surname', surnameController.text);
                            sp.setInt('age', int.parse(ageController.text));
                            sp.setInt(
                                'weight', int.parse(weightController.text));
                            sp.setString('sex', _selectedSex!);
                            Provider.of<HomeProvider>(context, listen: false)
                                .setPersonaData(true);
                            int levelChoice = Provider.of<HomeProvider>(
                                    context,
                                    listen: false)
                                .levelChoice;
    
                            if (levelChoice == 1) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeSoftPage()));
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeHardPage()));
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(const SnackBar(
                                  content: Text('Missing personal data')));
                          }
                        },
                        child: const Text('SAVE')),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}