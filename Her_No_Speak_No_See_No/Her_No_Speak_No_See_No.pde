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

/* @pjs preload="1231.png, 12341.png, 12- dont speak.png, 13- dont speak.png, 3- dont speak.png, 4- dont speak.png, 5- dont speak.png, 6- dont speak.png, 7- dont speak.png, 8- dont speak.png, 9- dont speak.png, 10- dont speak.png, 11- dont speak.png"; */

int numFrames = 11; //the number of frames in the animation
int numFrames2 = 2; // number of frames receiving
int frame = 0;
int frameO = 0;
PImage[] images = new PImage [numFrames];
PImage[] images2 = new PImage [numFrames2];
boolean recording_received = false;

int stephTimer = 0;


//Adiel's variables
PImage monkey;
PImage bandage;

ArrayList<Particle> particles;
boolean exploded = false;


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
  images2[0] = loadImage("1231.png");
  images2[1] = loadImage("12341.png");




  //Adiel's setup
  monkey = loadImage("monkeyWhiteEyes.png");
  bandage = loadImage("bandageSmall.png");
  //image(bandage, width, 0);

  bandage.loadPixels();
  
  //pixels[y*width+x]

  particles = new ArrayList<Particle>();
  
  int res = 10;

  for (int i = 0; i < bandage.height * bandage.width; i+=res) {
    color C = bandage.pixels[i];
    if(alpha(C) > 10){
      color thisCol = rouge; 
      if(blue(C) > 40){
        thisCol = darkBlue;
      }
      int x = i % bandage.width;
      int y = (i - x)/bandage.width; 
      
      Particle p = new Particle(x + width*2/3 + width/6 - bandage.width/2, y + 220, thisCol);
      particles.add(p);
      
    }
  }  



  sb = new Spacebrew(this);
  sb.addPublish("doneExquisite", "boolean", false);
  sb.addSubscribe("startExquisite", "boolean");
  //sb.addPublish("monkeySlider", "range", monkeyVal);
  sb.addSubscribe("stephInput", "boolean");
  sb.addSubscribe("moveMonkey", "range");
  sb.addSubscribe("adielInput", "boolean");
  sb.connect( server, name, desc );

}

void draw() {
  // this will make it only render to screen when in EC draw mode
  //if (!bDrawing) bDrawing = true; //back to return and delete dDraw
  if (!bDrawing) return;

  // blank out your background once
  if ( bNeedToClear ) {
    bNeedToClear = false;
    background(255); // feel free to change the background color!
  }

  // ---- start person 1 ---- //
  bNeedToClear = true;
if ( millis() - corpseStarted < 10000 ){
    fill(lightBeige);
    stroke(255);
    rect(0, 0, width / 3.0, height );
    fill(255);
     
  player.play();
  image(fragment[counter], 100, 200);
  
  if((millis() - corpseStarted) < 3000){
    counter++;
    if(counter > 2){
      counter = 0;
      // add text to button
      fill(rouge);
      textAlign(CENTER);
      textSize(1+monkeyVal);
      text("DANCE", 200, 600);
    }
  } else if ((millis() - corpseStarted) < 6000) {
    counter++;
    if(counter > 2){
      counter = 0;
    }
  } else if ((millis() - corpseStarted) < 10000) {
    counter++;
    if(counter > 2){
      counter = 0;
    }
  }




    // ---- start person 2 ---- //
  } 
  else if ( millis() - corpseStarted < 20000 ) {
      fill(lightBeige);


    if (recording_received == true) {
      frameO = (frameO+1) % numFrames2;  // Use % to cycle through frames
      int offset = 0;
      for (int x = 400; x < 800; x += images2[0].width) { 
        image(images2[(frameO+offset) % numFrames2], x, 90);
      }

      if (millis() - stephTimer > 2000) {
        recording_received = false;
      }
    } 
    else {
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
    }

minim.stop();

    noFill();
    stroke(255);
    rect(width / 3.0, 0, width / 3.0, height );
    fill(255);






    // ---- start person 3 ---- //
  } 
  else if ( millis() - corpseStarted < 30000 ) {
    noFill();
    stroke(255);
    rect(width * 2.0/ 3.0, 0, width / 3.0, height );
    fill(255);

    stroke(255);
    fill(lightBeige);
    rect(width * 2.0/ 3.0, 0, width / 3.0, height );
    image(monkey, width * 2.0/ 3.0, 0);

    for (Particle p : particles) {
        p.update();
        p.display();
    }
  
    if(exploded){
      for (Particle p : particles) {
        p.explode();
      }
      exploded = false;
    }

    //animation timer
    stroke(rouge);
    strokeWeight(3);
    float X = map(millis(), corpseStarted + 20000, corpseStarted + 30000, width*2/3, width);
    line(X, height - 20, X, height);
    

    // ---- we're done! ---- //
  } 
  else {
    sb.send( "doneExquisite", true );
    bDrawing = false;
  }
}


void onBooleanMessage( String name, boolean value ) {

  if ( name.equals("startExquisite") ) {
    // start the exquisite corpse process!
    bDrawing = true;
    corpseStarted = millis();
    bNeedToClear = true;
  }

  if (name.equals("stephInput")) {
    recording_received = true;
    println("steph got a message: " + name);
    stephTimer = millis();
  }
  if ( name.equals("adielInput") ) {
    exploded = true;
  }
  
}


void onRangeMessage( String name, int value ) {
  println("moveMonkey" + name + " : " + value);
  
  monkeyVal = value;
  
  
}

void onStringMessage( String name, String value ) {


}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}



