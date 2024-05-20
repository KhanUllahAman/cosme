import 'package:cosme/admin/login/admin_login.dart';
import 'package:cosme/guest/guest_screen.dart';
import 'package:cosme/registeration/login.dart';
import 'package:cosme/widget/button/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectType extends StatefulWidget {
  const SelectType({Key? key}) : super(key: key);

  @override
  _SelectTypeState createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0XFFEC7D7F).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
                width: 340,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Select Type", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    SizedBox(
                      width:300,
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            elevation: 8,
                            items: const [
                              DropdownMenuItem(
                                value: 'admin',
                                child: Text(
                                  'Admin',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'user',
                                child: Text(
                                  'User',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'guest',
                                child: Text(
                                  'Guest',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                            onChanged: (String? value) {
                              setState(() {
                                _selectedType = value;
                                print('Selected: $value');
                              });
                            },
                            hint: const Text(
                              'Select type',
                              style: TextStyle(fontSize: 20),
                            ),
                            value: _selectedType,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    RoundButton(
                    title: 'OK',
                    onTap: () {
                      if (_selectedType == 'admin') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminLogin()),
                          );
                        } else if (_selectedType == 'user') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => login()),
                          );
                        } else if (_selectedType == 'guest') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GuestScreen()),
                          );
                        }
                    },
                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}