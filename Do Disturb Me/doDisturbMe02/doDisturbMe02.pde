/*
*
* Spacebrew library 
* Stephanie Alexandra Rose Burgess & Susse Sønderby
* Parsons The New School For Design Feb 2014
*/
import spacebrew.*;

String server="54.201.24.223";
String name="Stephanie";
String description ="Client that sends and receives boolean messages. Background turns yellow when message received.";

Spacebrew sb;

color color_on = color(255, 255, 50);
color color_off = color(255, 255, 255);
int currentColor = color_off;

boolean disturbPressed = false;
boolean disturbHover = false;

boolean leavePressed = false;
boolean leaveHover = false;

boolean recievedText = false;


int disturbFill = color(255,100,255);
int hoverFill = color(255,0,255);
int disturbSize = 100;
int disturbY = 400;
int disturbX = 150;

int leaveX = 350;


void setup() {
  frameRate(240);
  size(500, 600);

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
    fill(0);
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



