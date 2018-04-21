import peasy.*;

float x = 0;
float y = 0;
float z = 0;

float dt = 0.01;

ArrayList<PVector> points = new ArrayList<PVector>();

PeasyCam cam;


// Rössler attractor
/*float a = 0.2;
float b = 0.2;
float c = 14;

float scaleFactor = 10;
float dx_dt(){
  return -y-z;
}
float dy_dt(){
  return x+a*y;
}
float dz_dt(){
  return b+z*(x-c);
}*/

// Aizawa attractor
/*float a = 0.95;
float b = 0.7;
float c = 0.6;
float d = 3.5;
float e = 0.25;
float f = 0.1;

float scaleFactor = 10;
float dx_dt(){
  return (z-b)*x-d*y;
}
float dy_dt(){
  return d*x+(z-b)*y;
}
float dz_dt(){
  return c+a*z-z*z*z/(3.0)-(x*x+y*y)*(1+e*z)+f*z*x*x*x;
}*/

// De Jong Attractor
float a = -2.24;
float b = 0.43;
float c = -0.65;
float d = -2.43;

float scaleFactor = 10;
float dx_dt(){
  return sin(a*y)-cos(b*x);
}
float dy_dt(){
  return sin(c*x)-cos(d*y);
}
float dz_dt(){
  return 0;
}

void setup(){
  size(1024,1024,P3D);
  background(0);
  cam = new PeasyCam(this,0,0,0,10);
  cam.setWheelScale(0.5);
  colorMode(HSB);
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
            0.0001, 10000000);
            
  frameRate(1000);
}

void draw(){
  background(0);
  float dx = dx_dt()*dt;
  float dy = dy_dt()*dt;
  float dz = dz_dt()*dt;
  
  x += dx;
  y += dy;
  z += dz;
  
  points.add(new PVector(x,y,z));
  
  //beginShape();
  pushMatrix();
  scale(scaleFactor);
  noFill();
  stroke(255);
  
  beginShape();
  strokeWeight(0.1);
  float h = 0;
  for (PVector v : points){
    stroke(h,255,255);
   //stroke(255,h,0);
    tint(255,128);
    vertex(v.x,v.y,v.z);
    h += 0.5;
    h = h%255;
  }
  endShape();
  popMatrix();
  //println(x,y,z);
  if (keyPressed && key == 's'){
    println("Time passed: "+ points.size()*dt);
    println("dt: "+dt);
    println("Iterations: "+points.size());
  }
}