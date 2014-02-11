/*
Spacebrew Collab Spring 2014
 
 Susse - segment 1 (0-10 seconds):   Hear no evil
 Steph - segment 2 (10-20 seconds):  Speak no evil
 Adiel - segment 3 (20-30 seconds):  See no evil
 
 Color Palette (see below)
 
 
 */

import spacebrew.*;

// Spacebrew stuff
String server = "sandbox.spacebrew.cc";
String name   = "Adiel_Steph_Susse";
String desc   = "Some stuff";

Spacebrew sb;

color darkBlue = color(18, 36, 48);
color blueGray = color(39, 62, 69);
color lightBeige = color(255, 252, 226);
color darkBeige = color(237, 212, 183);
color rouge = color(194, 23, 21);

//Susse's variables














//Steph's variables

/* @pjs preload="123.png, 1234.png, 12- dont speak.png, 13- dont speak.png, 3- dont speak.png, 4- dont speak.png, 5- dont speak.png, 6- dont speak.png, 7- dont speak.png, 8- dont speak.png, 9- dont speak.png, 10- dont speak.png, 11- dont speak.png"; */

int numFrames = 11; //the number of frames in the animation
int numFrames2 = 2; // number of frames receiving
int frame = 0;
int frameO = 0;
PImage[] images = new PImage [numFrames];
PImage[] images2 = new PImage [numFrames2];
boolean recording_received = false;








//Adiel's variables














// App Size: you should decide on a width and height
// for your group
int appWidth  = 1280;
int appHeight = 720;

// EC stuff
int corpseStarted   = 0;
boolean bDrawing    = false;
boolean bNeedToClear = false;

void setup() {
  size( appWidth, appHeight );

  //Susse's setup














  //Steph's setup



  background(0);
  frameRate(5);


  images[0] = loadImage("12- dont speak.png");
  images[1] = loadImage("13- dont speak.png");
  images[2] = loadImage("3- dont speak.png");
  images[3] = loadImage("4- dont speak.png");
  images[4] = loadImage("5- dont speak.png");
  images[5] = loadImage("6- dont speak.png");
  images[6] = loadImage("7- dont speak.png");
  images[7] = loadImage("8- dont speak.png");
  images[8] = loadImage("9- dont speak.png");
  images[9] = loadImage("10- dont speak.png");
  images[10] = loadImage("11- dont speak.png");

  images2[0] = loadImage("123.png");
  images2[1] = loadImage("1234.png");





  //Adiel's setup














  sb = new Spacebrew(this);
  sb.addPublish("doneExquisite", "boolean", false);
  sb.addSubscribe("startExquisite", "boolean");

  // add any of your own subscribers here!

  sb.connect( server, name, desc );
}

void draw() {
  // this will make it only render to screen when in EC draw mode
  if (!bDrawing) bDrawing = true; //back to return and delete dDraw
  //if (!bDrawing) return;

  // blank out your background once
  if ( bNeedToClear ) {
    bNeedToClear = false;
    background(255); // feel free to change the background color!
  }

  // ---- start person 1 ---- //
  bNeedToClear = true;
  if ( millis() - corpseStarted < 10000 ) {
    noFill();
    stroke(255);
    //    rect(0,0, width / 3.0, height );
    //     fill(194, 23, 21);
    //    ellipse(width/2, width/3, height/2, height/2);

    frame = (frame+1) % numFrames;  // Use % to cycle through frames
    int offset = 0;
    for (int x = 400; x < 800; x += images[0].width) { 
      image(images[(frame+offset) % numFrames], x, 90);
    }









    // ---- start person 2 ---- //
  } 
  else if ( millis() - corpseStarted < 20000 ) {










    // ---- start person 3 ---- //
  } 
  else if ( millis() - corpseStarted < 30000 ) {
    noFill();
    stroke(255);
    rect(width * 2.0/ 3.0, 0, width / 3.0, height );
    fill(255);











    // ---- we're done! ---- //
  } 
  else {
    sb.send( "doneExquisite", true );
    bDrawing = false;
  }
}

void mousePressed() {
  // for debugging, comment this out!
  sb.send( "doneExquisite", true );
}

void onBooleanMessage( String name, boolean value ) {
  println("got boolean message" + name + " : " + value);

  if ( name.equals("startExquisite") ) {
    // start the exquisite corpse process!
    bDrawing = true;
    corpseStarted = millis();
    bNeedToClear = true;
  }
 if (recording_received == true) {
    println("who is sending" + name);
    frameO = (frameO+1) % numFrames2;  // Use % to cycle through frames
    int offset = 0;
    for (int x = 400; x < 800; x += images2[0].width) { 
      image(images2[(frameO+offset) % numFrames2], x, 90);
    }
  }
}
  void onRangeMessage( String name, int value ) {
  }

  void onStringMessage( String name, String value ) {
  }

