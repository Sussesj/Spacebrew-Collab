/*
*
* Spacebrew Collab Feb 2014
* Stephanie Alexandra Rose Burgess & Susse Sønderby
* Parsons The New School For Design 
*/
import spacebrew.*;

String server="54.201.24.223";
String name="Susse";
String description ="Client that sends and receives boolean messages. Background turns yellow when message received.";

Spacebrew sb;

//Set color for recieving signal
color color_on = color(0, 173, 159, 2);
color color_off = color(255, 255, 255);
int currentColor = color_off;

boolean disturbPressed = false;
boolean disturbHover = false;

boolean leavePressed = false;
boolean leaveHover = false;

boolean recievedText = false;


int disturbFill = color(0,173,159);
int hoverFill = color(5,128,127);
int strokeColor = color(62,62,62);
int disturbSize = 100;
int disturbY = 400;
int disturbX = 150;

int leaveX = 350;


void setup() {
  frameRate(240);
  size(500, 600);
  background(246,246,246);

  // instantiate the spacebrewConnection variable
  sb = new Spacebrew( this );

  // declare your publishers
  sb.addPublish( "button_pressed", "boolean", true );


  // declare your subscribers
  sb.addSubscribe( "change_background", "boolean" );

  // connect to spacebre
  sb.connect(server, name, description );
}

void draw() {
  // draw ResponButton
  fill( currentColor );
  rectMode(CENTER);
  rect(width/2,200,300,100);
  if ( recievedText = true) {
    fill(strokeColor);
    text("Disturb Me", width/2, 200 + 12);
  }
  
  
  //check hover disturb me
  if (mouseX > disturbX-disturbSize && mouseX < disturbX+disturbSize &&
      mouseY > disturbY-disturbSize && mouseY < disturbY+disturbSize) {
        disturbHover = true;
        //println("in box");
        fill(hoverFill);
      } else {
        fill(disturbFill);
        //println("Out of Box");
        disturbHover = false;
      }
  
  // draw Disturb Me Button
  rectMode(CENTER);
  rect(disturbX, disturbY, disturbSize, disturbSize);
  fill(disturbFill);
  textAlign(CENTER);
  textSize(14);
  text("Disturb Me", disturbX, disturbY);
  
  //check hover Leave Me button
  if (mouseX > leaveX-disturbSize && mouseX < leaveX+disturbSize &&
      mouseY > disturbY-disturbSize && mouseY < disturbY+disturbSize) {
        leaveHover = true;
        //println("in box");
        fill(hoverFill);
      } else {
        fill(disturbFill);
        //println("Out of Box");
        disturbHover = false;
      }
  
  // draw do notButton
  rectMode(CENTER);
  rect(leaveX, disturbY, disturbSize, disturbSize);
  fill(disturbFill);
  textAlign(CENTER);
  textSize(14);
  text("Leave Me", leaveX, disturbY);
  
}

void mousePressed() {
  // send message to spacebrew
  if(disturbHover = true) {
  sb.send( "button_pressed", true);
  }
  
}

void mouseReleased() {
  // send message to spacebrew
  sb.send( "button_pressed", false);
  
}

void onBooleanMessage( String name, boolean value ){
  println("got bool message " + name + " : " + value);

  // update background color
  if (value == true) {
    recievedText = true;
    currentColor = color_on;
    println("Who is sending " + name);
  } else {
    currentColor = color_off;
    println("No to me");
    recievedText = false;
  }
  
  
}



