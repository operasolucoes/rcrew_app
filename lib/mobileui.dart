import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestPlugin extends StatefulWidget {
  @override
  _TestPluginState createState() => _TestPluginState();
}

class _TestPluginState extends State<TestPlugin> {
  num position = 1;
  bool open = false;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(title: Text("Inteliger Mobile X47")),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Enviar Mensagem'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('SMS'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Whats'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        /*
        floatingActionButton: new FloatingActionButton(
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation:    
            FloatingActionButtonLocation.startTop,
        bottomNavigationBar: new BottomAppBar(
          color: Colors.white,
          //child: new Row(...),
        ),
        */


        body: IndexedStack(index: position, children: <Widget>[
          Center(
              child: Container(
                  width: MediaQuery.of(context).size.width, //'800'
                  height: MediaQuery.of(context).size.height, //'400'
                  child: WebView(
                    initialUrl: 'https://www.figma.com/proto/wyY6f4DLkNU5zLwRwinE4O/Mobile-R-crew?node-id=1%3A2&scaling=min-zoom',
                    javascriptMode: JavascriptMode.unrestricted,
                    key: key,
                    onPageFinished: doneLoading,
                    onPageStarted: startLoading,
                  ))),
          Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          ),
        ]),

        
        
        
        
        );
  }
}
