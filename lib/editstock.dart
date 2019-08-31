import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:imgpic/main.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'dart:math' as Math;
Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}
File img1,img2;
 
 var imageFile;
 String dropdownValue;
class EditStock extends StatefulWidget {
  final List list;
  final int index;
  
  EditStock({this.list, this.index});

  @override
  _EditStockState createState() => new _EditStockState();
}
 
class _EditStockState extends State<EditStock> {
 // @override  
 

  TextEditingController product_id = new TextEditingController();
  TextEditingController product_name = new TextEditingController();
  TextEditingController  product_price = new TextEditingController();
  TextEditingController  product_stack = new TextEditingController();
  TextEditingController  product_desc = new TextEditingController();
   Future getImageGallery() async{
  
   imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

  final tempDir =await getTemporaryDirectory();
  final path = tempDir.path;
  int rand= new Math.Random().nextInt(100000);
  Img.Image image= Img.decodeImage(imageFile.readAsBytesSync());
  Img.Image smallerImg = Img.copyResize(image, 500);
 
  var compressImg= new File("$path/image_$rand.jpg")
    ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));
 
  setState(() {
     
      img1 = compressImg;
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
     
      img1 = compressImg;
      
    });
}


 Future upload(File img1) async {
  //print("Image: $img1");
  //print('imagename  $img1');  
  var result;
  print("category:" + dropdownValue);
  var stream = new http.ByteStream(DelegatingStream.typed(img1.openRead()));
  var length = await img1.length();
  //var uri = Uri.parse('https://fluttertest.000webhostapp.com/insert.php');  "http://192.168.122.1/adm_php/delete.php";
   var uri = Uri.parse('http://fluttertest.000webhostapp.com/eupdate_img.php');
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = new http.MultipartFile('fileToUpload', stream, length, filename: basename(img1.path));
  request.files.add(multipartFile);
  request.fields['id'] = product_id.text;
  
  var response = await request.send();

  print(" ===================response code ${response.statusCode}");
  await response.stream.transform(utf8.decoder).listen((value) {
    print(" =====================response value $value");
    result = value;
  });
  //return json.decode(result);
   return response.toString();
 }

  void saveData() {
  
   //  var url = "https://fluttertest.000webhostapp.com/update.php";
    var url = "http://fluttertest.000webhostapp.com/eupdate.php";
    http.post(url, body: {
      "id": product_id.text,
      "product_name": product_name.text,
      "category": dropdownValue,
      "product_stock": product_stack.text,
      "product_price": product_price.text,
      "product_desc": product_desc.text,
      
    });
     
  }
  
       
List data = List();
           Future<String> select_categories() async {
        print('Inside select_categories');
         
        final response =
           await http.get( "http://fluttertest.000webhostapp.com/select_categories.php",
        //   await http.get( "http://192.168.122.1/ecart/disp_pimg.php",
            );
        print("response.body"+response.body);
          var datauser= response.body;
          print("datauser"+datauser);
           if(response.body==datauser)
        {
             setState(() {
        data = json.decode(response.body);
       //  print("response.body"+response.body);
     });
        } 
          return datauser;  
      }  
  @override
  var product_image;
   var p_img;
   
  void initState() {
    //controllerId = new TextEditingController(text: widget.list[widget.index]['id']);
   product_id = new TextEditingController(text: widget.list[widget.index]['id']);
    product_name = new TextEditingController(text: widget.list[widget.index]['product_name']);
    product_price = new TextEditingController(text: widget.list[widget.index]['product_price']);
    product_stack = new TextEditingController(text: widget.list[widget.index]['product_stock']);
    product_desc = new TextEditingController(text: widget.list[widget.index]['product_desc']);
     dropdownValue =  widget.list[widget.index]['category'];
      
       product_image = widget.list[widget.index]['img_name'];
        
       p_img = 'http://fluttertest.000webhostapp.com/upload/$product_image';
    this.select_categories();
    super.initState();
     
  }
  Widget build(BuildContext context) {
   return new Scaffold(
   appBar: new AppBar(
        title: new Text("Edit Stock Details"),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
               /*TextField(
  decoration: InputDecoration(
  hintText: "Enter your name!",
  hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.blue),
  enabledBorder: new OutlineInputBorder(
      borderSide: new BorderSide(color: Colors.blue)),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange),
  ),
  ),
) */
  SizedBox(
                  height: 10.0,
                ),
                  
                  new TextField(
                  controller: product_id,
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.assignment_ind),
                    labelText: "Enter Id",
                    fillColor: Colors.white,
                   
                     enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                     // borderSide: new BorderSide(),
                      borderSide: new BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  //  ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                    new TextField(
                  controller: product_name,
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.add_shopping_cart),
                    labelText: "Enter Name",
                    fillColor: Colors.white,
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                     // borderSide: new BorderSide(),
                      borderSide: new BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                   new TextField(
                  controller: product_price,
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.payment),
                    //labelText: "Enter product_price",
                      labelText: "Enter Price",

                    fillColor: Colors.white,
                   enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                     // borderSide: new BorderSide(),
                      borderSide: new BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),

                new TextField(
                  controller: product_stack,
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.storage),
                    labelText: "Enter Stock",
                    fillColor: Colors.white,
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                     // borderSide: new BorderSide(),
                      borderSide: new BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),  
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                new TextField(
                  controller: product_desc,
                  decoration: new InputDecoration(
                    labelText: "Enter Description",
                    fillColor: Colors.white,
                     
                    icon: const Icon(Icons.assignment),
                   enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                     // borderSide: new BorderSide(),
                      borderSide: new BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                    //Image.network(p_img, width: 150.0, height: 150.0,),
     new Text('Select Category'),
                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                // items: <String>['BAKERY','BEVERAGES','CANNED','DAIRY','DRY/BAKING GOODS','CLEANERS','PAPERGOODS','PERSONAL CARE','PETCARE']       
             items: data.map((item) {
            return new DropdownMenuItem(
             // child: new Text(item['category']),
              value: item['category'].toString(),
              child: Text(item['category'].toString()),
            );
          }).toList(),
                ),
              //   new Image.network(p_img, width: 150.0, height: 150.0,),
                     SingleChildScrollView(
              child: Column(
                
          children: <Widget>[
           Center(
              child: img1==null // &&
              ///?new Image(p_img)
               //p_img==img1
              // Image.network(p_img, width: 150.0, height: 150.0,),
             ? new Image.network(p_img, width: 150.0, height: 150.0,)

             // ? new Image.file(img1,width: 150.0,height: 150.0,)
              : new Image.file(img1,width: 150.0,height: 150.0,),
           ),
            Row(
                    mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                    Text("Modify image ",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                IconButton(
                  icon: Icon(Icons.image,color: Colors.black,),
                  color: Colors.black38,
                  onPressed: getImageGallery,
                ),
                   IconButton(
                  icon: Icon(Icons.camera_alt,color: Colors.black,),
                    color: Colors.black38,
                  onPressed: getImageCamera,
                ),
               /* RaisedButton(
                  child: Icon(Icons.image),
                  onPressed: dispImage,
                ),*/
                Expanded(child: Container(),),
                 

              ],

            ),
                   
          ],
        ),
      ),
            Row(
                    mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
             
                 RaisedButton(
                  child: Text("Save Image"),
                 // child: Icon(Icons.update),
                  color: Colors.blueAccent,
                  onPressed:(){
                   // saveData();
                   
                    upload(img1);
                     
                     //  Navigator.of(context).push(new MaterialPageRoute(
                       // builder: (BuildContext context) => new MyHomePage()));
                  },
                  
                ),
                 RaisedButton(
                  child: Text("Save Data"),
                  color: Colors.blueAccent,
                  onPressed:(){
                   // saveData();
                   
                      
                      saveData();
                      //upload(File(p_img));
                    
                       Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new MyHomePage()));
                  },
                  
                ),
         
              ],
            ),
             
      
        
              ],
            ),
          ],
         ),   
      ),
   );
 }

}
