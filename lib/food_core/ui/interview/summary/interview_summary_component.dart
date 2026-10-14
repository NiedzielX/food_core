import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/interview_question_model.dart';
import 'package:food_core/food_core/model/interview_summary_model.dart';
import 'package:food_core/food_core/ui/dashboard/dashboard_component.dart';
import 'package:food_core/food_core/ui/interview/questions/interview_questions_component.dart';
import 'package:food_core/food_core/ui/interview/summary/interview_summary_presenter.dart';
import 'package:food_core/food_core/ui/interview/summary/interview_summary_state.dart';
import 'package:food_core/food_core/ui/views/custom_appbar/simple_appbar.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/strings.dart';

class InterviewSummaryPage extends StatefulWidget {
  final InterviewQuestionModel interviewQuestion;

  InterviewSummaryPage(this.interviewQuestion);

  @override
  InterviewSummaryPageState createState() => InterviewSummaryPageState();
}

class InterviewSummaryPageState extends State<InterviewSummaryPage> {
  final InterviewSummaryPresenter _iSummaryPresenter =
      BaseInterviewSummaryPresenter();

  final double _contentPadding = 15;

  @override
  void initState() {
    super.initState();
    _iSummaryPresenter.fetchInterviewSummary(widget.interviewQuestion.id);
  }

  @override
  void dispose() {
    _iSummaryPresenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildSummaryStream(),
    );
  }

  Widget _buildAppBar() {
    return SimpleAppBarWidget(
        AppbarParameters(title: Strings.interviewSummary));
  }

  Widget _buildSummaryStream() {
    return StreamBuilder<InterviewSummaryState>(
        initialData: InterviewSummaryState.LOADING,
        stream: _iSummaryPresenter.getInterviewSummaryStream(),
        builder: (context, snapshot) => _buildInterviewSummary(snapshot.data));
  }

  Widget _buildInterviewSummary(InterviewSummaryState interviewState) {
    switch (interviewState) {
      case InterviewSummaryState.COMPLETED:
        var interviewSummary = _iSummaryPresenter.getInterviewSummary();
        var isInterviewCompleted = interviewSummary.isInterviewCompleted;
        if (isInterviewCompleted) {
          return _buildInterviewCompleted(interviewSummary);
        } else {
          return _buildInterviewInProgress();
        }
        break;
      case InterviewSummaryState.ERROR:
        return _buildInterviewError();
      case InterviewSummaryState.LOADING:
      default:
        return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildInterviewInProgress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Center(
          child: Padding(
            padding: EdgeInsets.all(_contentPadding),
            child: Text(Strings.interviewSummaryInfo,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyColors.darkGrey,
                    fontSize: 20,
                    height: 1,
                    fontWeight: FontWeight.bold)),
          ),
        )),
        Expanded(child: Assets.interviewSummaryImage),
        _resumeInterviewButton()
      ],
    );
  }

  Widget _resumeInterviewButton() {
    return Padding(
      padding: EdgeInsets.only(
          left: _contentPadding,
          right: _contentPadding,
          bottom: _contentPadding),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          Strings.interviewResume.toUpperCase(),
        ),
      ),
    );
  }

  Widget _summarySubmitButton() {
    return Padding(
      padding: EdgeInsets.only(
          left: _contentPadding,
          right: _contentPadding,
          bottom: _contentPadding),
      child: ElevatedButton(
        onPressed: () {
          if (InterviewPage.allowSkipInterview) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => DashboardPage()),
                (r) => false);
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Text(
          Strings.interviewSubmit.toUpperCase(),
        ),
      ),
    );
  }

  Widget _buildInterviewCompleted(InterviewSummaryModel interviewSummary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: EdgeInsets.all(_contentPadding),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - _contentPadding * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(Strings.interviewSummaryGratitude,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.skyBlue,
                            fontSize: 20,
                            height: 1,
                            fontWeight: FontWeight.bold)),
                    Text(interviewSummary.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.darkGrey,
                            fontSize: 20,
                            height: 1,
                            fontWeight: FontWeight.bold)),
                    Text(interviewSummary.description,
                        textAlign: TextAlign.center,
                        style: GlobalUtils.interviewBody1TextStyle(13)),
                    Assets.interviewSummaryImage,
                  ],
                ),
              ),
            ),
          ),
        ),
        _summarySubmitButton()
      ],
    );
  }

  Widget _buildInterviewError() {
    var errorMessage = _iSummaryPresenter.getSummaryErrorMessage() ?? "";
    return Center(
        child: Text(errorMessage, style: GlobalUtils.body1Text(context)));
  }
}
