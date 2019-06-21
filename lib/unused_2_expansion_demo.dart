// ------------------------------------------------------------------------------------------------
// !!!!!!! UNUSED !!!!!!!
// ------------------------------------------------------------------------------------------------

import 'package:flutter/material.dart';

class ExpansionPanelsDemo extends StatefulWidget {
  static const String routeName = '/material/expansion_panels';

  @override
  _ExpansionPanelsDemoState createState() => _ExpansionPanelsDemoState();
}

class _ExpansionPanelsDemoState extends State<ExpansionPanelsDemo> {
  List<DemoItem<dynamic>> _demoItems;

  @override
  void initState() {
    super.initState();

    _demoItems = <DemoItem<dynamic>>[
      DemoItem<String>(
        name: 'Trip',
        value: 'Caribbean cruise',
        hint: 'Change trip name',
        valueToString: (String value) => value,
        builder: (DemoItem<String> item) {
          // ---
          void close() {
            setState(() {
              item.isExpanded = false;
            });
          }

          // ---
          return Form(
            child: Builder(
              builder: (BuildContext context) {
                return CollapsibleBody(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  onSave: () {
                    Form.of(context).save();
                    close();
                  },
                  onCancel: () {
                    Form.of(context).reset();
                    close();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: item.textController,
                      decoration: InputDecoration(
                        hintText: item.hint,
                        labelText: item.name,
                      ),
                      onSaved: (String value) {
                        item.value = value;
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      DemoItem<Location>(
        name: 'Location',
        value: Location.Bahamas,
        hint: 'Select location',
        valueToString: (Location location) => location.toString().split('.')[1],
        builder: (DemoItem<Location> item) {
          void close() {
            setState(() {
              item.isExpanded = false;
            });
          }

          return Form(
            child: Builder(builder: (BuildContext context) {
              return CollapsibleBody(
                onSave: () {
                  Form.of(context).save();
                  close();
                },
                onCancel: () {
                  Form.of(context).reset();
                  close();
                },
                child: FormField<Location>(
                  initialValue: item.value,
                  onSaved: (Location result) {
                    item.value = result;
                  },
                  builder: (FormFieldState<Location> field) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RadioListTile<Location>(
                          value: Location.Bahamas,
                          title: const Text('Bahamas'),
                          groupValue: field.value,
                          onChanged: field.didChange,
                        ),
                        RadioListTile<Location>(
                          value: Location.Barbados,
                          title: const Text('Barbados'),
                          groupValue: field.value,
                          onChanged: field.didChange,
                        ),
                        RadioListTile<Location>(
                          value: Location.Bermuda,
                          title: const Text('Bermuda'),
                          groupValue: field.value,
                          onChanged: field.didChange,
                        ),
                      ],
                    );
                  },
                ),
              );
            }),
          );
        },
      ),
      DemoItem<double>(
        name: 'Sun',
        value: 80.0,
        hint: 'Select sun level',
        valueToString: (double amount) => '${amount.round()}',
        builder: (DemoItem<double> item) {
          void close() {
            setState(() {
              item.isExpanded = false;
            });
          }

          return Form(
            child: Builder(builder: (BuildContext context) {
              return CollapsibleBody(
                onSave: () {
                  Form.of(context).save();
                  close();
                },
                onCancel: () {
                  Form.of(context).reset();
                  close();
                },
                child: FormField<double>(
                  initialValue: item.value,
                  onSaved: (double value) {
                    item.value = value;
                  },
                  builder: (FormFieldState<double> field) {
                    return Slider(
                      min: 0.0,
                      max: 100.0,
                      divisions: 5,
                      activeColor:
                          Colors.orange[100 + (field.value * 5.0).round()],
                      label: '${field.value.round()}',
                      value: field.value,
                      onChanged: field.didChange,
                    );
                  },
                ),
              );
            }),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expansion panels'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            child: ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _demoItems[index].isExpanded = !isExpanded;
                });
              },
              children:
                  _demoItems.map<ExpansionPanel>((DemoItem<dynamic> item) {
                return ExpansionPanel(
                  isExpanded: item.isExpanded,
                  headerBuilder: item.headerBuilder,
                  body: item.build(),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------

@visibleForTesting
enum Location { Barbados, Bahamas, Bermuda }

typedef DemoItemBodyBuilder<T> = Widget Function(DemoItem<T> item);
typedef ValueToString<T> = String Function(T value);

class DualHeaderWithHint extends StatelessWidget {
  const DualHeaderWithHint({
    this.name,
    this.value,
    this.hint,
    this.showHint,
  });

  final String name;
  final String value;
  final String hint;
  final bool showHint;

  Widget _crossFade(Widget first, Widget second, bool isExpanded) {
    return AnimatedCrossFade(
      firstChild: first,
      secondChild: second,
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState:
          isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(left: 24.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                name,
                style: textTheme.body1.copyWith(fontSize: 15.0),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(left: 24.0),
            child: _crossFade(
              Text(value, style: textTheme.caption.copyWith(fontSize: 15.0)),
              Text(hint, style: textTheme.caption.copyWith(fontSize: 15.0)),
              showHint,
            ),
          ),
        ),
      ],
    );
  }
}

class CollapsibleBody extends StatelessWidget {
  const CollapsibleBody({
    this.margin = EdgeInsets.zero,
    this.child,
    this.onSave,
    this.onCancel,
  });

  final EdgeInsets margin;
  final Widget child;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
              ) -
              margin,
          child: Center(
            child: DefaultTextStyle(
              style: textTheme.caption.copyWith(fontSize: 15.0),
              child: child,
            ),
          ),
        ),
        const Divider(height: 1.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: FlatButton(
                  onPressed: onCancel,
                  child: const Text('CANCEL',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: FlatButton(
                  onPressed: onSave,
                  textTheme: ButtonTextTheme.accent,
                  child: const Text('SAVE'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DemoItem<T> {
  DemoItem({
    this.name,
    this.value,
    this.hint,
    this.builder,
    this.valueToString,
  }) : textController = TextEditingController(text: valueToString(value));

  final String name;
  final String hint;
  final TextEditingController textController;
  final DemoItemBodyBuilder<T> builder;
  final ValueToString<T> valueToString;
  T value;
  bool isExpanded = false;

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return DualHeaderWithHint(
        name: name,
        value: valueToString(value),
        hint: hint,
        showHint: isExpanded,
      );
    };
  }

  Widget build() => builder(this);
}

// // -----
// class CheckBoxBody extends StatefulWidget {
//   CheckBoxBody(this.panelItem);
//   ExpansionPanelItem panelItem;

//   @override
//   _CheckBoxBodyState createState() => _CheckBoxBodyState();
// }

// class _CheckBoxBodyState extends State<CheckBoxBody> {
//   Widget build(BuildContext context) {
//     // ------ Widgets -------
//     var mappedWidgets =
//         widget.panelItem.subItems.map<Widget>((ExpansionPanelSubItem subItem) {
//       return CheckboxListTile(
//         value: subItem.isSubSelected,
//         onChanged: (bool value) {
//           setState(() {
//             subItem.isSubSelected = value;
//           });
//           var allSelectedSubItems = widget.panelItem.subItems
//               .where((subItem) => subItem.isSubSelected == true);

//           //print(allSelectedSubItems.length);
//           // -------------------------
//           final FavoriteBloc bloc = BlocProvider.of<FavoriteBloc>(context);
//           if (allSelectedSubItems.length == widget.panelItem.subItems.length) {
//             bloc.updateHeader(true);
//           } else {
//             bloc.updateHeader(false);
//           }
//           // -------------------------
//         },
//         title: Text(subItem.subTitle),
//         controlAffinity: ListTileControlAffinity.leading,
//         secondary: Icon(Icons.archive),
//         activeColor: Colors.red,
//       );
//     }).toList();

//     return Column(
//       children: mappedWidgets,
//     );
//   }
// }

// // ------------------------------------------------------------------------------------------------
// // ------------------------------------------------------------------------------------------------

// class CheckBoxHeader extends StatefulWidget {
//   CheckBoxHeader(this.panelItem);
//   ExpansionPanelItem panelItem;

//   @override
//   _CheckBoxHeaderState createState() => _CheckBoxHeaderState();
// }

// class _CheckBoxHeaderState extends State<CheckBoxHeader> {
//   bool _value = false;
//   void _valueChanged(bool value) {
//     // -------------------------
//     final FavoriteBloc bloc = BlocProvider.of<FavoriteBloc>(context);
//     bloc.updateBody(value);
//     // -------------------------
//     setState(() {
//       _value = value;
//     });
//   }

//   Widget build(BuildContext context) {
//     return CheckboxListTile(
//       value: _value,
//       onChanged: _valueChanged,
//       title: Text('Header ${widget.panelItem.expandedValue}'),
//       controlAffinity: ListTileControlAffinity.leading,
//       subtitle: Text('Header Subtitle ${widget.panelItem.expandedValue}'),
//       secondary: Icon(Icons.stars),
//       activeColor: Colors.blue,
//     );
//   }
// }
// // -----
// class SamplePanelsDemo2 extends StatelessWidget {
//   List<ExpansionPanelItem> _data = generateItems(10);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sample panels'),
//         actions: <Widget>[],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: _buildPanel(context),
//         ),
//       ),
//     );
//   }

//   Widget _buildPanel(BuildContext context) {
//     final FavoriteBloc bloc = BlocProvider.of<FavoriteBloc>(context);
//     return ExpansionPanelList(
//       expansionCallback: (int index, bool isExpanded) {
//         print("expansionCallback called ${index} ${isExpanded}");
//         bloc.updateExpansionList(!isExpanded, _data[index].itemId);
//         // setState(() {
//         //   _data[index].isHeaderExpanded = !isExpanded;
//         // });
//       },
//       children: _data.map<ExpansionPanel>((ExpansionPanelItem item) {
//         print("Rebuild ExpansionPanelList ${item.expandedValue}");
//         return ExpansionPanel(
//           headerBuilder: (BuildContext context, bool isExpanded) {
//             return CheckBoxHeader(item);
//           },
//           body: CheckBoxNewBody(item),
//           isExpanded: item.isHeaderExpanded,
//         );
//       }).toList(),
//     );
//   }
// }
//
// class CheckBoxBody extends StatelessWidget {
//   CheckBoxBody(this.panelItem);
//   ExpansionPanelItem panelItem;

//   @override
//   Widget build(BuildContext context) {
//     final FavoriteBloc bloc = BlocProvider.of<FavoriteBloc>(context);
//     return StreamBuilder(
//       stream: bloc.outUpdateBody.where((UpdateHeaderItem value) {
//         return value.itemId == panelItem.itemId;
//       }),
//       initialData: UpdateHeaderItem(),
//       builder:
//           (BuildContext context, AsyncSnapshot<UpdateHeaderItem> snapshot) {
//         if (snapshot.hasData) {
//           print("In CheckBoxBody ${panelItem.expandedValue}");
//           var mappedWidgets =
//               panelItem.subItems.map<Widget>((ExpansionPanelSubItem subItem) {
//             return CheckboxListTile(
//               value: subItem.isSubSelected,
//               onChanged: (bool value) {
//                 final FavoriteBloc bloc =
//                     BlocProvider.of<FavoriteBloc>(context);
//                 subItem.isSubSelected = value;
//                 bloc.updateBody(true, panelItem.itemId);

//                 // -------------
//                 var allSelectedSubItems = panelItem.subItems
//                     .where((subItem) => subItem.isSubSelected == true);
//                 // -------------
//                 if (allSelectedSubItems.length == panelItem.subItems.length) {
//                   panelItem.isHeaderSelected = true;
//                   bloc.updateHeader(
//                       panelItem.isHeaderSelected, panelItem.itemId);
//                 } else {
//                   panelItem.isHeaderSelected = false;
//                   bloc.updateHeader(
//                       panelItem.isHeaderSelected, panelItem.itemId);
//                 }
//               },
//               title: Text(subItem.subTitle),
//               controlAffinity: ListTileControlAffinity.leading,
//               secondary: Icon(Icons.archive),
//               activeColor: Colors.red,
//             );
//           }).toList();

//           return Column(
//             children: mappedWidgets,
//           );
//         }
//         return Container();
//       },
//     );
//   }
// }

// // ------------------------------------------------------------------------------------------------
// // ------------------------------------------------------------------------------------------------
// // ------------------------------------------------------------------------------------------------
// // ------------------------------------------------------------------------------------------------
// BehaviorSubject<UpdateHeaderItem> _updateExpansionList =
//     BehaviorSubject<UpdateHeaderItem>();
// Sink<UpdateHeaderItem> get inUpdateExpansionList => _updateExpansionList.sink;
// Stream<UpdateHeaderItem> get outUpdateExpansionList =>
//     _updateExpansionList.stream;
// void updateExpansionList(bool shouldSelectAllBody, int itemId) {
//   inUpdateBody
//       .add(UpdateHeaderItem(value: shouldSelectAllBody, itemId: itemId));
// }

// class CheckBoxNewBody extends StatefulWidget {
//   CheckBoxNewBody(this.panelSubItem);
//   ExpansionPanelSubItem panelSubItem;

//   @override
//   _CheckBoxNewBodyState createState() => _CheckBoxNewBodyState();
// }

// class _CheckBoxNewBodyState extends State<CheckBoxNewBody> {
//   @override
//   Widget build(BuildContext context) {
//     final FavoriteBloc bloc = BlocProvider.of<FavoriteBloc>(context);
//     return CheckboxListTile(
//       value: widget.panelSubItem.isSubSelected,
//       onChanged: (bool value) {
//         setState(() {
//           widget.panelSubItem.isSubSelected = value;
//         });
//       },
//       title: Text('Header ${widget.panelSubItem.subTitle}'),
//       controlAffinity: ListTileControlAffinity.leading,
//       secondary: Icon(Icons.stars),
//       activeColor: Colors.blue,
//     );
//   }
// }

// return StreamBuilder(
//   stream: bloc.outUpdateExpansionList.where((UpdateHeaderItem value) {
//     return value.itemId == item.itemId;
//   }),
//   initialData: UpdateHeaderItem(),
//   builder:
//       (BuildContext context, AsyncSnapshot<UpdateHeaderItem> snapshot) {
//     if (snapshot.hasData) {
//       return Container();
//     }
//     return Container();
//   },
// );
