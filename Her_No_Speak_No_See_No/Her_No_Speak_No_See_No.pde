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














  //Steph's setup












  //Adiel's setup
  bDrawing = true;
  bNeedToClear = true;

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
      
      
      //count number of particles
      
    }
    
    
    
  }  

  println(particles.size());








  sb = new Spacebrew(this);
  sb.addPublish("doneExquisite", "boolean", false);
  sb.addSubscribe("startExquisite", "boolean");
  sb.addSubscribe("adielInput", "boolean");


  // add any of your own subscribers here!

  sb.connect( server, name, desc );
}

void draw() {
  // this will make it only render to screen when in EC draw mode
  if (!bDrawing) return;

  // blank out your background once
  if ( bNeedToClear ) {
    bNeedToClear = false;
    background(0); // feel free to change the background color!
  }

  // ---- start person 1 ---- //
  if ( millis() - corpseStarted < 1000 ) {
    noFill();
    stroke(255);
    rect(0, 0, width / 3.0, height );
    fill(255);










    // ---- start person 2 ---- //
  } 
  else if ( millis() - corpseStarted < 2000 ) {
    noFill();
    stroke(255);
    rect(width / 3.0, 0, width / 3.0, height );
    fill(255);











    // ---- start person 3 ---- //
  } 
  else if ( millis() - corpseStarted < 12000 ) {

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
    float X = map(millis(), corpseStarted + 2000, corpseStarted + 12000, width*2/3, width);
    line(X, height - 20, X, height);
    

    // ---- we're done! ---- //
  } 
  else {
    sb.send( "doneExquisite", true );
    bDrawing = false;
  }
}

void mousePressed() {
  // for debugging, comment this out!
  //sb.send( "doneExquisite", true );
  
  
  //debug
  for (Particle p : particles) {
    p.explode();
  }
  
  
}

void onBooleanMessage( String name, boolean value ) {
  if ( name.equals("startExquisite") ) {
    // start the exquisite corpse process!
    bDrawing = true;
    corpseStarted = millis();
    bNeedToClear = true;
  }
  
  if ( name.equals("adielInput") ) {
    exploded = true;
  }
  
  
}

void onRangeMessage( String name, int value ) {
}

void onStringMessage( String name, String value ) {
}

