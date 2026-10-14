import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/extensions/styled_text_field.dart';
import 'package:food_core/food_core/model/menu.dart';
import 'package:food_core/food_core/ui/base/base_state.dart';
import 'package:food_core/food_core/ui/dashboard/profile/edit_profile/edit_profile_presenter.dart';
import 'package:food_core/food_core/ui/dashboard/profile/edit_profile/edit_profile_view.dart';
import 'package:food_core/food_core/ui/password_recovery/password_recovery_state.dart';
import 'package:food_core/food_core/ui/views/custom_appbar/custom_appbar.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/email_validator.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/message_dialog.dart';
import 'package:food_core/food_core/utils/strings.dart';
import 'package:images_picker/images_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends BaseState<EditProfilePage>
    implements EditProfileView {
  static const register_form_spacing =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0);
  static const form_row_spacing_padding = EdgeInsets.fromLTRB(0, 0, 0, 15);
  static const top_bar_height = 80.0;
  static const avatar_size = 105.0;
  static const row_spacing = EdgeInsets.only(left: 15);
  static const row_vertical_spacing = EdgeInsets.only(top: 15);

  EditProfilePresenter presenter;

  TextEditingController _emailField = new TextEditingController();
  TextEditingController _nameField = new TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();

  bool viewLoaded = false;
  String avatar = "";

  _EditProfilePageState() {
    presenter = new BasicEditProfilePresenter();
    presenter.view = this;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        child: CustomAppBar(Strings.editProfile),
        preferredSize: Size.fromHeight(top_bar_height)),
      body: new GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: loadForm()
      )
    );
  }

  Widget loadForm() {
    if (!viewLoaded) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
    height: MediaQuery.of(context).size.height,
    alignment: Alignment.topLeft,
      child: ListView(
        shrinkWrap: false,
        children: <Widget>[
          Padding(padding: row_vertical_spacing),
          Row(
            children: <Widget>[
              Padding(padding: row_spacing),
              Container(
                alignment: Alignment.center,
                width: avatar_size,
                child: CircleAvatar(
                  radius: avatar_size/ 2.0,
                  backgroundColor: MyColors.silver,
                  backgroundImage: getAvatar() != null ? getAvatar().image : null,
                  child: Visibility(visible: getAvatar() == null, child: Assets.camera),
                ),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: new Border.all(
                    color: MyColors.silver,
                    width: 2,
                  ),
                ),
              ),
              Padding(padding: row_spacing),
              avatarAdd(),
              /*GestureDetector(
                child: Text(Strings.changePhoto,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: MyColors.skyBlue,
                      fontSize: 12.0,
                      decoration: TextDecoration.underline)),
                onTap: () async {
                  List<Media> res = await ImagesPicker.openCamera(
                    pickType: PickType.image,
                    cropOpt: CropOption(
                        aspectRatio: CropAspectRatio.wh4x3
                    ),
                  );
                  if (res != null) {
                    presenter.setAvatar(res[0].thumbPath);
                    setState(() {
                      setDataView();
                    });
                  }
                })*/
            ],
          ),
          Padding(padding: row_vertical_spacing),
          editForm(context)
        ],
      ),
    );
  }

  Container editForm(BuildContext context) {
    return Container(
      margin: register_form_spacing,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Text(Strings.nameSurname,
                  textAlign: TextAlign.left,
                  style: GlobalUtils.textFieldStyle(context)),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: form_row_spacing_padding,
                        child: nameFormField(context))),

              ],
            ),
            Row(children: <Widget>[
              Text(Strings.email,
                  textAlign: TextAlign.left,
                  style: GlobalUtils.textFieldStyle(context)),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: form_row_spacing_padding,
                    child: emailFormField(context)
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Image getAvatar() {
    return GlobalUtils.getAvatar(avatar ?? "");
  }

  Widget emailFormField(BuildContext context) {
    return Stack(alignment: Alignment.topRight, children: [
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          presenter.validateEmail(value);
        },
        controller: _emailField..text = presenter.getEmail(),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        focusNode: _emailFocus,
        onFieldSubmitted: (term) {
          _emailFocus.unfocus();
        },
        validator: (value) {
          if ((value == null || value.isEmpty)) {
            return (Strings.required);
          }
          if (!EmailValidator.isValid(value)) {
            return (Strings.incorrectEmail);
          }
          return null;
        },
        decoration: StyledTextField.styled(Strings.emailHint),
      ),
      Positioned(
        top: 17,
        right: 30,
        child: ValueListenableBuilder<bool>(
          valueListenable: presenter.getEmailNotifier(),
          builder: (context, value, child) => _buildTextFormValidImage(value)
        )
      ),
      Positioned(
        top: 5,
        child: StreamBuilder<PasswordRecoveryState>(
          initialData: PasswordRecoveryState.IDLE,
          stream: presenter.getStream().stream,
          builder: (context, snapshot) {
            var state = snapshot.data;
            var inProgress = state == PasswordRecoveryState.IN_PROGRESS;
            return Stack(children: [
              Visibility(
                visible: !inProgress,
                child: Container(
                  child: IconButton(icon: Assets.editDark, onPressed: () {
                    if (inProgress) return;
                    if (_formKey.currentState.validate()) {
                      presenter.edit(_emailField.text, _nameField.text, presenter.getStream());
                      FocusScope.of(context).requestFocus(new FocusNode());
                    }
                  })
                )),
              Visibility(
                visible: inProgress,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              )
          ]);
        })
      ),
    ]);
  }

  Widget avatarAdd() {
    return StreamBuilder<PasswordRecoveryState>(
        initialData: PasswordRecoveryState.IDLE,
        stream: presenter.getStreamAvatar().stream,
        builder: (context, snapshot) {
          var state = snapshot.data;
          var inProgress = state == PasswordRecoveryState.IN_PROGRESS;
          return Stack(
              children: [
            Visibility(
              visible: true,
              child: GestureDetector(
                  child: Text(Strings.changePhoto,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: MyColors.skyBlue,
                        fontSize: 12.0,
                        decoration: TextDecoration.underline)),
                  onTap: () async {
                    List<Media> res = await ImagesPicker.openCamera(
                      pickType: PickType.image,
                      cropOpt: CropOption(
                          aspectRatio: CropAspectRatio.wh4x3
                      ),
                    );
                    if (res != null) {
                      presenter.setAvatar(res[0].thumbPath);
                      presenter.updateAvatar(res[0].thumbPath);
                      setState(() {
                        setDataView();
                      });
                    }
                  })),
            Visibility(
              visible: inProgress,
              child: Positioned(
                top:0,
                left: 30,
                child: SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.0,
                    backgroundColor: Colors.white,
                  ),
                )
              ),
            )
          ]);
        });
  }

  Widget _buildTextFormValidImage(bool isVisible) {
    if (isVisible) {
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Assets.textFormCorrected,
      );
    } else {
      return Container();
    }
  }

  Widget nameFormField(BuildContext context) {
    return Stack(alignment: Alignment.topRight, children: [
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          presenter.validateUserName(value);
        },
        controller: _nameField..text = presenter.getName(),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        focusNode: _nameFocus,
        onFieldSubmitted: (term) {
          _nameFocus.unfocus();
        },
        validator: (value) {
          if ((value == null || value.isEmpty)) {
            return (Strings.required);
          }
          return null;
        },
        decoration: StyledTextField.styled(Strings.nameSurnameHint),
      ),
      Positioned(
        top: 17,
        right: 30,
        child: ValueListenableBuilder<bool>(
          valueListenable: presenter.getUserNameNotifier(),
          builder: (context, value, child) => _buildTextFormValidImage(value)
        )
      ),
      Positioned(
        top: 5,
        child: StreamBuilder<PasswordRecoveryState>(
          initialData: PasswordRecoveryState.IDLE,
          stream: presenter.getStreamUserName().stream,
          builder: (context, snapshot) {
            var state = snapshot.data;
            var inProgress = state == PasswordRecoveryState.IN_PROGRESS;
            return Stack(children: [
              Visibility(
                  visible: !inProgress,
                  child: Container(
                  child: IconButton(icon: Assets.editDark, onPressed: () {
                    if (inProgress) return;
                    if (_formKey.currentState.validate()) {
                      presenter.edit(_emailField.text, _nameField.text, presenter.getStreamUserName());
                      FocusScope.of(context).requestFocus(new FocusNode());
                  }
              })
            )),
            Visibility(
              visible: inProgress,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            )
          ]);
        })
      ),
    ]);
  }

  void selectedElement(CustomMenuItem selected) {}

  @override
  void setDataView() {
    setState(() {
      this.avatar = presenter.getAvatar();
      this.viewLoaded = true;
    });
  }

  @override
  void onSuccess(String message) {
    showMessageDialog(context, message);
  }

  @override
  void onError(String message) {
    showMessageDialog(context, message);
  }
}
