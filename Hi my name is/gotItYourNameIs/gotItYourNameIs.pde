/*

This is the subscriber that recieves the sting with the name. 
*/

import spacebrew.*;

String server= "sandbox.spacebrew.cc";
String name="gotItYourNameIs";
String description ="";

Spacebrew sb;

//makes a string for remote string
String remote_string = "";

//create json object
JSONObject outgoing = new JSONObject();

void setup(){
  size(250,300);
  
  //intitiate the spacebrew Connection Variable
  sb = new Spacebrew( this );
  
  //declare subscriber
  sb.addSubscribe ("say_something", "name");
  
  sb.connect(server, name, description);
}



void draw(){
  background(44,59,72);
  
  noFill();
  stroke(161,212,212);
  rect(10, 10, width-20,height-20);
  
  // draw latest received message
  text(remote_string, 150, 140);fill(255);
  rect(80, 120, 90,20);
  text("Just entered: ", 90, 100);  

}

void onCustomMessage( String name, String type, String value ){
  if  (name.equals("say_something") ) {
    JSONObject m = JSONObject.parse( value );
    println("got string message " + name + " : " + value);
    remote_string = m.getString("local_string");
  }
}


