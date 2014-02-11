class Particle {

  PVector pos;
  PVector vel;
  PVector grav = new PVector(0,0.2);
  
  color col;
  
  float lifespan = 255;
  
  float size = 5;
  float initSize = 5;
  float trans = 255;
  float age = 0;
  
  boolean exploded = false;
  
  float initX;
  float initY;
  
  
  Particle(int x, int y, color C) {
    pos = new PVector(x, y);
    vel = new PVector(0,0);
    col = C;
    
    initX = x;
    initY = y;
    
  }

  void update(){
    
    pos.add(vel);
    
    vel.mult(0.995);
    
    float bounceDamp = 0.4;
    
//    if(pos.x < width*2/3 + size/2){
//      pos.x = width*2/3 + size/2 + 1;
//      vel.x *= -bounceDamp;
//    } else if(pos.x > width - size/2){
//      pos.x = width - size/2 - 1;
//      vel.x *= -bounceDamp;
//    }    
//
//    if(pos.y < 0 + size/2){
//      pos.y = size/2 + 1;
//      vel.y *= -bounceDamp;
//    } 
//    else if(pos.y > 3*height - size/2){
//      //bounce code
//      pos.y = height - size/2 - 1;
//      vel.y *= -bounceDamp;
//      
//    }

    //if(dist(pos.x, pos.y, initX, initY) > 1000){
    if(age > 200){
      //reset code
      exploded = false;
      
    }

    size = initSize;
//    if(trans > 0){
//      trans -= 3;
//    }
    age++;
    
    if(!exploded){
      //vel.add(grav);
     
      float time = map(millis(), 0, 1000, 0, 5);
      size = initSize + 5*sin(time + pos.y);
      trans = 255;
      pos.set(initX, initY);
      vel.set(0, 0);
      age = 0;
      
    }

    
    
  }
  
  void explode(){
    vel.set(random(-15,15), random(-15,15));
    exploded = true;
    age = random(100);
    trans = 255;
    
  }

  void display(){
    
    if(pos.x > width*2/3 + size/2 && pos.x < width - size/2 && pos.y > 0 + size/2 && pos.y < 3*height - size/2){
      pushStyle();
      
      rectMode(CENTER);
      noStroke();
      fill(col, trans);
      
      rect(pos.x, pos.y, size, size);
      
      popStyle();
    }
    
  }
  


}
