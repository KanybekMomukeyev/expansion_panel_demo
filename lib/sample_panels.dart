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
    _data = generateItems(100);
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
          child: _buildPanel(context),
        ),
      ),
    );
  }

  Widget _buildPanel(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        // re render all panel list
        print("expansionCallback called ${index} ${isExpanded}");
        setState(() {
          _data[index].isHeaderExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((ExpansionPanelItem item) {
        // create here widget
        print("Rebuild ExpansionPanelList ${item.expandedValue}");
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

// -----------------------------------------------------------------
// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
// class ExpansionTileSample2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('ExpansionTile'),
//         ),
//         body: ListView.builder(
//           itemBuilder: (BuildContext context, int index) =>
//               EntryItem(data[index]),
//           itemCount: data.length,
//         ),
//       ),
//     );
//   }
// }

// class EntryItem extends StatelessWidget {
//   const EntryItem(this.entry);

//   final Entry entry;

//   Widget _buildTiles(Entry root) {
//     if (root.children.isEmpty) return ListTile(title: Text(root.title));
//     return ExpansionTile(
//       key: PageStorageKey<Entry>(root),
//       title: Text(root.title),
//       children: root.children.map(_buildTiles).toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildTiles(entry);
//   }
// }
