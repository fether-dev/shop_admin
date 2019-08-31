import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:imgpic/AddStock.dart';
import 'package:imgpic/report.dart';
import 'package:imgpic/tamil_addstock.dart';
import 'package:imgpic/tamil_report.dart';
import 'package:imgpic/tamil_view.dart';
import 'package:imgpic/view.dart';
import 'package:path/path.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;  
import 'dart:math' as Math;

import 'main.dart';
 


  class Tamil_main extends StatefulWidget {
    @override
    _Tamil_mainState createState() => _Tamil_mainState();
  }

  class _Tamil_mainState extends State<Tamil_main> {

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
          int currentIndex=1;

    getCurrentFragment(){
    switch (currentIndex) {
      case 1:
      //return Fpage();
      break;
      case 2:
    // return Men();
      break;
      case 3:
    //  return Women();
      break;
      case 4:
    //  return Kids();
      break;
    }  
  }
  setCurrentIndex(int index){
    setState(() {
      currentIndex=index;
    });
   // Navigator.of(context).pop();
  }
    @override
  void initState() {
    //image =  widget.list[widget.index]['gender'];
      super.initState();
  }

    Widget build(BuildContext context) {
       return new WillPopScope(
    onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: Text("பொருள் விவரங்களைக் காண்க",softWrap: true,overflow: TextOverflow.visible,style:new TextStyle(fontSize: 15.0,  ),
        
          ),  automaticallyImplyLeading: false,

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
                          builder: (BuildContext context) => new Tamil_ReportsData(
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
                          builder: (BuildContext context) => new MyHomePage(
                          
                          )));
                
                            }, 
                                    ),
                                ],
                              )
                            ],
 
                             ),

         floatingActionButton: FloatingActionButton.extended(
           onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Tamil_AddStack(),
            )),
         icon: Icon(Icons.add_shopping_cart,color: Colors.black,),
         
          // shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 4.0)),
         label: Text("பொருள் சேர்க்கவும்"),
         tooltip: 'ADD STOCKS',
        // highlightColor: Colors.orangeAccent,
        //backgroundColor:Colors.white,
        
         ), 
        body: 
      
                      //getCurrentFragment() 
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
  class ItemList extends StatelessWidget {
    final List list;
    ItemList({this.list});
      var product_image;
   var p_img; 
    @override
      
    Widget build(BuildContext context) {
      return new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return new Container(

            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Tamil_views(
                        list: list,
                        index: i,
                      ))),
              child: new Card(
                child: new ListTile(
                  title: new  Text("${list[i]['product_name']}",style: new TextStyle(fontSize: 18.0,color:Colors.blue,fontWeight: FontWeight.bold),),
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
                          NetworkImage("http://fluttertest.000webhostapp.com/upload/${list[i]['img_name']}"),
                      backgroundColor: Colors.transparent,
                    ),
                  
              
                    //leading: new Image.network("http://fluttertest.000webhostapp.com/upload/${list[i]['img_name']}", width: 100.0, height: 100.0,),
                   subtitle: new Text("கையிருப்பு : ${list[i]['product_stock']}"),
                ),
              ),
            ),
          );
        },
      );
    }
  }
     