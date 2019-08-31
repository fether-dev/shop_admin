import 'dart:io';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imgpic/main.dart';
import 'package:imgpic/tamil_main.dart';
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

class Tamil_AddStack extends StatefulWidget {
  @override
  _Tamil_AddStackState createState() => new _Tamil_AddStackState();
}
var selectedDate = DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
var formatted = formatter.format(selectedDate);
class _Tamil_AddStackState extends State<Tamil_AddStack> {
   
  TextEditingController product_name = new TextEditingController();
  TextEditingController  product_price = new TextEditingController();
  TextEditingController  product_stack = new TextEditingController();
  TextEditingController  product_desc = new TextEditingController();
    final  formKey=GlobalKey<FormState>();
  final  scaffoldkey = GlobalKey<ScaffoldState>();
  
File img1;
var imageFile;
String dropdownValue;
var blob ;
var image; 
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
  print("Image: $img1");
  var result;
  
  var stream = new http.ByteStream(DelegatingStream.typed(img1.openRead()));
  var length = await img1.length();
 
  var uri = Uri.parse('http://fluttertest.000webhostapp.com/einsert.php');
 // var uri = Uri.parse('http://192.168.122.1/ecart/insert.php');
  var request = new http.MultipartRequest("POST", uri);
print("product_name:"+ product_name.text);
  print("product_price:  " + product_price.text);
  print("product_stock:"+ product_stack.text);
  print("product_desc:" + product_desc.text);
  
  var multipartFile = new http.MultipartFile('fileToUpload', stream, length, filename: basename(img1.path));
  request.files.add(multipartFile);
   request.fields['product_name'] = product_name.text;
   request.fields['product_price'] = product_price.text;
   request.fields['product_stock'] = product_stack.text;
   request.fields['product_desc'] = product_desc.text;
   request.fields['category'] = dropdownValue;
  var response = await request.send();

  print(" ===================response code ${response.statusCode}");
  await response.stream.transform(utf8.decoder).listen((value) {
    print(" =====================response value $value");
    result = value;
  });
  //return json.decode(result);
   return response.toString();
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
void initState() {   
       
    this.select_categories();
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return new Scaffold(
       key: scaffoldkey,
      appBar: new AppBar(
        title: new Text("பொருள்கள் விவரங்களை உள்ளிடவும்", softWrap: true, overflow: TextOverflow.fade,),



      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
                    Form(key: formKey,
                          child:      new Column(
              children: <Widget>[
          
                new TextFormField(
                  controller: product_name,
                         validator: (value){
                        if(value.isEmpty){
                          return "பொருளின் பெயரை உள்ளிடவும்";
                        } 
                       },
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.add_shopping_cart),
                    labelText: "பொருளின் பெயரை உள்ளிடவும்",
                    fillColor: Colors.white,
                    
                     border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                new TextFormField(
                  controller: product_price,
                       validator: (value){
                        if(value.isEmpty){
                          return "பொருளின் விலை உள்ளிடவும்";
                        } 
                       },
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.payment),
                    labelText: "பொருளின் விலை உள்ளிடவும்",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),

                new TextFormField(
                  controller: product_stack,
                       validator: (value){
                        if(value.isEmpty){
                          return "பொருளின் கையிருப்பு உள்ளிடவும்";
                        } 
                       },
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.storage),
                    labelText: "பொருளின் கையிருப்பு உள்ளிடவும்",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                new TextFormField(
                  controller: product_desc,
                       validator: (value){
                        if(value.isEmpty){
                          return "பொருளின் விளக்கம் உள்ளிடவும்";
                        } 
                       },
                  decoration: new InputDecoration(
                    labelText: "பொருளின் விளக்கம் உள்ளிடவும்",
                    fillColor: Colors.white,
                     
                    icon: const Icon(Icons.assignment),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                        color: Color(0x301687), //0xAARRGGBB
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                
     new Text('பிரிவை தேர்வு செய்க'),
                
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
                 
                     SingleChildScrollView(
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           Center(
              child: img1==null           
              ? new Text(" ")
              : new Image.file(img1,width: 150.0,height: 150.0,),
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

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
                /*RaisedButton(
                 child: Icon(Icons.image,color: Colors.white,),
                  color: Colors.black38,
                  onPressed: getImageGallery,
                ),
                 RaisedButton(
                  child: Icon(Icons.camera_alt,color: Colors.white,),
                    color: Colors.black38,
                  onPressed: getImageCamera,
                ),*/
                Expanded(child: Container(),),
                 

              ],
            ),
             new Padding(
                  padding: new EdgeInsets.all(8.0),
                ),
         
            RaisedButton(
                  child: Text("பொருள் சேர்க்கவும்"),
                  onPressed:(){
                     upload(img1);
                    if (formKey.currentState.validate()) {
                       scaffoldkey.currentState.showSnackBar(SnackBar(
                        content: Text("பொருள்கள் வெற்றிகரமாக சேர்க்கப்பட்டது"),
                      ));
                        Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (contex)=> Tamil_main()
                      ));
                    }else{
                        scaffoldkey.currentState.showSnackBar(SnackBar(
                        content: Text("பொருள்கள் சேர்க்கப்பட்டது தோல்வி"),
                      ));
                    }
                    
                    //upload(img1);
                  /*   Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new MyHomePage()));*/
                  },
                  
                ),
                
          ],
        ),
      ),
              ],
            ),
                ),

          ],
        ),
      ),
    );
  }
}
 