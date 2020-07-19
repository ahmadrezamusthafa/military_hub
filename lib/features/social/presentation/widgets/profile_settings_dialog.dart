import 'package:flutter/material.dart';
import 'package:military_hub/features/social/domain/entities/user.dart';

class ProfileSettingsDialog extends StatefulWidget {
  User user;
  VoidCallback onChanged;
  int mode;

  ProfileSettingsDialog({Key key, this.user, this.onChanged, this.mode = 0})
      : super(key: key);

  @override
  _ProfileSettingsDialogState createState() => _ProfileSettingsDialogState();
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                titlePadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                title: Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text(
                      "Profile settings",
                      style: Theme.of(context).textTheme.body2,
                    )
                  ],
                ),
                children: <Widget>[
                  Form(
                    key: _profileSettingsFormKey,
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: "Ahmad Reza Musthafa",
                              labelText: "Name"),
                          initialValue: widget.user.name,
                          validator: (input) => input.trim().length < 3
                              ? "Invalid full name"
                              : null,
                          onSaved: (input) => widget.user.name = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: getInputDecoration(
                              hintText: 'reza@gmail.com', labelText: "Email"),
                          initialValue: widget.user.email,
                          validator: (input) =>
                              !input.contains('@') ? "Invalid email" : null,
                          onSaved: (input) => widget.user.email = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: '+6289526357128', labelText: "Phone"),
                          initialValue: widget.user.phoneNumber,
                          validator: (input) =>
                              input.trim().length < 3 ? "Invalid phone" : null,
                          onSaved: (input) => widget.user.phoneNumber = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: "Mojokerto, Indonesia",
                              labelText: "Address"),
                          initialValue: widget.user.address,
                          validator: (input) => input.trim().length < 3
                              ? "Invalid address"
                              : null,
                          onSaved: (input) => widget.user.address = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: "Hey there, i am using ThumbsTalk now",
                              labelText: "Status"),
                          initialValue: widget.user.profileStatus,
                          validator: (input) =>
                              input.trim().length < 3 ? "Invalid status" : null,
                          onSaved: (input) => widget.user.profileStatus = input,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                      MaterialButton(
                        onPressed: _submit,
                        child: Text(
                          "Save",
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  SizedBox(height: 10),
                ],
              );
            });
      },
      padding: EdgeInsets.all(0),
      child: widget.mode == 0
          ? Icon(Icons.edit, color: Theme.of(context).primaryColor)
          : Text(
              "Edit",
              style: Theme.of(context).textTheme.body1,
            ),
      shape: StadiumBorder(),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor)),
      hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  void _submit() {
    if (_profileSettingsFormKey.currentState.validate()) {
      _profileSettingsFormKey.currentState.save();
      widget.onChanged();
      Navigator.pop(context);
    }
  }
}
