import 'package:flutter/material.dart';
import 'package:maps/Application.dart';
import 'package:provider/provider.dart';
import './locprovider.dart';
class BuildContainer extends StatefulWidget {
  @override
  _BuildContainerState createState() => _BuildContainerState();
}

class _BuildContainerState extends State<BuildContainer> {
  @override
  Widget build(BuildContext context) {
    final placedata=Provider.of<Places>(context,listen: false);
    return Align(
      alignment: Alignment.bottomLeft,
      child:Container(margin: EdgeInsets.symmetric(vertical:20),
      height: 150,
      width:double.infinity,
      child:ListView.builder(scrollDirection: Axis.horizontal,
      itemCount: placedata.items.length,
      itemBuilder: (context,index) {
        
        return Row(children:<Widget>[SizedBox(width:10.0),GestureDetector(child: Container(child:new FittedBox(
          child:Material(color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor:Colors.blue,
          child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(width:150,
            height: 150,
            child:ClipRRect(borderRadius: new BorderRadius.circular(24),
            child:Image(fit: BoxFit.cover,
            image:NetworkImage('https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${placedata.items[index].imagelink}&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo')))),
            myDetails(placedata.items[index].name,placedata.items[index].rating.toString()),
          ],)
          )
        ),))]);
      },)
      )
      
    );
  }
Widget myDetails(String name,String rating)
{
  return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
    Padding(padding: const EdgeInsets.only(left: 8.0),
    child:Container(child: Text(name,style: TextStyle(color: Colors.black54,
    fontSize: 24,
    fontWeight: FontWeight.bold),),))
    ,
    SizedBox(height:5.0),
    Container(child: Row(
      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
      children:<Widget>[Container(
        child:Text(rating.toString(),style:TextStyle(color:Colors.black54
        ,fontSize: 18.0),
        )),
         Container(child:Icon(Icons.stars,color:Colors.amber,size:14.0)),
         Container(child: Text('967',style:TextStyle(color: Colors.black54,fontSize: 18.0)))
      ]
    ),),
    SizedBox(height: 5.0,),
    Text(AppTranslations.of(context).text("timings"),style: TextStyle(color: Colors.black54,
    fontSize: 18.0,fontWeight: FontWeight.bold),),
   
   
    
  ],);
}
}