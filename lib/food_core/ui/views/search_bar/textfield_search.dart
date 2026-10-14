import 'dart:async';

// stuff for debouncing
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/extensions/search_text_field.dart';
import 'package:food_core/food_core/utils/strings.dart';

class TextFieldSearch extends StatefulWidget {
  final List initialList;
  final TextEditingController controller;
  final Function future;
  final Function getSelectedValue;
  final Function searchPressed;
  final InputDecoration decoration;
  final TextStyle textStyle;
  final int minStringLength;

  const TextFieldSearch(
      {Key key,
        this.initialList,
        @required this.controller,
        @required this.searchPressed,
        this.textStyle,
        this.future,
        this.getSelectedValue,
        this.decoration,
        this.minStringLength = 2 })
      : super(key: key);

  @override
  _TextFieldSearchState createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {
  final FocusNode _focusNode = FocusNode();
  OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List filteredList = [];
  bool hasFuture = false;
  bool loading = false;
  final _debouncer = Debouncer(milliseconds: 1000);
  bool itemsFound;
  bool focused = false;

  void resetList() {
    List tempList = [];
    setState(() {
      // after loop is done, set the filteredList state from the tempList
      this.filteredList = tempList;
      this.loading = false;
    });
    // mark that the overlay widget needs to be rebuilt
    this._overlayEntry.markNeedsBuild();
  }

  void setLoading() {
    if (!this.loading) {
      setState(() {
        this.loading = true;
      });
    }
  }

  void resetState(List tempList) {
    setState(() {
      // after loop is done, set the filteredList state from the tempList
      this.focused = false;
      this.filteredList = tempList;
      this.loading = false;
      // if no items are found, add message none found
      itemsFound = tempList.length == 0 && widget.controller.text.isNotEmpty
          ? false
          : true;
    });
    // mark that the overlay widget needs to be rebuilt so results can show
    this._overlayEntry.markNeedsBuild();
  }

  void updateGetItems() {
    // mark that the overlay widget needs to be rebuilt
    // so loader can show
    this._overlayEntry.markNeedsBuild();
    if (widget.controller.text.length > widget.minStringLength) {
      this.setLoading();
      widget.future().then((value) {
        this.filteredList = value;
        // create an empty temp list
        List tempList = [];
        // loop through each item in filtered items
        for (int i = 0; i < filteredList.length; i++) {
          // lowercase the item and see if the item contains the string of text from the lowercase search
          if (widget.getSelectedValue != null) {
            if (this
                .filteredList[i]
                .value
                .toLowerCase()
                .contains(widget.controller.text.toLowerCase())) {
              // if there is a match, add to the temp list
              tempList.add(this.filteredList[i]);
            }
          } else {
            if (this
                .filteredList[i]
                .toLowerCase()
                .contains(widget.controller.text.toLowerCase())) {
              // if there is a match, add to the temp list
              tempList.add(this.filteredList[i]);
            }
          }
        }
        // helper function to set tempList and other state props
        this.resetState(tempList);
      });
    } else {
      // reset the list if we ever have less than 2 characters
      resetList();
    }
  }

  void updateList() {
    this.setLoading();
    // set the filtered list using the initial list
    this.filteredList = widget.initialList;
    // create an empty temp list
    List tempList = [];
    // loop through each item in filtered items
    for (int i = 0; i < filteredList.length; i++) {
      // lowercase the item and see if the item contains the string of text from the lowercase search
      if (this
          .filteredList[i]
          .toLowerCase()
          .contains(widget.controller.text.toLowerCase())) {
        // if there is a match, add to the temp list
        tempList.add(this.filteredList[i]);
      }
    }
    // helper function to set tempList and other state props
    this.resetState(tempList);
  }

  void initState() {
    super.initState();
    // adding error handling for required params
    if (widget.controller == null) {
      throw ('Error: Missing required parameter: controller');
    }
    if (widget.searchPressed == null) {
      throw ('Error: Missing required parameter: searchPressed');
    }
    // throw error if we don't have an inital list or a future
    if (widget.initialList == null && widget.future == null) {
      throw ('Error: Missing required initial list or future that returns list');
    }
    if (widget.future != null) {
      setState(() {
        hasFuture = true;
      });
    }
    // add event listener to the focus node and only give an overlay if an entry
    // has focus and insert the overlay into Overlay context otherwise remove it
    _focusNode.addListener(() {

      if (_focusNode.hasFocus) {
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);
        setState(() {
          focused = true;
        });
      } else {
        setState(() {
          focused = false;
        });
        this._overlayEntry.remove();
        // check to see if itemsFound is false, if it is clear the input
        // check to see if we are currently loading items when keyboard exists, and clear the input
        if (itemsFound == false || loading == true) {
          // reset the list so it's empty and not visible
          resetList();
          widget.controller.clear();
        }
        // if we have a list of items, make sure the text input matches one of them
        // if not, clear the input
        if (filteredList.length > 0) {
          /*i bool textMatchesItem = false;
          f (widget.getSelectedValue != null) {
            // try to match the label against what is set on controller
            textMatchesItem = filteredList
                .any((item) => item.value == widget.controller.text);
          } else {
            textMatchesItem = filteredList.contains(widget.controller.text);
          }*/
         // if (textMatchesItem == false) widget.controller.clear();
          resetList();
        }
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
   // widget.controller.dispose();
    super.dispose();
  }

  ListView _listViewBuilder(context) {
    if (itemsFound == false) {
      return ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // clear the text field controller to reset it
              widget.controller.clear();
              widget.searchPressed("");
              setState(() {
                itemsFound = false;
              });
              // reset the list so it's empty and not visible
              resetList();
              // remove the focus node so we aren't editing the text
              FocusScope.of(context).unfocus();
            },
            child: ListTile(
              tileColor: Colors.white,
              title: Text(Strings.noResults, style: TextStyle(fontSize: 14.0, color: MyColors.color03)),
              trailing: Icon(Icons.cancel),
            ),
          ),
        ],
      );
    }
    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, i) {
        return GestureDetector(
            onTap: () {
              // set the controller value to what was selected
              setState(() {
                // if we have a label property, and getSelectedValue function
                // send getSelectedValue to parent widget using the label property
                if (widget.getSelectedValue != null) {
                  widget.controller.text = filteredList[i].value;
                  widget.getSelectedValue(filteredList[i]);
                } else {
                  widget.controller.text = filteredList[i];
                }
              });
              // reset the list so it's empty and not visible
              resetList();
              // remove the focus node so we aren't editing the text
              FocusScope.of(context).unfocus();
            },
            child: ListTile(
              trailing: widget.getSelectedValue != null && filteredList[i].brand != null ? Text(filteredList[i].brand.toUpperCase(), style: TextStyle(fontSize: 10.0, color: MyColors.color03, fontWeight: FontWeight.w600)) : null,
              tileColor: (i % 2 == 0) ? Colors.white : MyColors.lightBlue,
              title: widget.getSelectedValue != null
                  ? Text(filteredList[i].value, style: TextStyle(fontSize: 14.0, color: MyColors.color03))
                  : Text(filteredList[i], style: TextStyle(fontSize: 14.0, color: MyColors.color03))));
      },
      padding: EdgeInsets.zero,
      shrinkWrap: true,
    );
  }

  Widget _loadingIndicator() {
    return Container(
      width: 50,
      height: 50,
      child: Center(
        child: CircularProgressIndicator(
          valueColor:
          AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
        ),
      ),
    );
  }

  Widget _listViewContainer(context) {
    if (itemsFound == true && filteredList.length > 0 ||
        itemsFound == false && widget.controller.text.length > 0) {
      double _height = itemsFound == true && filteredList.length > 1 ? 110 : 55;
      return Container(
        height: _height,
        child: _listViewBuilder(context),
      );
    }
    return null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    Size overlaySize = renderBox.size;
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return OverlayEntry(
        builder: (context) => Positioned(
          width: overlaySize.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, overlaySize.height + 10.0),
            child: Material(
              elevation: 6.0,
              borderOnForeground: false,
              borderRadius: BorderRadius.circular(5),
              shadowColor: MyColors.silver.withOpacity(0.8),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: screenWidth,
                    maxWidth: screenWidth,
                    minHeight: 0,
                    // max height set to 150
                    maxHeight: itemsFound == true ? 110 : 55,
                  ),
                  child: loading
                      ? _loadingIndicator()
                      : _listViewContainer(context)),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: TextField(
        controller: widget.controller != null ? widget.controller : null,
        focusNode: this._focusNode,
        decoration: widget.decoration != null ?
          widget.decoration
            :
          SearchTextField.styled(
            Strings.searchText,
            onPressed: () {
              widget.searchPressed(widget.controller.text);
            },
            iconColor: focused ? MyColors.skyBlue : MyColors.searchIcon
          ),
        style: widget.textStyle,
        onSubmitted: (String value) {
          widget.searchPressed(widget.controller.text);
        },
        onChanged: (String value) {
          // every time we make a change to the input, update the list
          _debouncer.run(() {
            setState(() {
              if (hasFuture) {
                updateGetItems();
              } else {
                updateList();
              }
            });
          });
        },
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
