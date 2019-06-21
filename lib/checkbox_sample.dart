import 'package:flutter/material.dart';
import 'package:expansion_bloc/models.dart';
import 'package:expansion_bloc/logic_bloc.dart';

class CheckBoxBody extends StatelessWidget {
  CheckBoxBody(this.subItem, this.panelItem);
  ExpansionPanelSubItem subItem;
  ExpansionPanelItem panelItem;

  @override
  Widget build(BuildContext context) {
    final FavoriteBloc bloc = BlocProvider.of<FavoriteBloc>(context);
    return StreamBuilder(
      stream: bloc.outUpdateBody.where((UpdateHeaderItem value) {
        return true;
      }),
      initialData: UpdateHeaderItem(),
      builder:
          (BuildContext context, AsyncSnapshot<UpdateHeaderItem> snapshot) {
        if (snapshot.hasData) {
          print("In CheckBoxBody ${subItem.subTitle}");
          return CheckboxListTile(
            value: subItem.isSubSelected,
            onChanged: (bool value) {
              subItem.isSubSelected = value;
              bloc.updateBody(true, panelItem.itemId);

              // ----------------------------------------------------
              var allSelectedSubItems = panelItem.subItems
                  .where((subItem) => subItem.isSubSelected == true);
              if (allSelectedSubItems.length == panelItem.subItems.length) {
                panelItem.isHeaderSelected = true;
                bloc.updateHeader(panelItem.isHeaderSelected, panelItem.itemId);
              } else {
                panelItem.isHeaderSelected = false;
                bloc.updateHeader(panelItem.isHeaderSelected, panelItem.itemId);
              }
              // ----------------------------------------------------
            },
            title: Text(subItem.subTitle),
            controlAffinity: ListTileControlAffinity.leading,
            secondary: Icon(Icons.archive),
            activeColor: Colors.red,
          );
        }
        return Container();
      },
    );
  }
}

class CheckBoxHeader extends StatelessWidget {
  CheckBoxHeader(this.panelItem);
  ExpansionPanelItem panelItem;

  @override
  Widget build(BuildContext context) {
    final FavoriteBloc bloc = BlocProvider.of<FavoriteBloc>(context);
    return StreamBuilder(
      stream: bloc.outUpdateHeader.where((UpdateHeaderItem value) {
        return value.itemId == panelItem.itemId;
      }),
      initialData: UpdateHeaderItem(),
      builder:
          (BuildContext context, AsyncSnapshot<UpdateHeaderItem> snapshot) {
        if (snapshot.hasData) {
          print("In CheckBoxHeader ${panelItem.expandedValue}");
          return CheckboxListTile(
            value: panelItem.isHeaderSelected,
            onChanged: (bool value) {
              panelItem.subItems.forEach((subItem) {
                subItem.isSubSelected = value;
              });
              panelItem.isHeaderSelected = value;

              // -----
              bloc.updateHeader(panelItem.isHeaderSelected, panelItem.itemId);
              bloc.updateBody(panelItem.isHeaderSelected, panelItem.itemId);
              // -----
            },
            title: Text('Header ${panelItem.expandedValue}'),
            controlAffinity: ListTileControlAffinity.leading,
            subtitle: Text('Header Subtitle ${panelItem.expandedValue}'),
            secondary: Icon(Icons.stars),
            activeColor: Colors.blue,
          );
        }
        return Container();
      },
    );
  }
}
