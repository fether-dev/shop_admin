import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:imgpic/tamil_editstock.dart';
import 'package:imgpic/tamil_main.dart';
class Tamil_views extends StatefulWidget{
  List list;
  int index;
 Tamil_views({this.index, this.list});
      @override
      _Tamil_viewsState createState() => _Tamil_viewsState();

    }

    class _Tamil_viewsState extends State<Tamil_views>{
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
    content: new Text("கண்டிப்பாக நீக்க விரும்புகிறீர்களா?'${widget.list[widget.index]['product_name']}'"),
    actions: <Widget>[
      new RaisedButton(
        child: new Text("ஆம்",style: new TextStyle(color: Colors.black),),
        color: Colors.blueAccent[50],
        onPressed: (){
          deleteData();
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context)=> new Tamil_main(),
            )
          );
        },
      ),
      new RaisedButton(
        child: new Text("இல்லை ",style: new TextStyle(color: Colors.black)),
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
                                 content: new Text("நீங்கள் நிச்சயமாக புதுப்பிக்க விரும்புகிறீர்களா? '${widget.list[widget.index]['product_name']}'"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      onPressed: () {
                                        //Function called
                                         Navigator.of(context).pushReplacement(
                        new MaterialPageRoute(        

                          builder: (BuildContext context)=>new Tamil_EditStock(
                            list: widget.list,
                           index: widget.index,),
                        )
          );
                                      },
                                      child: new Text('ஆம்!'),
                                    ),
                                    new FlatButton(
                                      onPressed: () {
                                            Navigator.pop(context);
                                      },
                                      child: new Text('இல்லை'),
                                    ),
                                  ],
                                ),
                              );
                            });
							
  
    }
 /*void confirm1 (){
  AlertDialog alertDialog = new AlertDialog(
    content: new Text("நீங்கள் நிச்சயமாக புதுப்பிக்க விரும்புகிறீர்களா? '${widget.list[widget.index]['product_name']}'"),
    actions: <Widget>[
      new RaisedButton(
        child: new Text("ஆம்",style: new TextStyle(color: Colors.black),),
       // color: Colors.blueAccent[50],
        onPressed: (){
         // deleteData();
          Navigator.of(context).pushReplacement(
                        new MaterialPageRoute(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
                          builder: (BuildContext context)=>new Tamil_EditStock(
                            list: widget.list,
                           index: widget.index,),
                        )
          );
          
        },
      ),
      new RaisedButton(
        child: new Text("இல்லை",style: new TextStyle(color: Colors.black)),
        color: Colors.blueAccent,
        onPressed: ()=> Navigator.pop(context),
      ),
    ],
  );
  showDialog(context: context, child: alertDialog);
 }*/
  @override
  String product_image;
   String p_img;
   
  void initState() {
   
       product_image = widget.list[widget.index]['img_name'];
            //  print('imgname ' +product_image); 
        //        p_img = 'http://192.168.122.1/ecart/upload/$product_image';

        p_img = 'http://fluttertest.000webhostapp.com/upload/$product_image';
        
       //  print('imgurl' + p_img);
    super.initState();
  }
  
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['product_name']}"),
              
      
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

        new Text("பொருள் விவரங்கள்",textAlign: TextAlign.center, style: new TextStyle(fontSize: 23.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, decoration: TextDecoration.underline, decorationColor: Colors.black, decorationStyle: TextDecorationStyle.double,wordSpacing: 5.3,letterSpacing: 0.0),),
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
  //  mainAxisSize: MainAxisSize.max,
    
  children: [
      /* Expanded(
          flex: 7, // 20%
          child:Text('    Id ', textAlign: TextAlign.center, style: new TextStyle( fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
         Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${widget.list[widget.index]['id']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),*/

      //SizedBox(width: 0.1,),
        /*   Text('    Id ', style: new TextStyle(wordSpacing: 1.3,fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),
      Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),
     //Text("  : ${widget.list[widget.index]['id']}",textDirection: TextDirection.ltr, style: new TextStyle(wordSpacing: 1.3,fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),
 
        Text("${widget.list[widget.index]['id']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),
    */
  ]),
 Row(children:[
    Expanded(
          flex: 7   , // 20%
          child:            Text('    பெயர் ',textAlign: TextAlign.center,  style: new TextStyle( fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
         Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${widget.list[widget.index]['product_name']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
   
  ]),
 Row(children:[
    Expanded(
          flex: 7, // 20%
          child:            Text('கையிருப்பு ',textAlign: TextAlign.center,  style: new TextStyle( fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
        Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${widget.list[widget.index]['product_stock']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
 
  ]),
 Row(children:[
    Expanded(
          flex: 7, // 20%
          child:            Text('    விலை ', textAlign: TextAlign.center, style: new TextStyle( fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
        Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${widget.list[widget.index]['product_price']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
  ]),
  Row(children:[
    Expanded(
          flex: 7, // 20%
          child:            Text('    வகை ', textAlign: TextAlign.center, style: new TextStyle( fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
          Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${widget.list[widget.index]['category']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
 
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
                  child: new Text("திருத்தவும்"),
                  color: Colors.blueAccent,
                      onPressed: ()=>
                      confirm1()
                     
                    ),

  
                    new RaisedButton(
                      child: new Text("நீக்கவும்"),
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
    );
  }
  
    }