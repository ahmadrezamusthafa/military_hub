// ignore: must_be_immutable
import 'package:flui/flui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:military_hub/features/social/presentation/bloc/fetch/feeds/bloc.dart';
import 'package:military_hub/features/social/presentation/widgets/empty_list_feeds_widget.dart';
import 'package:military_hub/features/social/presentation/widgets/feeds_list_item_widget.dart';

class FeedsListWidget extends StatelessWidget {
  String heroTag;

  FeedsListWidget({Key key, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetFeedsBloc>(context).add(GetFeedsEvent(
      email: currentUser.value.email,
      password: currentUser.value.password,
      page: 1,
      limit: 10,
    ));
    return BlocBuilder<GetFeedsBloc, FetchState>(
      builder: (context, state) {
        if (state is Empty) {
          return Container(
            child: EmptyListFeedsWidget(),
          );
        } else if (state is ListLoaded) {
          try {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.lists.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 5);
              },
              itemBuilder: (context, index) {
                return FeedsListItemWidget(
                  heroTag: 'feeds_list',
                  post: state.lists.elementAt(index),
                );
              },
            );
          } catch (e) {
            print(e);
          }
          return Container();
        } else if (state is Loading) {
          List<Widget> skeletonItems = [];
          for (int i = 0; i < 3; i++) {
            skeletonItems.add(
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Theme.of(context).hintColor.withOpacity(0.1),
                      )
                    ]),
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: <Widget>[
                    FLSkeleton(
                      shape: BoxShape.circle,
                      margin: EdgeInsets.only(top: 10, left: 10),
                      width: 40,
                      height: 40,
                    ),
                    FLSkeleton(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(2),
                      margin: EdgeInsets.only(left: 60, top: 15, right: 10),
                      height: 14,
                    ),
                    FLSkeleton(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(2),
                      margin: EdgeInsets.only(left: 60, top: 35, bottom: 15),
                      width: 300,
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }
          return Column(
            children: skeletonItems,
          );
        } else if (state is Error) {
          return Text(
            'Error',
          );
        } else {
          return Text('Unreachable');
        }
      },
    );
  }
}
