import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import './main.dart';  
class Tamil_Orderdetails extends StatefulWidget{
  List list;
  int index;
  Tamil_Orderdetails({this.index, this.list});
      @override
      _Tamil_OrderdetailsState createState() => _Tamil_OrderdetailsState();

    }
 
    class _Tamil_OrderdetailsState extends State<Tamil_Orderdetails>  {
  @override
    void initState() {
  //this.load_user();
    super.initState();
  }
 
 

    
    String bill_id,user_name,date;
    
     Future<List> view_order() async {
    print('Inside view_order()');
   print("date"+widget.list[widget.index]['date']);
   print("user_name"+widget.list[widget.index]['user_name']);
     bill_id = widget.list[widget.index]['bill_id'];
      user_name = widget.list[widget.index]['user_name'];
     date= widget.list[widget.index]['date'];
  var  response =   await http.get('http://fluttertest.000webhostapp.com/order.php?user_name=$user_name&date=$date');
     if (response.statusCode == 200) {
      print('response.body:' + response.body);
 
       await Future.delayed(Duration(seconds: 2));
    
      {
           return json.decode(response.body);
           
      }
      
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
      
    }  
  }
   Widget build(BuildContext context) {
          List list;
          //     Size screenSize = MediaQuery.of(context).size;
     return Scaffold(
          appBar: new AppBar(title: new Text('விநியோக பொருள்களின் விவரம் ', softWrap: true, overflow: TextOverflow.fade,style: new TextStyle(
              fontSize: 15.0,
            ),),backgroundColor: Colors.blue,
            ),
                  resizeToAvoidBottomPadding: false,
          
       body:
      // SingleChildScrollView(
 
         new   Container(
              height:600.0,
             child:new Center(
               
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[
      //   Expanded(
          Flexible(
           // Expanded(
        //  padding: const EdgeInsets.all(8.0),
           
            child: FutureBuilder<List>(
              
            future: view_order(),
            builder: (context, snapshot) {   
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new Container(       
                  //  child: SingleChildScrollView(     
                    //   height: 100.0,
                           
                    child:
                    new Column(
                      children: <Widget>[
                   ItemList(
                      list: snapshot.data,
                    ),
                                 Column(
                                                 mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  
    
    
         Row(
         //     mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
           children:[
    Expanded(
          flex: 8, // 20%
          child:            Text('பெயர் ',  style: new TextStyle( fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
         Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${snapshot.data[0]['user_name']} ",   style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
   
  ]),
       Row(children:[
    Expanded(
          flex: 8   , // 20%
          child:            Text('முகவரி ',   style: new TextStyle( fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
         Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${snapshot.data[0]['address']} ",   style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
   
  ]),
        Row(children:[
    Expanded(
          flex: 8   , // 20%
          child:            Text('கைப்பேசி ',  style: new TextStyle( fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
         Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${snapshot.data[0]['phno']} ",    style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
   
  ]),   Row(children:[
    Expanded(
          flex: 8   , // 20%
          child:            Text('மொத்தத்தொகை',  style: new TextStyle( fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
         Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${widget.list[widget.index]['Overall_total']} ",     style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
   
  ]),
                                ],
                                              ),
                  new RaisedButton(//
                  child: new Text("விநியோகம் செய்", textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),),
                  color: Colors.lightBlue,
                      onPressed: (){
                        update_bill()    {
                          print('Inside update_bill ');
                          
                        print("snapshot.data[0]['user_name']"+snapshot.data[0]['user_name']);
                        print("widget.list[widget.index]['date']"+widget.list[widget.index]['date']);
                             var url="http://fluttertest.000webhostapp.com/eupdate_bill.php";
                            //var url="http://192.168.122.1/ecart/insert_bill.php";
                            http.post(url, body: {
                            "username"  : snapshot.data[0]['user_name'],
                            "date"  : widget.list[widget.index]['date']
                            
                          });
                          
                        }
     update_bill();
                Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context)=>new MyHomePage(
                        //list :list,
                        //index:i,
                        ),
                       
            )
                  );
                  },),

                                    ],
                    ),
                    //),
                  )
                  : new Center(
                   //   child: new CircularProgressIndicator(),
                  child:  new Image.asset('asset/load4.gif',height: 100.0,width: 150.0,),

                    );
            },
 

          ),
            ),
        //  ),
     
                ],
             ),
               
             ),
  
                
       ),
        
        
            // ),
      //),


      );
    }
 
  }
   
 class ItemList extends StatefulWidget {
      List list;
      int index; 
  

    ItemList({this.list,this.index});

  @override
  ItemListState createState() => ItemListState();
  //_ItemListState createState() => _ItemListState();

}
 
//class _ItemListState extends State<ItemList>  {
 class ItemListState extends State<ItemList>  {
 int cart_count;

  int index;
      String order_id;
String id;
  
 
   Widget build(BuildContext context) {
   
          
      return new  Flexible(
          
        child:  new ListView.builder(
        scrollDirection: Axis.vertical,
        //shrinkWrap: true,
          itemCount: widget.list == null ? 0 : widget.list.length,
          itemBuilder: (context, i) {
                   return new Container(
                       child:     new GestureDetector(
                           onTap: () {
                     
                                },
                       child: new Card(   
                        // color: Colors.amber,         
                          child: new ListTile(
                           title: 
                            
                            Text("${widget.list[i]['product_name']}",style: new TextStyle(fontSize: 12.0,color:Colors.blue,fontWeight: FontWeight.bold),),
                          //  Text("Price : ${widget.list[i]['product_price']}",style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                                                       
                             subtitle:
                        Text("எண்ணிக்கை : ${widget.list[i]['qty']}",style:new TextStyle(fontSize: 12.0,color:Colors.blue,fontWeight: FontWeight.bold),),
                        ///Text("Total : ${widget.list[i]['total']}",style:new TextStyle(fontSize: 15.0,color:Colors.blue,fontWeight: FontWeight.bold),),

                         leading: 
          CircleAvatar(
                                maxRadius: 30.0,
                                backgroundImage:
                                 NetworkImage("http://fluttertest.000webhostapp.com/upload/${widget.list[i]['img_name']}"),
                               //NetworkImage("http://192.168.122.1/ecart/upload/${widget.list[i]['img_name']}"),
                                backgroundColor: Colors.transparent,
                              ),
 
trailing:                         Text("விலை : ${widget.list[i]['product_price']}",style:new TextStyle(fontSize: 12.0,color:Colors.blue,fontWeight: FontWeight.bold),),

                ),
            
              ),

            ),
           // ),     
                     
          );  
         
        },
        )
          
      );
    
 
     
  }
  
}
 

     