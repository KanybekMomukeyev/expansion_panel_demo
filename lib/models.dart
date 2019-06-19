import 'dart:math';

// stores ExpansionPanel state information
class ExpansionPanelItem {
  ExpansionPanelItem({
    this.expandedValue,
    this.headerValue,
    this.isHeaderExpanded = false,
    this.isHeaderSelected = false,
    this.subItems = const <ExpansionPanelSubItem>[],
  });

  String expandedValue;
  String headerValue;
  bool isHeaderExpanded;
  bool isHeaderSelected;
  List<ExpansionPanelSubItem> subItems;
}

class ExpansionPanelSubItem {
  ExpansionPanelSubItem({
    this.subTitle,
    this.isSubSelected = false,
  });

  String subTitle;
  bool isSubSelected;
}

List<ExpansionPanelItem> generateItems(int numberOfItems) {
  var rng = Random();
  return List.generate(numberOfItems, (int index) {
    return ExpansionPanelItem(
        headerValue: 'Panel $index',
        expandedValue: 'This is item number $index',
        isHeaderExpanded: false,
        subItems: generateSubItems(rng.nextInt(10)));
  });
}

List<ExpansionPanelSubItem> generateSubItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return ExpansionPanelSubItem(
      subTitle: 'This is subitem number $index',
    );
  });
}
