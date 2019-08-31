import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'dart:core';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:imgpic/main.dart';
import 'package:intl/intl.dart';

import 'orderdetails.dart';
 
class ReportsData extends StatefulWidget {
    @override

    _ReportsDataState createState() => _ReportsDataState();
  }
 
var selectedDate = DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
var formatted = formatter.format(selectedDate);
  class _ReportsDataState extends State<ReportsData> {
  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2101));
    //var formatter1 = new DateFormat('yyyy-MM-dd');
    var formatted1 = formatter.format(picked);
 
    if (formatted1 != null && formatted1 != formatted)
      setState(() {
        print('formatted1'+ formatted1);
        formatted = formatted1;
       // report();
         report_data();
        // selectedDate=formatted1 as DateTime;
      });
  }


   Future report() {
          print("inside report function");
     print("selected date is"+formatted);
    var url = "https://fluttertest.000webhostapp.com/reports.php";
    http.post(url, body: {    
      "date": formatted,
    });
     
  }

 String msg='';
     var data=[];
    /*  Future<String> report_data() async {
        print('Inside report_data');
             print("selected date is"+formatted);

       // await Future.delayed(Duration(seconds: 0));
          
        final response =
           await http.get( "http://fluttertest.000webhostapp.com/reportdata.php?formatted=$formatted",
        //   await http.get( "http://192.168.122.1/ecart/disp_pimg.php",
         
            );
        print("response.body"+response.body);
          setState(() {
        data = json.decode(response.body);
       //  print("response.body"+response.body);
      });
      //print(data[1]["img_name"]);
         if(response.body =="\n0 results\n"){
     print('hello');
       setState(() {
          msg="No bill";
         // Navigator.pushReplacementNamed(context, '/cart');
        });
  }

          return "Success!";  
      }  */
        Future<String> report_data() async {
        print('Inside report_data');
             print("selected date is"+formatted);
        final response =
           await http.get( "http://fluttertest.000webhostapp.com/reportdata.php?formatted=$formatted",
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
   else{
    print('hai');
     setState(() {
         msg="no bill";            
        });
  }
   
          return datauser;  
      }  
void initState() {   
      
     // this.report_data();
    this.report_data();
      super.initState();


      
  }
  
    Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 52) / 2;
    final double itemWidth = size.width / 2;

              return Scaffold(
                  appBar: new AppBar(
                    elevation: 0.1,
                 title: Text('Reports'),),
                            //  resizeToAvoidBottomPadding: false ,
                                body:          
                             new Container(
                               child:SingleChildScrollView(
                                  child:new Column(
                                    children: <Widget>[
                                      new Container(
                                      child:Column(children: <Widget>[
                                          new Text("Daily Report" ,  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

                                          new IconButton(
                                                iconSize: 35.0,
                                                icon: new Icon(
                                                  Icons.date_range,
                                                ),
                                                onPressed: ()  {
                                                  _selectDate(context);
                                                  }
                                              ), 
                                              Text("{$formatted}"),

                                      ],)    //height: 8.0, 
                                          ),
                                  new Container(
                                                      child:   new Column(
                                                   children: <Widget>[
                                                       Table(
              //border: TableBorder.all(width: 5.0, color: Colors.black,style: BorderStyle.solid),
                children: [
                      TableRow(children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                        children: <Widget>[
                          //new Text('USERNAME',style:new TextStyle(fontSize: 20.0,  ),),
                           // new Text('Date',textAlign: TextAlign.center, 
                                 //             style:new TextStyle(fontSize: 20.0,  ),),
                                  new Text('Total Bill', textAlign: TextAlign.center, 
                                              style:new TextStyle(fontSize: 20.0, ),),
                          new Text('Total Amount',textAlign: TextAlign.center, 
                                              style:new TextStyle(fontSize: 20.0,  ),),
                         
                         
                        ],
                      ),
                    )
                  ]),
               
                ],
              ),
                ],
                                                 )
                                  ),
                                  new Container(
                                    width: 20.0,
                                 //  child: new Text("Total: ${data[0]['ototal']}", textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700,color: Colors.red,) ),

                                  ),
                              new GridView.builder(
                                      
                                      shrinkWrap: true, 
                                            // int bitLengts =0,
               
                                        scrollDirection: Axis.vertical,
                                       
                                   // itemCount: data.length.bitLength,
                                      itemCount: data.length.sign,
                                     //itemCount: 1,
                                        gridDelegate:
                                           new SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:1, 
                                                  childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 20),
                                               ),
                                                          controller: new ScrollController(keepScrollOffset: false),

                                      itemBuilder: (BuildContext context, int index) {
                                        //  return new GestureDetector(
                                        //    child: new Container(
                                         //         height: 10.0,
                                         //     child: new Card(
                                                  //  color: Colors.white,                                            
                                             return     new Container(
                                              child:SingleChildScrollView(
                                            //   color: Colors.pinkAccent[400],

                                              child:   new Column(
                                                   children: <Widget>[
 
                                             Row(children:[
         
     
       
         Expanded(
          flex: 25, // 20%
          child:         Text("        ${data[index]['billcount']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
          Expanded(
          flex: 20, // 20%
          child:       Text("                 ${data[index]['ototal']} ",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
 
  ]),
                      
                                              ],
                                                 ),
     

       
                                                      
                                              
                                               
                                                   

                                                ),
                                      
                                                  
                                             );
                                        },
                                      ),
                
   // new Container(
                                    //width: 20.0,
                               //    child: new Column(
                               //      children: <Widget>[
                                        new Container(
                                                      child:   new Column(
                                                   children: <Widget>[
                                                       Table(
              //border: TableBorder.all(width: 5.0, color: Colors.black,style: BorderStyle.solid),
                children: [
                      TableRow(children: [
                    TableCell(
                      child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text('UserName',textAlign: TextAlign.center, 
                                              style:new TextStyle(fontSize: 15.0,  ),),
                           new Text('Bill Id',textAlign: TextAlign.center, 
                                              style:new TextStyle(fontSize: 15.0,  ),),
                          
                          new Text('Amount', textAlign: TextAlign.center, 
                                              style:new TextStyle(fontSize: 15.0, ),),
                          new Text('Status', textAlign: TextAlign.center, 
                                              style:new TextStyle(fontSize: 15.0, ),),

                         
                        ],
                      ),
                    )
                  ]),
               
                ],
              ),
                ],
                                                 )
                                  ),
                                                   new GridView.builder(
                                      
                                      shrinkWrap: true, 
                                            // int bitLengts =0,
               
                                        scrollDirection: Axis.vertical,
                                       
                                   // itemCount: data.length.bitLength,
                                      itemCount: data.length,
                                     //itemCount: 1,
                                        gridDelegate:
                                           new SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:1, 
                                      childAspectRatio: MediaQuery.of(context).size.width /(MediaQuery.of(context).size.height / 10),

                                               ),
                                                          controller: new ScrollController(keepScrollOffset: false),

                                      itemBuilder: (BuildContext context, int index) {
                                          return new GestureDetector(
                                            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Orderdetails(
                        list: data,
                        index: index,
                      )))
                      
                      ,
                                        //    child: new Container(
                                         //         height: 10.0,
                                         //     child: new Card(
                                                  //  color: Colors.white,                                            
                                                 child:  new Container(
                                              child:SingleChildScrollView(
                                            //   color: Colors.pinkAccent[400],

                                              child:   new Column(
                                                   children: <Widget>[

     
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                   children:[

         Expanded(
         //flex: 30, // 20%
          child:       Text("   ${data[index]['user_name']} ", softWrap: false, overflow: TextOverflow.visible,style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
       Expanded(
        /*child: InkWell(
          child:  Text("${data[index]['bill_id']} ",textAlign: TextAlign.center, style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.blue,),),
                onTap:(){
                                  //load_cart();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Orderdetails(
                            //  list: data1,
                            // index: index1,
                          )));
                
                            }, 
                                     
        )*/
        //  flex: 15, // 20%
          child:       Text("          ${data[index]['bill_id']} ", style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
     
         Expanded(
         // flex: 15, // 20%
          child:         Text("       ${data[index]['Overall_total']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
        Expanded(
         // flex: 15, // 20%
          child:         Text("    ${data[index]['status']} ", style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), 
  ]),
              
                                            
                                              ],
                                                 ),
 
                                              
                                               
                                                   

                                                ),
                                      
                                             )    
                                             );
                                        },
                                      ),
              

                                    ],
                                  )
                                )                      
              ) 
                                 
                          );
              
                                }
 
  }
