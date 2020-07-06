import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';

class TestPlugin extends StatefulWidget {
  TestPlugin();

  _TestPluginState createState() => _TestPluginState();
}

/*
          ..width = MediaQuery.of(context).size.width.toString() //'800'
          ..height = MediaQuery.of(context).size.height.toString() //'400'
*/

class _TestPluginState extends State<TestPlugin> {
  String src = """
  <!DOCTYPE html>
  <html>
  <head>
  <title>Page Title</title>
  <style>
  body {
    overflow-x:hidden;
  }
  iframe,
    #error {
      display: none;
    }
    
    #error {
      font-size: 100px;
      background: yellow;
      color: red;
    }
    
    #loading  {
  width:100px;
      height:100px;
      position:absolute;
      top:50%;
      left:50%;
      margin-top:-50px;
      margin-left:-50px;
        }

    #error,
    iframe {


  display: block;       /* iframes are inline by default */
      border: none;         /* Reset default border */
      height: 100vh;        /* Viewport-relative units */
      width: 100vw;


    }
  </style>
  </head>
  <body>
  <script>
  var isTimeout;
    var isLoaded;

    function success() {
      if (isTimeout) {
        return;
      }
      document.getElementById("loading").style.display = 'none';
      document.getElementById("idFrame").style.display = 'block';
      //document.getElementById("error").style.display = 'block';
      isLoaded = true;
    };

    setTimeout(function() {
      if (isLoaded) {
        return;
      }
      document.getElementById("loading").style.display = 'none';
      document.getElementById("idFrame").style.display = 'none';
      document.getElementById("error").style.display = 'block';
      isTimeout = true;
    }, 5000);
  </script>  
  <iframe id="idFrame" src="https://www.figma.com/proto/hD0tJcbZoNvmGwKn1JGV3y/Untitled?node-id=39%3A32&scaling=scale-down"  frameborder="0" onload="success()"></iframe>
  <img id="loading" src="http://50.116.1.85/wordpress/loading.gif" width="193px" height="192px"></img>

  </body>
  </html>
  """;

  //'http://50.116.1.85/wordpress';
  String src3 = 'http://www.youtube.com/embed/IyFZznAk69U';
  static ValueKey key = ValueKey('key_0');
  static ValueKey key2 = ValueKey('key_1');
  static ValueKey key3 = ValueKey('key_2');
  bool _isHtml = true;
  bool _isMarkdown = false;
  bool _useWidgets = false;
  bool _editing = false;
  bool _isSelectable = false;

  bool open = false;

  num position = 1;

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
        appBar: AppBar(
          title: Text('Inteliger Web'),
          leading: IconButton(
            icon: Icon(Icons.access_time),
            onPressed: () {
              setState(() {
                print("Click!");
                open = !open;
              });
            },
            //tooltip: "Menu",
          ),
          actions: <Widget>[
            Builder(builder: (context) {
              return IconButton(
                icon: Icon(_editing ? Icons.close : Icons.settings),
                onPressed: () {
                  if (mounted)
                    setState(() {
                      _editing = !_editing;
                    });
                },
              );
            }),
          ],
        ),

        floatingActionButton: new FloatingActionButton(
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation:    
            FloatingActionButtonLocation.startTop,
        bottomNavigationBar: new BottomAppBar(
          color: Colors.white,
          //child: new Row(...),
        ),


        body: _editing
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SwitchListTile(
                      title: Text('Localização'),
                      value: _isHtml,
                      onChanged: (val) {
                        if (mounted)
                          setState(() {
                            _isHtml = val;
                            if (val) {
                              _isMarkdown = false;
                              src = htmlContent;
                            } else {
                              src = url;
                            }
                          });
                      },
                    ),
                    SwitchListTile(
                      title: Text('Markdown Content'),
                      value: _isMarkdown,
                      onChanged: (val) {
                        if (mounted)
                          setState(() {
                            _isMarkdown = val;
                            if (val) {
                              _isHtml = false;
                              src = markdownContent;
                            } else {
                              src = url;
                            }
                          });
                      },
                    ),
                    SwitchListTile(
                      title: Text('Use Widgets'),
                      value: _useWidgets,
                      onChanged: (val) {
                        if (mounted)
                          setState(() {
                            _useWidgets = val;
                          });
                      },
                    ),
                    SwitchListTile(
                      title: Text('Selectable Text'),
                      value: _isSelectable,
                      onChanged: (val) {
                        if (mounted)
                          setState(() {
                            _isSelectable = val;
                          });
                      },
                    ),
                  ],
                ),
              )
            : Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: EasyWebView(
                              src: src,
                              onLoaded: () {
                                //startLoading("");
                                print('carregou');
                                print("novo" + mounted.toString());
                                //_editing = false;

                                //setState(() {
                                //_editing = true;
                                //});
                              },
                              isHtml: _isHtml,
                              isMarkdown: _isMarkdown,
                              convertToWidgets: _useWidgets,
                              key: key
                              // width: 100,
                              // height: 100,
                              )),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            width: (open) ? 500 : 0,
                            child: EasyWebView(
                                src: src3,
                                onLoaded: () {
                                  print("youtube");
                                  print('$key3: Loaded: $src3');
                                },
                                isHtml: _isHtml,
                                isMarkdown: _isMarkdown,
                                convertToWidgets: _useWidgets,
                                key: key3
                                // width: 100,
                                // height: 100,
                                ),
                          )),
                    ],
                  )
                ],
              ));
  }

  String get htmlContent => """
<!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
</head>
<body>
<h1>This is a Heading</h1>
<p>This is a paragraph.</p>
</body>
</html>
""";

  String get markdownContent => """
# This is a heading
## Here's a smaller heading
This is a paragraph
* Here's a bulleted list
* Another item
1. And an ordered list
1. The numbers don't matter
> This is a qoute
[This is a link to Flutter](https://flutter.dev)
""";

  String get embeedHtml => """
<iframe width="560" height="315" src="https://www.youtube.com/embed/rtBkU4pvHcw?controls=0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
""";

  String get url => 'https://flutter.dev';
}
