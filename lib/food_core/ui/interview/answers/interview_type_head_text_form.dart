import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/interview_answer_model.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/strings.dart';

class InterviewTypeHeadTextForm extends StatefulWidget {
  final List<InterviewAnswerModel> _interviewAnswers;

  final ValueSetter<InterviewAnswerModel> _suggestionListCallback;

  InterviewTypeHeadTextForm(
      this._interviewAnswers, this._suggestionListCallback);

  @override
  _InterviewTypeHeadTextFormState createState() =>
      _InterviewTypeHeadTextFormState(
          _interviewAnswers, _suggestionListCallback);
}

class _InterviewTypeHeadTextFormState extends State<InterviewTypeHeadTextForm> {
  OverlayEntry _overlayEntry;

  final ValueSetter<InterviewAnswerModel> _suggestionListCallback;

  final List<InterviewAnswerModel> _interviewAnswers;

  final LayerLink _layerLink = LayerLink();

  _InterviewTypeHeadTextFormState(
      this._interviewAnswers, this._suggestionListCallback);

  @override
  void dispose() {
    disposeOverlay();
    super.dispose();
  }

  OverlayEntry _createSuggestionsOverlay(
      List<InterviewAnswerModel> answerSuggestions) {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    final List<Widget> itemList = [];
    for (int i = 0; i < answerSuggestions.length; i++) {
      itemList.add(_getSuggestionItem(answerSuggestions[i], i));
    }

    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: this._layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 5.0),
                child: Material(
                  color: MyColors.white,
                  elevation: 10.0,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 150),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: itemList,
                    ),
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: TextFormField(
          style: GlobalUtils.getTextFormFieldStyle(),
          keyboardType: TextInputType.text,
          onChanged: (value) => onTextChange(value),
          decoration: InputDecoration(
            hintText: Strings.interviewSearchHint,
            hintStyle: GlobalUtils.getHintStyle(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MyColors.lighterGrey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MyColors.lighterGrey),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: MyColors.lighterGrey),
            ),
          )),
    );
  }

  onTextChange(String value) {
    disposeOverlay();

    if (value.length == 0) {
      return;
    }

    final List<InterviewAnswerModel> answerSuggestions = _interviewAnswers
        .where((element) => element.answer.toLowerCase().contains(value))
        .toList();

    _overlayEntry = this._createSuggestionsOverlay(answerSuggestions);
    Overlay.of(context).insert(this._overlayEntry);
  }

  Widget _getSuggestionItem(InterviewAnswerModel suggestion, int position) {
    bool isHighlighted = position % 2 != 0;
    return InkWell(
      onTap: () {
        _suggestionListCallback(suggestion);
        disposeOverlay();
      },
      child: Container(
          alignment: Alignment.centerLeft,
          color: isHighlighted ? Color(0xFFF2FDFF) : Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            suggestion.answer,
            style: GlobalUtils.interviewBody1TextStyle(),
          )),
    );
  }

  void disposeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }
}
