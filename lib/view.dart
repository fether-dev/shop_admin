import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:imgpic/editstock.dart';
import './main.dart';  
class Views extends StatefulWidget{
  List list;
  int index;
  Views({this.index, this.list});
      @override
      _ViewsState createState() => _ViewsState();

    }
// with WidgetsBindingObserver
    class _ViewsState extends State<Views>  {
        void deleteData(){
 // var url="https://fluttertest.000webhostapp.com/delete.php";
    //var url="http://192.168.122.1/ecart/delete.php";
    var url="http://fluttertest.000webhostapp.com/edelete.php";
  http.post(url, body: {
    'id': widget.list[widget.index]['id']
  });
        }
      void confirm (){
  AlertDialog alertDialog = new AlertDialog(
    content: new Text("Are You sure want to delete '${widget.list[widget.index]['product_name']}'"),
    actions: <Widget>[
      new RaisedButton(
        child: new Text("OK DELETE!",style: new TextStyle(color: Colors.black),),
        color: Colors.blueAccent[50],
        onPressed: (){
          deleteData();
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context)=> new MyHomePage(),
            )
          );
        },
      ),
      new RaisedButton(
        child: new Text("CANCEL",style: new TextStyle(color: Colors.black)),
        color: Colors.blueAccent,
        onPressed: ()=> Navigator.pop(context),
      ),
    ],
  );
  showDialog(context: context, child: alertDialog);
      } 
    Future<bool>  confirm1 (){
      showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return WillPopScope(
                                onWillPop: () {},
                                child: new AlertDialog(
                                  title: new Text('Title'),
                                 content: new Text("Are You sure want to update '${widget.list[widget.index]['product_name']}'"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      onPressed: () {
                                        //Function called
                                         Navigator.of(context).pushReplacement(
                        new MaterialPageRoute(        

                          builder: (BuildContext context)=>new EditStock(
                            list: widget.list,
                           index: widget.index,),
                        )
          );
                                      },
                                      child: new Text('Yes!'),
                                    ),
                                    new FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: new Text('No'),
                                    ),
                                  ],
                                ),
                              );
                            });
							
  
    }
   bool isBackButtonActivated = false;
 
  String product_image;
   String p_img;
   
  void initState() {
   
       product_image = widget.list[widget.index]['img_name'];
  
        p_img = 'http://fluttertest.000webhostapp.com/upload/$product_image';
    super.initState();
      // WidgetsBinding.instance.addObserver(this);

  }
  

  Widget build(BuildContext context) {
     return new WillPopScope(
    onWillPop: () async => true,
       child: Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['product_name']}"),  
             /*       actions: <Widget>[
                  Stack(
                    children: <Widget>[
                  
                                InkResponse(
                      
                          child: Icon(Icons.translate),
                            //color: Colors.black,
                            onTap:(){
                                  //load_cart();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Tamil_views(
                              //list: data1,
                            // index: index1,
                          )));
                
                            },  
                                      
                                    ),
                                ],
                              )
                            ], */
      
      ),
      body:
     new Container(
       child:SingleChildScrollView(
       child:Center(
       // height: double.infinity,
       // width: double.infinity,
      // child:SingleChildScrollView(
       child: new Column(
         
       children:<Widget>[

        new Text("PRODUCT DETAILS",textAlign: TextAlign.center, style: new TextStyle(fontSize: 23.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, decoration: TextDecoration.underline, decorationColor: Colors.black, decorationStyle: TextDecorationStyle.double,wordSpacing: 5.3,letterSpacing: 0.0),),
                SizedBox(  height: 20.0,), 
                    CircleAvatar(
                      radius: 150.0,
                      backgroundImage:
                          NetworkImage("http://fluttertest.000webhostapp.com/upload/${widget.list[widget.index]['img_name']}"),
                      backgroundColor: Colors.transparent,
                    ),
                  //  new Container(
                     //         margin: new EdgeInsets.symmetric(horizontal: 1.0),

                 //     padding: EdgeInsets.all(5.0),
                      // new Table(
                                 /*border: new TableBorder(
        verticalInside: new BorderSide(color: Colors.blue[400], width: 5.5),),*/
                                        /*defaultColumnWidth: const FlexColumnWidth(15.0),
                                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                                  columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(100.0),
              1: FixedColumnWidth(110.0),
              2: FixedColumnWidth(125.0),
            },
*/
 
      // children: [
         //MainAxisAlignment:MainAxisAlignment.center,


  Row(
     
  children: [
 
  ]),
 Row(children:[
    Expanded(
          flex: 7   , // 20%
          child:            Text('    Name ',textAlign: TextAlign.center,  style: new TextStyle( fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
         Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${widget.list[widget.index]['product_name']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
   // SizedBox(width: 0.1,),
   /* Text('    Name ', style: new TextStyle(wordSpacing: 1.3,fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),
    Text("  :", style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black, ),),
   //  Text("  : ${widget.list[widget.index]['product_name']}" ,textDirection: TextDirection.ltr, style: new TextStyle(wordSpacing: 1.3,fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

   Text("${widget.list[widget.index]['product_name']} ",  overflow: TextOverflow.visible, softWrap: false, style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),
  */
  ]),
 Row(children:[
    Expanded(
          flex: 7, // 20%
          child:            Text('    Stock ',textAlign: TextAlign.center,  style: new TextStyle( fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
        Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${widget.list[widget.index]['product_stock']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
   // SizedBox(width: 0.1,),Product
    /*Text('    Stock  ', style: new TextStyle(wordSpacing: 1.3,fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),
   Text("  :", style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black, ),),
   //  Text("  : ${widget.list[widget.index]['product_stock']}" ,textDirection: TextDirection.ltr, style: new TextStyle(wordSpacing: 1.3,fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

   Text("${widget.list[widget.index]['product_stock']} ",  overflow: TextOverflow.fade, softWrap: false, style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),
  */
  ]),
 Row(children:[
    Expanded(
          flex: 7, // 20%
          child:            Text('    Price ', textAlign: TextAlign.center, style: new TextStyle( fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
        Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${widget.list[widget.index]['product_price']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
  //  SizedBox(width: 0.1,),
    /*Text('    Price  ',style: new TextStyle(wordSpacing: 1.3,fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),
         Text("  :", style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),
   //Text("  :  ${widget.list[widget.index]['product_price']} "  ,textDirection: TextDirection.ltr, style: new TextStyle(wordSpacing: 1.3,fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

  Text("${widget.list[widget.index]['product_price']} ", overflow: TextOverflow.fade,  softWrap: false, style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),
 */ ]),
  Row(children:[
   // SizedBox(width: 0.1,),
   Expanded(
          flex: 7, // 20%
          child:            Text('    Category ', textAlign: TextAlign.center, style: new TextStyle( fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
          Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${widget.list[widget.index]['category']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
    /*Text('    Category',style: new TextStyle(wordSpacing: 1.3,fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),
 Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black, ),),
   //Text("  : ${widget.list[widget.index]['category']}" ,textDirection: TextDirection.ltr, style: new TextStyle(wordSpacing: 1.3,fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

 Text("${widget.list[widget.index]['category']} ",  overflow: TextOverflow.ellipsis, softWrap: false, style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),
  */
 // ]),
    /*TableRow(children:[
    Text('Product Description  ',textAlign: TextAlign.justify,textDirection: TextDirection.ltr, style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,wordSpacing: 10.0,),),
    Text(" ${widget.list[widget.index]['product_desc']} ",textAlign: TextAlign.justify,textDirection: TextDirection.ltr, style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,wordSpacing: 10.0,),),
  ]),*/
  
]),

            //        ),
  
   //children:<Widget>[] 
   new Column(
                        
               mainAxisAlignment: MainAxisAlignment.spaceAround,
             //    mainAxisSize: MainAxisSize.max,
               crossAxisAlignment: CrossAxisAlignment.stretch,
                
              children: <Widget>[
           
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    
                 new RaisedButton(
                  child: new Text("EDIT DATA"),
                  color: Colors.blueAccent,
                      onPressed: ()=>
                      confirm1()
                     
                    ),

  
                    new RaisedButton(
                      child: new Text("DELETE"),
                      color: Colors.blueAccent,
                      onPressed: ()=>confirm(),
                    ),
  
             
                 
              ],
              
            ),
            ],
       ),
    ] ,    
),
      ), //    ),  
       ),
   
     ),
    ),
     );
  }
  
    }