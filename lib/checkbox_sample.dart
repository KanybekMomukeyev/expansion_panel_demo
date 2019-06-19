import 'package:flutter/material.dart';
import 'package:expansion_bloc/models.dart';
import 'package:expansion_bloc/logic_bloc.dart';

class CheckBoxBody extends StatelessWidget {
  CheckBoxBody(this.panelItem);
  ExpansionPanelItem panelItem;

  @override
  Widget build(BuildContext context) {
    final FavoriteBloc bloc = BlocProvider.of<FavoriteBloc>(context);
    return StreamBuilder(
      stream: bloc.outUpdateBody,
      initialData: true,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          var mappedWidgets =
              panelItem.subItems.map<Widget>((ExpansionPanelSubItem subItem) {
            return CheckboxListTile(
              value: subItem.isSubSelected,
              onChanged: (bool value) {
                final FavoriteBloc bloc =
                    BlocProvider.of<FavoriteBloc>(context);
                subItem.isSubSelected = value;
                bloc.updateBody(true);
                // -------------
                var allSelectedSubItems = panelItem.subItems
                    .where((subItem) => subItem.isSubSelected == true);
                // -------------
                if (allSelectedSubItems.length == panelItem.subItems.length) {
                  panelItem.isHeaderSelected = true;
                  bloc.updateHeader(true);
                } else {
                  panelItem.isHeaderSelected = false;
                  bloc.updateHeader(false);
                }
              },
              title: Text(subItem.subTitle),
              controlAffinity: ListTileControlAffinity.leading,
              secondary: Icon(Icons.archive),
              activeColor: Colors.red,
            );
          }).toList();

          return Column(
            children: mappedWidgets,
          );
        }
        return Container();
      },
    );
  }
}

// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------

class CheckBoxHeader extends StatelessWidget {
  CheckBoxHeader(this.panelItem);
  ExpansionPanelItem panelItem;

  @override
  Widget build(BuildContext context) {
    final FavoriteBloc bloc = BlocProvider.of<FavoriteBloc>(context);
    return StreamBuilder(
      stream: bloc.outUpdateHeader,
      initialData: panelItem.isHeaderSelected,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return CheckboxListTile(
            value: panelItem.isHeaderSelected,
            onChanged: (bool value) {
              panelItem.subItems.forEach((subItem) {
                subItem.isSubSelected = value;
              });
              panelItem.isHeaderSelected = value;
              bloc.updateHeader(panelItem.isHeaderSelected);
              bloc.updateBody(panelItem.isHeaderSelected);
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
