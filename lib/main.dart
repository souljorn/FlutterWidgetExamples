import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_project_personal/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (_) => ThemeProvider(isLightTheme: false),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeProvider.getThemeData,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait ? _buildVerticalLayout() : _buildHorizontalLayout();
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildVerticalLayout() {
    //return safeAreaWidget();
    return _disappearingHeaderWithWrapGrid();
  }

  Widget _buildHorizontalLayout() {
    return _mediaQueryWidget();
  }

  Widget _buildFlexBoxes() {
    //return safeAreaWidget();
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            fractionalBox(text: "This is a Fractional Box set at 25% ", widthFactor: 0.25),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 100),
              child: Container(
                color: Colors.grey,
                child: Row(children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 6,
                    child: resizableTextWidget(text: "Box 1", color: Colors.orange),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: resizableTextWidget(text: "Box 2", color: Colors.blueGrey),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 4,
                    child: resizableTextWidget(text: "Box 3", color: Colors.redAccent),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlexBoxesWithSpacers() {
    //return safeAreaWidget();
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              color: Colors.deepPurpleAccent,
              height: 200,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5),
              child: Container(
                color: Colors.grey,
                child: Row(children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 6,
                    child: resizableTextWidget(text: "Box 1", color: Colors.orange),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: resizableTextWidget(text: "Box 2", color: Colors.blueGrey),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 4,
                    child: resizableTextWidget(text: "Box 3", color: Colors.redAccent),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget resizableTextWidget({String text, Color color}) {
    const textStyle = TextStyle(fontSize: 30);

    return Container(
      child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: textStyle,
          )),
      color: color,
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
    );
  }

  Widget textWidget({String text, Color color}) {
    const textStyle = TextStyle(fontSize: 30);

    return Container(
      child: Text(
        text,
        style: textStyle,
      ),
      color: color,
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
    );
  }

  Widget fractionalBox({String text, double widthFactor = 1}) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        color: Colors.blue,
        child: Text(
          text,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  Widget safeAreaWidget() {
    return Scaffold(
        body: SafeArea(
      top: true,
      bottom: true,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          child: Text(
            "This widget is below safe area. If you remove the SafeArea "
            "widget then this text will be behind the notch.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        )
      ]),
    ));
  }

  Widget _mediaQueryWidget() {
    return Scaffold(
        body: SafeArea(
      top: true,
      bottom: true,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          child: RichText(
              text: TextSpan(
                  text: "Media Query Data\n",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                TextSpan(
                  text: "Screen Width: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: MediaQuery.of(context).size.width.toString() + " pixels\n",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: "Screen Height: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: MediaQuery.of(context).size.height.toString() + " pixels\n",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: "Text Scale Factor: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: MediaQuery.of(context).textScaleFactor.toString(),
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ])),
        )
      ]),
    ));
  }

  Widget _sizedBoxNoSafeArea() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width / 3,
      child: Container(
        color: Colors.orange,
      ),
    );
  }

  Widget _sizedBox100({Color color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Container(
          color: color,
        ),
      ),
    );
  }

  Widget _sizedBoxSafeArea() {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width / 3,
        child: Container(
          color: Colors.orange,
        ),
      ),
    );
  }

  Widget _alignChildInContainer() {
    return SafeArea(
        child: Container(
      color: Colors.deepPurpleAccent,
      height: 200,
      width: 200,
      child: Text("Text To Align"),
      alignment: Alignment(-.7, -.3),
    ));
  }

  Widget _shrinkableHeader() {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Collapsing Toolbar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    "https://images.pexels.com/photos/305821/pexels-photo-305821.jpeg?auto=compress&cs=tinysrgb&h=350",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Center(
          child: Text("Sample Text"),
        ),
      ),
    );
  }

  Widget _disappearingHeader() {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Collapsing Toolbar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      "https://images.pexels.com/photos/305821/pexels-photo-305821.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    )),
              ),
              new SliverPadding(
                padding: new EdgeInsets.all(16.0),
                sliver: new SliverList(
                  delegate: new SliverChildListDelegate([
                    TabBar(
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        new Tab(icon: new Icon(Icons.info), text: "Tab 1"),
                        new Tab(icon: new Icon(Icons.lightbulb_outline), text: "Tab 2"),
                      ],
                    ),
                  ]),
                ),
              ),
            ];
          },
          body: Center(
            child: Text("Sample text"),
          ),
        ),
      ),
    );
  }

  Widget _disappearingHeaderWithWrapGrid() {
    final List<Widget> items = <Widget>[
      _sizedBox100(color: Colors.lightGreen),
      _sizedBox100(color: Colors.amber),
      _sizedBox100(color: Colors.cyan),
      _sizedBox100(color: Colors.pink),
      _sizedBox100(color: Colors.deepOrange),
      _sizedBox100(color: Colors.lightGreen),
      _sizedBox100(color: Colors.amber),
      _sizedBox100(color: Colors.cyan),
      _sizedBox100(color: Colors.pink),
      _sizedBox100(color: Colors.deepOrange),
      _sizedBox100(color: Colors.lightGreen),
      _sizedBox100(color: Colors.amber),
      _sizedBox100(color: Colors.cyan),
      _sizedBox100(color: Colors.pink),
      _sizedBox100(color: Colors.deepOrange),
      _sizedBox100(color: Colors.lightGreen),
      _sizedBox100(color: Colors.amber),
      _sizedBox100(color: Colors.cyan),
      _sizedBox100(color: Colors.pink),
      _sizedBox100(color: Colors.deepOrange),
      _sizedBox100(color: Colors.lightGreen),
      _sizedBox100(color: Colors.amber),
      _sizedBox100(color: Colors.cyan),
      _sizedBox100(color: Colors.pink),
      _sizedBox100(color: Colors.deepOrange),
      _sizedBox100(color: Colors.lightGreen),
      _sizedBox100(color: Colors.amber),
      _sizedBox100(color: Colors.cyan),
      _sizedBox100(color: Colors.pink),
      _sizedBox100(color: Colors.deepOrange),
      _sizedBox100(color: Colors.lightGreen),
      _sizedBox100(color: Colors.amber),
      _sizedBox100(color: Colors.cyan),
      _sizedBox100(color: Colors.pink),
      _sizedBox100(color: Colors.deepOrange),
      _sizedBox100(color: Colors.lightGreen),
      _sizedBox100(color: Colors.amber),
      _sizedBox100(color: Colors.cyan),
      _sizedBox100(color: Colors.pink),
      _sizedBox100(color: Colors.deepOrange),
    ];

    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 160.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text("Collapsing Toolbar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      background: Image.network(
                        "https://images.pexels.com/photos/305821/pexels-photo-305821.jpeg?auto=compress&cs=tinysrgb&h=350",
                        fit: BoxFit.cover,
                      )),
                ),
              ];
            },
            body: GridView.builder(
                // Add a key to the ListView. This makes it possible to
                // find the list and scroll through it in the tests.
                gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                key: Key('long_list'),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return items[index];

                }),
          ),
        ),
      ),
    );
  }

  Widget _wrappingWidget() {
    return SafeArea(
      child: Wrap(
        children: <Widget>[
          _sizedBox100(color: Colors.lightGreen),
          _sizedBox100(color: Colors.amber),
          _sizedBox100(color: Colors.cyan),
          _sizedBox100(color: Colors.pink),
          _sizedBox100(color: Colors.deepOrange),
          _sizedBox100(color: Colors.lightGreen),
          _sizedBox100(color: Colors.amber),
          _sizedBox100(color: Colors.cyan),
          _sizedBox100(color: Colors.pink),
          _sizedBox100(color: Colors.deepOrange),
          _sizedBox100(color: Colors.lightGreen),
          _sizedBox100(color: Colors.amber),
          _sizedBox100(color: Colors.cyan),
          _sizedBox100(color: Colors.pink),
          _sizedBox100(color: Colors.deepOrange),
          _sizedBox100(color: Colors.lightGreen),
          _sizedBox100(color: Colors.amber),
          _sizedBox100(color: Colors.cyan),
          _sizedBox100(color: Colors.pink),
          _sizedBox100(color: Colors.deepOrange),
        ],
      ),
    );
  }
}
