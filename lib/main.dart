import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import './AddStock.dart';
import './report.dart';
import './tamil_main.dart';
import './view.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;  
import 'dart:math' as Math;

  void main() => runApp(new MyApp());

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return new MaterialApp(
       title: 'Ecart',   
        debugShowCheckedModeBanner: false, 
         theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: new MyHomePage(),
        
            routes:  <String,WidgetBuilder>{
        '/ReportsData': (BuildContext context)=> new ReportsData(),
      '/AddStack': (BuildContext context)=> new AddStack(),
        '/MyHomePage': (BuildContext context)=> new MyHomePage(),
      },

      );
    }
  }
 
  
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, List list, int index}) : super(key: key);
  final String title;
      List list;
  int index;
 
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

  class _MyHomePageState extends State<MyHomePage> {

  File _image;
  
  TextEditingController cTitle = new TextEditingController();

  Future getImageGallery() async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir =await getTemporaryDirectory();
    final path = tempDir.path;

    int rand= new Math.Random().nextInt(100000);

    Img.Image image= Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, 500);

    var compressImg= new File("$path/image_$rand.jpg")
    ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));


    setState(() {
        _image = compressImg;
      });
  }

  Future getImageCamera() async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir =await getTemporaryDirectory();
    final path = tempDir.path;

    int rand= new Math.Random().nextInt(100000);

    Img.Image image= Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, 500);

    var compressImg= new File("$path/image_$rand.jpg")
    ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));


    setState(() {
        _image = compressImg;
      });
  }    
  Future upload(File imageFile) async{
    
    var stream= new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length= await imageFile.length();
    var uri = Uri.parse("http://fluttertest.000webhostapp.com/eins_img.php");
  //var url = "https://fluttertest.000webhostapp.com/update.php";
    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("fileToUpload", stream, length, filename: basename(imageFile.path)); 
    request.fields['title'] = cTitle.text;
    request.files.add(multipartFile); 

    var response = await request.send();

    if(response.statusCode==200){
      print("Image Uploaded");
    }else{
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
  }
    Future<List> getData() async {
      print('Inside getData');
      await Future.delayed(Duration(seconds: 2));
      final response =
          await http.get("http://fluttertest.000webhostapp.com/eselect_img.php");
          
      if (response.statusCode == 200) {
        print('response.body:' + response.body);
        // await Future.delayed(Duration(seconds: 2));
        return json.decode(response.body);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    }
  String image;
     void _showDialog() {
     showDialog(
      context: this.context,
      builder: (context) => AlertDialog(
            title: Text("No Internet Found!"),
            content: Text("Switch on Mobile Data or Wi-Fi!"),
            actions: <Widget>[FlatButton(child: Text("Ok"), onPressed: () {
              Navigator.pushReplacementNamed(context, '/MyHomePage');
            })],
          ),
    );
  }
    
   
  @override
     void initState() {
    Timer.run(() {
      try {
        InternetAddress.lookup('google.com').then((result) {
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('connected');
          } else {
            _showDialog(); // show dialog
          }
        }).catchError((error) {
          _showDialog(); // show dialog
        });
      } on SocketException catch (_) {
        _showDialog();
        print('not connected'); // show dialog
      }
      
    });
    
    super.initState();
  }


    Widget build(BuildContext context) {
      return new WillPopScope(
    onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: Text("View Stock Details"), automaticallyImplyLeading: false,
           actions: <Widget>[
                  Stack(
                       fit: StackFit.passthrough,
                    children: <Widget>[
                     
                    InkResponse(
                      
                          child: Icon(Icons.receipt),
                            //color: Colors.black,
                            onTap:(){
                                  //load_cart();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new ReportsData(
                            //  list: data1,
                            // index: index1,
                          )));
                
                            }, 
                                      
                                    ),
                      
                          
                                ],
                              ),
                                   Stack(
                       fit: StackFit.passthrough,
                    children: <Widget>[
                     
                    
                                InkResponse(
                      
                          child: Icon(Icons.translate),
                            //color: Colors.black,
                            onTap:(){
                                 
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Tamil_main(
                          
                          )));
                
                            }, 
                                    ),
                                ],
                              )
                            ],
                             ),

         floatingActionButton: FloatingActionButton.extended(
           onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new AddStack(),
            )),
         icon: Icon(Icons.add_shopping_cart,color: Colors.black,),
         
          label: Text("Add Stock"),
         tooltip: 'ADD STOCKS',
     
         ), 
        body: 
      
                      
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List>(
           
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? new ItemList(
                      list: snapshot.data,
                    )
                  : new Center(
                     // child: new CircularProgressIndicator(),
                     child:  new Image.asset('asset/load1.gif',height: 100.0,width: 50.0,),
                    );
            },
    
          ),
        ),
    
      ),  
      );
    }
  }
  class ItemList extends StatefulWidget {
    final List list;
    ItemList({this.list});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
      var product_image;

   var p_img; 

    @override
      
    Widget build(BuildContext context) {
      return new ListView.builder(
        itemCount: widget.list == null ? 0 : widget.list.length,
        itemBuilder: (context, i) {
          return new Container(

            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Views(
                        list: widget.list,
                        index: i,
                      ))),
              child: new Card(
                child: new ListTile(
                  title: new  Text("${widget.list[i]['product_name']}",style: new TextStyle(fontSize: 18.0,color:Colors.blue,fontWeight: FontWeight.bold),),
                //  leading: new Icon(Icons.store_mall_directory),
                /*CircleAvatar(
                radius: 30.0,
                backgroundImage:
                    NetworkImage("${snapshot.data.hitsList[index].previewUrl}"),
                backgroundColor: Colors.transparent,
              )*/
              leading:
                                  CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                          NetworkImage("http://fluttertest.000webhostapp.com/upload/${widget.list[i]['img_name']}"),
                      backgroundColor: Colors.transparent,
                    ),
                  
              
                    //leading: new Image.network("http://fluttertest.000webhostapp.com/upload/${list[i]['img_name']}", width: 100.0, height: 100.0,),
                   subtitle: new Text("Stock : ${widget.list[i]['product_stock']}"),
                ),
              ),
            ),
          );
        },
      );
    }
}
 
 