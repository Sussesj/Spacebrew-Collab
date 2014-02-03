/*
*
* Spacebrew Collab Feb 2014
* Stephanie Alexandra Rose Burgess & Susse Sønderby
* Parsons The New School For Design 
*/
import spacebrew.*;

String server="54.201.24.223"; //until spacebrew is up running again. 
String name="Stephanie";
String description ="Client that sends and receives boolean messages. Background turns Green when message received.";

Spacebrew sb;

//Set color for recieving signal
color color_on = color(0, 173, 159);
color color_off = color(255, 255, 255);
int currentColor = color_off;

boolean disturbPressed = false;
boolean disturbHover = false;

boolean leavePressed = false;
boolean leaveHover = false;

boolean recievedText = false;

//color For interacting with disturb button
color disturbFill = color(0,173,159);
color disturbHoverFill = color(5,128,127);
int disturbInteractColor = disturbFill;

//color For interacting with leave button
color leaveFill = color(0,173,159);
color leaveHoverFill = color(5,128,127);
int leaveInteractColor = disturbFill;


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
  
    // draw Response Button
    fill( currentColor );
    rectMode(CENTER);
    stroke(strokeColor);
    rect(width/2,200,300,100);
    fill(color_on);
    text("Leave Me", width/2, 200 + 12);
    
    if ( recievedText == true) {
      fill(strokeColor);
      text("Disturb Me", width/2, 200 + 12);
    } 
    
    //check if hover disturb me
    if (mouseX > disturbX-disturbSize && mouseX < disturbX+disturbSize &&
        mouseY > disturbY-disturbSize && mouseY < disturbY+disturbSize) {
          disturbHover = true;
          println("disturb hover " + disturbHover);
        } else {
          disturbHover = false;
          println("disturb hover " + disturbHover);
        }
    
    // draw Disturb Me Button
    rectMode(CENTER);
    fill(disturbInteractColor); //light Green
    noStroke();
    rect(disturbX, disturbY, disturbSize, disturbSize);
    fill(strokeColor);
    textAlign(CENTER);
    textSize(12);
    text("Disturb Me", disturbX, disturbY);
      
    // Change color on Disturb Me Button  
    if(disturbHover == true) {
       disturbInteractColor = disturbHoverFill;
    }  else {
       disturbInteractColor = disturbFill;
    }
    
    //check hover Leave Me button
    if (mouseX > leaveX-disturbSize && mouseX < leaveX+disturbSize &&
        mouseY > disturbY-disturbSize && mouseY < disturbY+disturbSize) {
          leaveHover = true;
          println("leave hover " + leaveHover);
        } else {
          leaveHover = false;
          println("leave hover " + leaveHover);
        }
    
    // draw do notButton
    rectMode(CENTER);
    fill(leaveInteractColor); //light Green
    rect(leaveX, disturbY, disturbSize, disturbSize);
    fill(strokeColor);
    textAlign(CENTER);
    textSize(12);
    text("Leave Me", leaveX, disturbY);
    
    // Change color on Disturb Me Button
    if(leaveHover == true) {
       leaveInteractColor = leaveHoverFill;
    }  else {
       leaveInteractColor = leaveFill;
    }
  
}

void mousePressed() {
  // send message to spacebrew
  if(disturbHover == true) {
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



