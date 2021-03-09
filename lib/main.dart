import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doris App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const _youAre = 'You are';
const _compatible = 'compatible with\nDoris D. Developer.';
enum Gender { Female, Male, Other }
String shorten(Gender gender) => gender.toString().replaceAll("Gender.", "");
enum Relationship {
  Friend,
  OneDate,
  Ongoing,
  Committed,
  Marriage,
}
Map<Relationship, String> show = {
  Relationship.Friend: "Friend",
  Relationship.OneDate: "One date",
  Relationship.Ongoing: "Ongoing relationship",
  Relationship.Committed: "Committed relationship",
  Relationship.Marriage: "Marriage",
};

List<DropdownMenuItem<Relationship>> _relationshipsList = [
  DropdownMenuItem(
    value: Relationship.Friend,
    child: Text(show[Relationship.Friend]),
  ),
  DropdownMenuItem(
    value: Relationship.OneDate,
    child: Text(show[Relationship.OneDate]),
  ),
  DropdownMenuItem(
    value: Relationship.Ongoing,
    child: Text(show[Relationship.Ongoing]),
  ),
  DropdownMenuItem(
    value: Relationship.Committed,
    child: Text(show[Relationship.Committed]),
  ),
  DropdownMenuItem(
    value: Relationship.Marriage,
    child: Text(show[Relationship.Marriage]),
  ),
];

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _nameController;
  Gender _genderRadioValue;
  Relationship _dropDownValue;
  bool _suitableAge = false;
  double _loveFlutterSliderValue = 1.0;
  String _messageToUser = "$_youAre NOT $_compatible";
  Image _resultImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _reset();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Are you compatible with Doris?"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTitleImage(),
                _buildNameTextField(),
                _buildAgeSwitch(),
                _buildGendersRadio(),
                _buildRelationshipDropdown(),
                _buildLoveFlutterSlider(),
                _buildSubmitRow(),
              ],
            ),
          ),
        ));
  }

  Widget _buildTitleImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('images/heart.png',width: 75,height: 75,),
        Image.asset('images/broken_heart.jpg',width: 75,height: 75,),
      ],
    );
  }

  Widget _buildNameTextField() {
    return (Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: TextField(
        controller: _nameController,
        decoration: InputDecoration(
          labelText: 'Your name:',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    ));
  }

  Widget _buildCommonBorder({Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: child,
    );
  }

  Widget _buildAgeSwitch() {
    return _buildCommonBorder(
      child: Row(
        children: <Widget>[
          Text("Are you 18 or older?"),
          Switch(
            value: _suitableAge,
            onChanged: _updateAgeSwitch,
          ),
        ],
      ),
    );
  }

  Widget _buildGendersRadio() {
    return _buildCommonBorder(
      child: Row(
        children: [
          Text(shorten(Gender.Male)),
          Radio(
              value: Gender.Male,
              groupValue: _genderRadioValue,
              onChanged: _updateGenderRadio),
          SizedBox(
            width: 25,
          ),
          Text(shorten(Gender.Female)),
          Radio(
              value: Gender.Female,
              groupValue: _genderRadioValue,
              onChanged: _updateGenderRadio),
          SizedBox(
            width: 25,
          ),
          Text(shorten(Gender.Other)),
          Radio(
              value: Gender.Other,
              groupValue: _genderRadioValue,
              onChanged: _updateGenderRadio)
        ],
      ),
    );
  }

  Widget _buildRelationshipDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("What kind of relationship are you looking for?"),
        _buildDropdownButtonRow(),
      ],
    );
  }

  Widget _buildDropdownButtonRow() {
    return (_buildCommonBorder(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DropdownButton(
          items: _relationshipsList,
          onChanged: _updateRelationshipDropdown,
          value: _dropDownValue,
          hint: Text("Select one"),
        ),
        if (_dropDownValue != null)
          FlatButton(
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: _resetDropdown,
          ),
      ],
    )));
  }

  Widget _buildLoveFlutterSlider() {
    return (_buildCommonBorder(
      child: Column(
        children: <Widget>[
          Text("On a scale of 1 to 10, "
              "how much do you love developing Flutter apps?"),
          Slider(
              min: 1.0,
              max: 10.0,
              divisions: 9,
              value: _loveFlutterSliderValue,
              onChanged: _updateLoveFlutterSlider,
              label: '${_loveFlutterSliderValue.toInt()}')
        ],
      ),
    ));
  }

  Widget _buildSubmitRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            child: Text("Submit"),
            onPressed: _updateResults,
          ),
          SizedBox(
            width: 15.0,
          ),
          RaisedButton(
            child: Text("Reset"),
            onPressed: () => setState(_reset),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(_messageToUser, textAlign: TextAlign.center),
                _resultImage ?? SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _reset() {
    _nameController.text = "";
    _suitableAge = false;
    _genderRadioValue = null;
    _dropDownValue = null;
    _loveFlutterSliderValue = 1.0;
    _messageToUser = "";
    _resultImage = null;
  }

  void _updateAgeSwitch(bool value) {
    setState(() {
      _suitableAge = value;
    });
  }

  void _updateGenderRadio(Gender value) {
    setState(() {
      _genderRadioValue = value;
    });
  }

  void _updateRelationshipDropdown(Relationship newValue) {
    setState(() {
      _dropDownValue = newValue;
    });
  }

  void _resetDropdown() {
    setState(() {
      _dropDownValue = null;
    });
  }

  void _updateLoveFlutterSlider(double value) {
    setState(() {
      _loveFlutterSliderValue = value;
    });
  }

  void _updateResults() {
    bool isCompatible = _loveFlutterSliderValue >= 8 && _suitableAge;
    setState(() {
      _resultImage =
          Image.asset(isCompatible ? "images/heart.png" : "images/broken_heart.jpg",height: 75,width: 75,);
      _messageToUser = _nameController.text +
          "\n" +
          _youAre +
          (isCompatible ? " " : " NOT ") +
          _compatible;
    });
  }
}
