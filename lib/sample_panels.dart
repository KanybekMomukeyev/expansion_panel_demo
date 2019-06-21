import 'package:flutter/material.dart';
import 'package:expansion_bloc/checkbox_sample.dart';
import 'package:expansion_bloc/models.dart';
import 'package:expansion_bloc/logic_bloc.dart';

class SamplePanelsDemo extends StatelessWidget {
  List<ExpansionPanelItem> _data = generateItems(20);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ExpansionTile'),
          actions: <Widget>[],
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return EntryPage(_data[index]);
          },
          itemCount: _data.length,
        ),
      ),
    );
  }
}

class EntryPage extends StatelessWidget {
  const EntryPage(this.panelItem);
  final ExpansionPanelItem panelItem;

  Widget _buildTiles(ExpansionPanelItem item) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 0.0, top: 0.0),
      child: ExpansionTile(
        initiallyExpanded: item.isHeaderExpanded,
        onExpansionChanged: (bool value) {
          print("object: ${value}");
        },
        key: PageStorageKey<ExpansionPanelItem>(item),
        title: CheckBoxHeader(item),
        children:
            item.subItems.map<CheckBoxBody>((ExpansionPanelSubItem subItem) {
          return CheckBoxBody(subItem, item);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(panelItem);
  }
}
