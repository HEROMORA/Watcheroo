import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/edit_profile_validation.dart';
import 'package:watcherooflutter/src/utils/utils.dart';

import '../providers/profile.dart';
import '../widgets/profile_picture_header.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = "/edit-profile";

  @override
  State<StatefulWidget> createState() {
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfileScreen> with Utils {
  bool btnEnabled = false;
  Color accentColor;
  Color bgColor;

  @override
  Widget build(BuildContext context) {
    accentColor = Theme.of(context).accentColor;
    bgColor = Theme.of(context).backgroundColor;
    final userProfile = Provider.of<Profile>(context, listen: false).user;
    Provider.of<EditProfileValidation>(context, listen: false)
        .initValidation(userProfile);
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: buildSaveButton(),
      ),
    );
  }

  Widget buildBody() {
    return ListView(
      children: <Widget>[
        ProfilePictureHeader(
          image:
              'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
          editable: true,
        ),
        Consumer2<Profile, EditProfileValidation>(
          builder: (context, profile, validation, _) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          initialValue: profile.user.firstName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: accentColor,
                              ),
                            ),
                            labelText: 'First Name',
                            errorText: validation.firstName.error,
                          ),
                          onChanged: (value) {
                            validation.changeFirstName(value);
                            setState(() {
                              btnEnabled = true;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: TextFormField(
                          initialValue: profile.user.lastName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: accentColor,
                              ),
                            ),
                            labelText: 'Last Name',
                            errorText: validation.lastName.error,
                          ),
                          onChanged: (value) {
                            validation.changeLastName(value);
                            setState(() {
                              btnEnabled = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  TextFormField(
                    initialValue: profile.user.username,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: accentColor,
                          ),
                        ),
                        labelText: 'Username',
                        errorText: validation.username.error),
                    onChanged: (value) {
                      validation.changeUsername(value);
                      setState(() {
                        btnEnabled = true;
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildSaveButton() {
    return Consumer<EditProfileValidation>(
        builder: (context, editProfileValidation, _) {
      return RaisedButton(
        disabledColor: accentColor,
        disabledTextColor: Colors.white,
        onPressed: !editProfileValidation.isValidSubmit || !btnEnabled
            ? null
            : () {
                try {
                  final updatedFields = editProfileValidation.updatedFields;
                  Provider.of<Profile>(context, listen: false)
                      .updateProfile(updatedFields);
                } catch (err) {
                  showError(err, context);
                }
              },
        child: Text('Save'),
      );
    });
  }

  
}
