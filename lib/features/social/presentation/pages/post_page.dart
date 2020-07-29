import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:military_hub/config/api_config.dart';
import 'package:military_hub/features/social/domain/entities/enums/post_type.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:military_hub/features/social/domain/usecase/feeds_usecase.dart';
import 'package:military_hub/helpers/helper.dart';
import 'package:military_hub/injection_container.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PostPage extends StatefulWidget {
  final String imagePath;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  PostPage({Key key, this.imagePath}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String _uploadedFileURL;
  String _description;
  ProgressDialog pr;

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.0))),
      focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.0))),
      hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  Future post() async {
    await pr.show();
    if (widget.imagePath != null && widget.imagePath != "") {
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child(API.FeedsDirectoryUrl);
      StorageUploadTask uploadTask =
          storageReference.putFile(File(widget.imagePath));
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadedFileURL = fileURL;
        });
        sl<FeedsUseCase>().createPost(
            currentUser.value.userId,
            _description,
            _uploadedFileURL,
            currentUser.value.latitude,
            currentUser.value.longitude,
            "",
            PostType.textWithImage);
      });
    } else {
      sl<FeedsUseCase>().createPost(
          currentUser.value.userId,
          _description,
          "",
          currentUser.value.latitude,
          currentUser.value.longitude,
          "",
          PostType.text);
    }
    await pr.hide();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text("New post",
            style: Theme.of(context)
                .textTheme
                .headline2
                .merge(TextStyle(letterSpacing: 1.3))
                .merge(TextStyle(fontSize: 13))),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10)
                ],
              ),
              child: Column(
                children: <Widget>[
                  widget.imagePath != null && widget.imagePath != ""
                      ? Container(
                          constraints: BoxConstraints(maxHeight: 350),
                          decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              image: DecorationImage(
                                  image: Helper.loadImageFromFile(
                                      widget.imagePath),
                                  fit: BoxFit.fill)),
                        )
                      : Container(),
                  Padding(
                    child: Stack(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              child: CachedNetworkImage(
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                imageUrl: currentUser.value.profilePicture,
                                placeholder: (context, url) => Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.8),
                                            Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.2),
                                          ])),
                                  child: Icon(
                                    Icons.person,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.8),
                                            Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.2),
                                          ])),
                                  child: Icon(
                                    Icons.person,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            padding: EdgeInsets.only(right: 10)),
                        Container(
                          margin: EdgeInsets.only(left: 70),
                          child: Form(
                            key: widget.formKey,
                            child: Column(
                              children: <Widget>[
                                new TextFormField(
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor),
                                  keyboardType: TextInputType.multiline,
                                  textCapitalization: TextCapitalization.sentences,
                                  maxLines: null,
                                  onSaved: (input) =>
                                      _description = input.trim(),
                                  decoration: getInputDecoration(
                                    hintText: "Describe about the situations",
                                    labelText: "What's going on around you?",
                                  ),
                                  initialValue: "",
                                  validator: (input) => input.trim().length < 3
                                      ? "Invalid description"
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                  Divider(),
                  Padding(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          color: Theme.of(context).accentColor,
                          icon: Icon(Icons.save, size: 20, color: Colors.white),
                          label: Text('Post',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            if (widget.formKey.currentState.validate()) {
                              widget.formKey.currentState.save();
                              post();
                            }
                          },
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(right: 20, bottom: 20, top: 10),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
