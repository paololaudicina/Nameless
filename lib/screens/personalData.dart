import 'package:flutter/material.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/homeHardPage.dart';
import 'package:Nameless/screens/homeSoftPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalData extends StatefulWidget {
  final String? name;
  final String? surname;
  final int? age;
  final int? weight;
  final String? sex;

  const PersonalData({
    super.key,
    this.name,
    this.surname,
    this.age,
    this.weight,

    this.sex,
  });


  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  final _formKey = GlobalKey<FormState>();


  late TextEditingController nameController;

  late TextEditingController surnameController;
  //fare il check che inserisca roba valida l'utente (tipo per il nome devono essere caratteri e non numeri)
  late TextEditingController ageController;

  late TextEditingController weightController;

  String? _selectedSex;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    surnameController = TextEditingController(text: widget.surname);
    ageController = TextEditingController(
        text: (widget.age != null) ? widget.age.toString() : '');
    weightController = TextEditingController(
        text: (widget.weight != null) ? widget.weight.toString() : '');
    _selectedSex = widget.sex;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Personal Data',
                  style: TextStyle(fontSize: 28, color: Colors.black)),
              backgroundColor: Colors.blue,
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Fill the blanks with your personal data',
                        
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),
                        SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required name';
                                    } else if (!RegExp(r'^[a-zA-Z]+$')
                                        .hasMatch(value)) {
                                      return 'Name must contain only letters';
                                    }
                                    return null;
                                  },
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Name',
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required surname';
                                    } else if (!RegExp(r'^[a-zA-Z]+$')
                                        .hasMatch(value)) {
                                      return 'Surname must contain only letters';
                                    }
                                    return null;
                                  },
                                  controller: surnameController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'surname',
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required age';
                                    } else if (!RegExp(r'^[0-9]+$')
                                        .hasMatch(value)) {
                                      return 'Age must be an integer number';
                                    } else if (int.parse(value) <= 17) {
                                      return 'you are too young for using this app';
                                    }
                                    return null;
                                  },
                                  controller: ageController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'age',
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required weight';
                                    } else if (!RegExp(r'^[0-9]+$')
                                        .hasMatch(value)) {
                                      return 'Weight must be an integer number';
                                    }
                                    return null;
                                  },
                                  controller: weightController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'weight',
                                  )),
                              SizedBox(height: 20),
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
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final sp =
                                        await SharedPreferences.getInstance();
                                    sp.setBool('personalData', true);


                                    sp.setString('Name', nameController.text);
                                    sp.setString(
                                        'Surname', surnameController.text);
                                    sp.setInt(
                                        'age', int.parse(ageController.text));
                                    sp.setInt('weight',
                                        int.parse(weightController.text));
                                    sp.setString('sex', _selectedSex!);

                                    Provider.of<HomeProvider>(context,
                                            listen: false)
                                        .getPreferences();
                                    bool flagEdit = Provider.of<HomeProvider>(
                                            context,
                                            listen: false)
                                        .flagEdit;

                                    if (!flagEdit) {
                                      int levelChoice =
                                          Provider.of<HomeProvider>(context,
                                                  listen: false)
                                              .levelChoice;


                                      if (levelChoice == 1) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeSoftPage()));
                                      } else {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeHardPage()));
                                      }
                                    } else {
                                      Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .upDateFlagEdit();


                                      Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .getPreferences();
                                      Navigator.pop(context);
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(const SnackBar(
                                          content:
                                              Text('Missing personal data')));
                                  }
                                },
                                child: const Text(
                                  'SAVE',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ))));

  }
}
