import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';

class UserAvatarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
            ),
            width: 45,
            height: 45),
        Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: CachedNetworkImage(
                height: 70,
                width: 70,
                fit: BoxFit.cover,
                imageUrl: currentUser.value.profilePicture,
                placeholder: (context, url) => Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Theme.of(context).focusColor.withOpacity(0.8),
                            Theme.of(context).focusColor.withOpacity(0.2),
                          ])),
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Theme.of(context).focusColor.withOpacity(0.8),
                            Theme.of(context).focusColor.withOpacity(0.2),
                          ])),
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
              ),
            ),
            width: 40,
            height: 40),
        FloatingActionButton(
          backgroundColor: Colors.transparent,
          highlightElevation: 0,
          elevation: 0,
          onPressed: () {},
        )
      ],
      alignment: Alignment(0, 0),
    );
  }
}
