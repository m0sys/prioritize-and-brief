import 'package:flutter/material.dart';
import 'package:todo_list/components/accent_color_override/accent_color_override.dart';

class FormPanel extends StatefulWidget {
  FormPanel(
      {@required this.panelTitle,
      @required this.panelLogo,
      @required this.handleFab});
  final String panelTitle;
  final Widget panelLogo;
  final Function handleFab;

  @override
  _FormPanelState createState() => _FormPanelState();
}

class _FormPanelState extends State<FormPanel> {
  final _formKey = GlobalKey<FormState>();
  // Private memeber variables
  String _mInputText;

  // Create textfield controller
  TextEditingController _mTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mInputText = "";
    _mTextController.addListener(this._onTextChange);
  }

  void _onTextChange() {
    this.setState(() {
      _mInputText = _mTextController.text;
    });
  }

  @override
  void dispose() {
    _mTextController.dispose();
    super.dispose();
  }

  void handleValidInput() {
    widget.handleFab(this._mInputText);
    this.setState(() {
      _mInputText = "";
    });
    _mTextController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Get theme instance
    ThemeData localTheme = Theme.of(context);

    return (Scaffold(
        appBar: AppBar(
          title: Text(this.widget.panelTitle),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              this.widget.panelLogo,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AccentColorOverride(
                        color: localTheme.accentColor,
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: this.widget.panelTitle,
                              fillColor: Colors.black),
                          controller: _mTextController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Plese enter some text here!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
                  child: Icon(Icons.add),
                  backgroundColor: localTheme.accentColor,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState.validate()) {
                      // Process data.
                      this.handleValidInput();
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Please type in a ${widget.panelTitle.toLowerCase()}ing message ..."),
                      ));
                    }
                  },
                ))));
  }
}
