import 'package:flutter/material.dart';
import 'package:expansion_bloc/checkbox_sample.dart';
import 'package:expansion_bloc/models.dart';

class SamplePanelsDemo extends StatefulWidget {
  @override
  _SamplePanelsDemoState createState() => _SamplePanelsDemoState();
}

class _SamplePanelsDemoState extends State<SamplePanelsDemo> {
  List<ExpansionPanelItem> _data;

  @override
  void initState() {
    super.initState();
    _data = generateItems(18);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample panels'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildPanel(),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        // re render all panel list
        setState(() {
          _data[index].isHeaderExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((ExpansionPanelItem item) {
        // create here widget
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return CheckBoxHeader(item);
          },
          body: CheckBoxBody(item),
          isExpanded: item.isHeaderExpanded,
        );
      }).toList(),
    );
  }
}
