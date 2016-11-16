import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
Boolean md = false;
ArrayList points = new ArrayList();
ArrayList fs = new ArrayList();

int num = 0;
boolean test = false;
boolean state = false;
boolean record = false;
float time;
boolean switch3 = false;
float timer3 = 0.0;
float interval = 500.0;
float acc = 1;
boolean changeColor = false;
int fillcolor = 255;

void setup() {
  size(1280, 800, P2D);
  background(0);
  //////////////////////////////////////////////////
  //minim = new Minim(this);
  //song = minim.loadFile("the dry banks.mp3", 2048);
  //song.loop();
  //beat = new BeatDetect();
  ////////////////////////////////////////
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("192.168.0.8", 12000);
  ////////////////////////////////////////////////////
}

void draw() {
  noCursor();
  float initial = random(width);
  //if no voice, blank the canvas
  if (ampValue < 70 && frameCount%5 ==0) {
    fill(0,30);
    rect(0, 0, width, height);
  }
  /*if vioce has been detected, start drawing*/
  if (ampValue > 70) {
    for (int i=0; i<6; i++) {
      points.add(new Point(initial, random(height)));
    }
    num++;
  }
  /* level 1 particles display */
  noiseDetail(8, 0);
  if (points.size()>0) {
    for (int i=points.size()-1; i>0; i--) {
      Point p = (Point)points.get(i);
      p.update();
      p.display();
      p.boundry();
      if (p.finished) {
        points.remove(i);
      }
    }
  }
  /*level2: if both pitch and amp are high, start blooming */
  if (pitchValue>500 && ampValue>76 && fs.size()<10) {
    if (test == false && frameCount%10 == 0) {
      int k = int(random(points.size()));
      Point p = (Point)points.get(k); 
      PVector pos = p.loc;
      PVector vel = p.vel;
      fs.add(new singleFlower(pos, vel));
      int last = fs.size()-1;
      singleFlower sF = (singleFlower)fs.get(last);
      sF.addPetal();
      test = true;
    }
  }
  if (pitchValue<500 || ampValue<76 ) {
    test = false;
  }
  /*****level 2: flowers display **************************/
  for (int i = fs.size()-1; i>=0; i--) {
    singleFlower k = ( singleFlower)fs.get(i);
    k.run();
    k.check();
    if (k.finished == true) {
      fs.remove(i);
    }
  }
  println(frameRate, "kakaakakakak");
  /********* level 3 initialize ************/
  if (fs.size()>8 && ampValue > 70) {
    switch3 = true;
  } 
  if (fs.size()<3) {
    changeColor = false;
    switch3 = false;
  }
  if (switch3 == true) {
    if (timer3 < 5) {
      if (acc == -1) {
        fill(0, 90);
        changeColor = true;
      } else if ( acc == 1) {
        fill(255, 90);
        changeColor = false;
      }
      rect(0, 0, width, height);
      timer3 ++;
    } else {
      timer3 =0; 
      acc *= -1;
    }
    switch3 = false;
  }
  //////////////////////////////////////////////
}

void mousePressed() {
  reset();
}