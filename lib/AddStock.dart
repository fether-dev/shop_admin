import 'dart:io';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imgpic/main.dart';
import 'package:imgpic/tamil_addstock.dart';
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

class AddStack extends StatefulWidget {
   
  @override
 
  _AddStackState createState() => new _AddStackState();
}
var selectedDate = DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
var formatted = formatter.format(selectedDate);
class _AddStackState extends State<AddStack> {
   
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
//List data=[];
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
  //int i;
   
  Widget build(BuildContext context) {
     
    return new Scaffold(
       key: scaffoldkey,
      appBar: new AppBar(
        title: new Text("Enter Stock Details"),
         /*  actions: <Widget>[
                  Stack(
                    children: <Widget>[
                      
                                InkResponse(
                      
                          child: Icon(Icons.translate),
                            //color: Colors.black,
                            onTap:(){
                                  //load_cart();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Tamil_AddStack(
                            //  list: data1,
                            // index: index1,
                          )));
                
                            }, 
                                      
                                    ),
                                ],
                              )
           ],*/
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
                          return "please enter Name";
                        } 
                       },
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.add_shopping_cart),
                    labelText: "Enter Name",
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
                          return "please enter Price";
                        } 
                       },
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.payment),
                    labelText: "Enter Price",
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
                          return "please enter Stock";
                        } 
                       },
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.storage),
                    labelText: "Enter Stock",
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
                          return "please enter Description";
                        } 
                       },
                  decoration: new InputDecoration(
                    labelText: "Enter Description",
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
                 /*gridDelegate:
                                           new SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:1,
                                                  childAspectRatio: MediaQuery.of(context).size.width /   (MediaQuery.of(context).size.height / 20),
                                               ),
                                                          controller: new ScrollController(keepScrollOffset: false),*/
               /*  new Text('Select Category'),
                 new ListView.builder(
                                      
                                      //shrinkWrap: true, 
                                            // int bitLengts =0,
               
                                        scrollDirection: Axis.vertical,
                                        itemCount: data.length,
                                       //itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, i) {
                                   // itemCount: data.length.bitLength,
                                      //itemCount: data.length,
                                     //itemCount: 1,
                                       

                                     // itemBuilder: (BuildContext context, int index) {
                                                                               
                                             return     new Container(
                                              child:SingleChildScrollView(
                                            

                                              child:   new Column(
                                                   children: <Widget>[
                                                                   Text('$data'),

                                                         //  new Text('Select Category'),
                DropdownButton<String>(
 
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  //items: <String>['One', 'Two', 'Free', 'Four']
                // items: <String>['BAKERY','BEVERAGES','CANNED','DAIRY','DRY/BAKING GOODS','CLEANERS','PAPERGOODS','PERSONAL CARE','PETCARE']
              items: <String>["${data[i]["category"]}"]

                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
         
                                            
                                              ],

                                                ),
                                      
                                              ) 
                                             );
                                        },
                 ),*/



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
                 /*  DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  //items: <String>['One', 'Two', 'Free', 'Four']
                  items: <String>['BAKERY','BEVERAGES','CANNED','DAIRY','DRY/BAKING GOODS','CLEANERS','PAPERGOODS','PERSONAL CARE','PETCARE']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ), */
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
                  SizedBox(
                  width: 150.0,
                ),
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
                Expanded(child: Container(),),
                 

              ],
            ),
             new Padding(
                  padding: new EdgeInsets.all(8.0),
                ),
                
            RaisedButton(
                  child: Text("Add stock"),
                  onPressed:(){
                     upload(img1);
                    if (formKey.currentState.validate()) {
                       scaffoldkey.currentState.showSnackBar(SnackBar(
                        content: Text("Stock Added Succesfully"),
                      ));
                        Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (contex)=> MyHomePage()
                      ));
                    }else{
                        scaffoldkey.currentState.showSnackBar(SnackBar(
                        content: Text("Stock Added failled "),
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
 