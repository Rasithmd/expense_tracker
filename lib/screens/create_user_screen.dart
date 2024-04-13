import 'package:expense_tracker/controller/user_controller.dart';
import 'package:expense_tracker/model/user_model.dart';
import 'package:expense_tracker/sereens/landing_screen.dart';
import 'package:expense_tracker/utils/const.dart';
import 'package:expense_tracker/widget/login_text_field.dart';
import 'package:expense_tracker/widget/password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final bool _isLoading = false;
  final UserModel _userModel = UserModel.singleUser;
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(143, 190, 170, 0.9),
        body: FormBuilder(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create New User",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      child: LoginTextField(
                          placeholder: "Name",
                          inputType: TextInputType.name,
                          initialValue: '',
                          onChanged: (value) {
                            setState(() {
                              _userModel.name = value!;
                            });
                          },
                          isRequired: true,
                          prefix: Container(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey.shade600,
                              )),
                          field: 'name'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: LoginTextField(
                          placeholder: "Mobile",
                          inputType: TextInputType.number,
                          initialValue: '',
                          onChanged: (value) {
                            setState(() {
                              _userModel.number = value!;
                            });
                          },
                          isRequired: true,
                          prefix: Container(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.phone,
                                color: Colors.grey.shade600,
                              )),
                          field: 'mobile'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: LoginTextField(
                          placeholder: "E-mail",
                          inputType: TextInputType.emailAddress,
                          initialValue: '',
                          onChanged: (value) {
                            setState(() {
                              _userModel.emailId = value!;
                            });
                          },
                          isRequired: true,
                          prefix: Container(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.email,
                                color: Colors.grey.shade600,
                              )),
                          field: 'email'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    PasswordWidet(
                      placeholder: "Password",
                      inputType: TextInputType.text,
                      width: double.infinity,
                      borderRadius: 10,
                      initialValue: '',
                      field: "password",
                      onChanged: (value) {
                        setState(() {
                          _userModel.password = value!;
                        });
                      },
                    ),
                    // SizedBox(
                    //   child: LoginTextField(
                    //       placeholder: "Password",
                    //       inputType: TextInputType.name,
                    //       initialValue: '',
                    //       isRequired: true,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           _userModel.password = value!;
                    //         });
                    //       },
                    //       prefix: Container(
                    //           padding: const EdgeInsets.all(10),
                    //           child: Icon(
                    //             Icons.lock,
                    //             color: Colors.grey.shade600,
                    //           )),
                    //       field: 'password'),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Create",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        IconButton(
                            onPressed: _isLoading ? null : _createNewUser,
                            icon: _isLoading
                                ? const SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                : const Icon(
                                    Icons.arrow_circle_right_sharp,
                                    color: Colors.white,
                                    size: 40,
                                  ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void setUsaerId(String usaerId) {
    setState(() {
      ID = usaerId;
    });
  }

  Future<void> _createNewUser() async {
    if (_formKey.currentState!.validate()) {
      UserController().addUser(_userModel, setUsaerId);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LandingScreen(),
          ));
    } else {
      snackbar("Please fill all the fields");
    }
  }

  void snackbar(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(50.0),
        content: Text(message),
      ),
    );
  }
}
