/*
Spacebrew Collab Spring 2014

Susse - segment 1 (0-10 seconds):   Hear no evil
Steph - segment 2 (10-20 seconds):  Speak no evil
Adiel - segment 3 (20-30 seconds):  See no evil

Color Palette (see below)


*/

import spacebrew.*;
import ddf.minim.*;

// Spacebrew stuff
String server ="54.201.24.223";
String name   = "SusseHearNo";
String desc   = "Some stuff";

Spacebrew sb;

color darkBlue = color(18, 36, 48);
color blueGray = color(39, 62, 69);
color lightBeige = color(255, 252, 226);
color darkBeige = color(237, 212, 183);
color rouge = color(194, 23, 21);

//Susse's variables
//create array for the three monkey images
PImage[] fragment;
//create variable for the number of monkeysin the array
int n=3;
int time;
int wait = 1000;

int monkeyVal = 50;

int counter = 0;

AudioPlayer player;
Minim minim; //audio context



//Steph's variables












//Adiel's variables














// App Size: you should decide on a width and height
// for your group
int appWidth  = 1280;
int appHeight = 720;

// EC stuff
int corpseStarted   = 0;
boolean bDrawing    = false;
boolean bNeedToClear = false;

void setup(){
  size( appWidth, appHeight );
  
  //Susse's setup
//assign new values to PImage
fragment = new PImage[n];
for(int i =0; i < fragment.length; i++){
  //I loading images
  fragment[i]=loadImage(str(i) + ".jpg");
}

time = millis(); //stores the current time

minim = new Minim(this);
player = minim.loadFile("true_To_Life.mp3", 2048);





//Steph's setup












//Adiel's setup








  
  
  
  
  
  
  sb = new Spacebrew(this);
  sb.addPublish("doneExquisite", "boolean", false);
  sb.addSubscribe("startExquisite", "boolean");
  sb.addPublish("monkeySlider", "range", monkeyVal);
  
  
  // add any of your own subscribers here!
  sb.addSubscribe("moveMonkey", "range");
  sb.connect( server, name, desc );
}

void draw(){
  // this will make it only render to screen when in EC draw mode
  if (!bDrawing) return;
  
  // blank out your background once
  if ( bNeedToClear ){
    bNeedToClear = false;
    background(0); // feel free to change the background color!
  }
  
  // ---- start person 1 ---- //
  
  if ( millis() - corpseStarted < 10000 ){
    fill(lightBeige);
    stroke(255);
    rect(0,0, width / 3.0, height );
    fill(255);
    
       
    //drawing each of the images
//    for(int i=0; i<fragment.length; i++){
//        image(fragment[i], 20*i, 100+i);
//        if(millis() - time >= wait) {
//          
//      }
//        time = millis();//updates the stored 
//    
//    }
  
  player.play();
  image(fragment[counter], 100, 200);
  
  if((millis() - corpseStarted) < 8000){
    counter++;
    if(counter > 2){
      counter = 0;
      // add text to button
      fill(rouge);
      textAlign(CENTER);
      textSize(1+monkeyVal);
      text("DANCE", 200, 600);
    }
  } else if ((millis() - corpseStarted) < 12000) {
    counter++;
    if(counter > 2){
      counter = 0;
    }
  } else if ((millis() - corpseStarted) < 18000) {
    counter++;
    if(counter > 2){
      counter = 0;
    }
  }

  
  
  
  // ---- start person 2 ---- //
  } else if ( millis() - corpseStarted < 20000 ){
    noFill();
    stroke(255);
    rect(width / 3.0,0, width / 3.0, height );
    fill(255);
    minim.stop();
    
    
    
    
    
    
    
    
  // ---- start person 3 ---- //
  } else if ( millis() - corpseStarted < 30000 ){
    noFill();
    stroke(255);
    rect(width * 2.0/ 3.0,0, width / 3.0, height );
    fill(255);
  
  
  
  
  
  
  
  
  
  
  
  // ---- we're done! ---- //
  } else {
    sb.send( "doneExquisite", true );
    bDrawing = false;
  }
}

void mousePressed(){
  // for debugging, comment this out!
  sb.send( "doneExquisite", true );
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}

void onBooleanMessage( String name, boolean value ){
  if ( name.equals("startExquisite") ){
    // start the exquisite corpse process!
    bDrawing = true;
    corpseStarted = millis();
    bNeedToClear = true;
  }
}

void onRangeMessage( String name, int value ){
  println("moveMonkey" + name + " : " + value);
  
  monkeyVal = value;
  
  
  
  
  
  
  
}

void onStringMessage( String name, String value ){
  
  
  
  
  
  
  
  
  
  
  
  
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
