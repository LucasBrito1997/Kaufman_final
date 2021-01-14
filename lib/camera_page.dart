import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';
import 'package:intl/intl.dart';
import 'package:oroscopio/main.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:save_in_gallery/save_in_gallery.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'blinkingTimer.dart';
import 'videoUtil.dart';

class Home extends StatefulWidget {
  final WebSocketChannel channel;

  Home({Key key, @required this.channel}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double videoWidth = 640;
  final double videoHeight = 480;

  double newVideoSizeWidth = 640;
  double newVideoSizeHeight = 480;

  bool isLandscape;
  String _timeString;

  bool screenShotButton;

  var teste;

  var _globalKey = new GlobalKey();
  final _imageSaver = ImageSaver();

  Timer _timer;
  bool isRecording;
  final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();

  int frameNum;
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    isLandscape = false;
    isRecording = false;

    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());

    frameNum = 0;
    VideoUtil.workPath = 'imagens oroscopio';
    VideoUtil.getAppTempDirectory();

    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
        message: 'Salvando vídeo...',
        borderRadius: 10,
        backgroundColor: Colors.black,
        progressWidget: CircularProgressIndicator(),
        elevation: 10,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
            color: Colors.white70, fontSize: 17, fontWeight: FontWeight.w300));
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    _timer.cancel();
    super.dispose();
  }

  tirarFoto(snapshot) {
    if (snapshot.data == '1') {
      snapshot = teste;
      takeScreenShot();
    } else {
      teste = snapshot;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OrientationBuilder(builder: (context, orientation) {
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;

          if (orientation == Orientation.portrait) {
            //screenWidth < screenHeight

            isLandscape = false;
            newVideoSizeWidth = screenWidth;
            newVideoSizeHeight = videoHeight * newVideoSizeWidth / videoWidth;
          } else {
            isLandscape = true;
            newVideoSizeHeight = screenHeight;
            newVideoSizeWidth = videoWidth * newVideoSizeHeight / videoHeight;
          }

          return Container(
            color: Colors.black,
            child: StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                tirarFoto(snapshot);
                if (snapshot.connectionState == ConnectionState.done) {
                  Future.delayed(Duration(milliseconds: 100)).then((_) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyHomePage()));
                  });
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  );
                } else {
                  if (snapshot.data != '1' && snapshot.data != null) {
                    if (isRecording) {
                      VideoUtil.saveImageFileToDirectory(
                          snapshot.data, 'image_$frameNum.jpg');
                      frameNum++;
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: isLandscape ? 0 : 30,
                            ),
                            Stack(
                              children: <Widget>[
                                RepaintBoundary(
                                  key: _globalKey,
                                  child: GestureZoomBox(
                                    maxScale: 5.0,
                                    doubleTapScale: 2.0,
                                    duration: Duration(milliseconds: 200),
                                    child: Image.memory(
                                      snapshot.data,
                                      gaplessPlayback: true,
                                      width: newVideoSizeWidth,
                                      height: newVideoSizeHeight,
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                    child: Align(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 46,
                                      ),
                                      isRecording
                                          ? BlinkingTimer()
                                          : Container(),
                                    ],
                                  ),
                                  alignment: Alignment.topCenter,
                                )),
                                Positioned.fill(
                                    child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    _timeString,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ))
                              ],
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.black,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      color: Colors.white,
                    );
                  }
                }
              },
            ),
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: takeScreenShot,
          child: Icon(Icons.camera_alt),
        ));
  }

  takeScreenShot() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();
    final res = await _imageSaver.saveImage(imageBytes: pngBytes);

    Fluttertoast.showToast(
        msg: res ? "Foto Salva" : "Falha na Captura de Imagem",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.greenAccent[300],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy/MM/dd HH:mm:ss').format(dateTime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    Future.delayed(
        Duration.zero,
        () => setState(() {
              _timeString = _formatDateTime(now);
            }));
  }

  Future<int> execute(String command) async {
    return await _flutterFFmpeg.execute(command);
  }
}
