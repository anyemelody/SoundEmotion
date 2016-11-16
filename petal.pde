import java.util.Random;

class petal {
  PVector origin, loc, vel;
  float r, theta;
  float maxForce;
  float maxSpeed;
  Boolean isDead = false;
  boolean start = true;
  float maxStep, lifeTime, step;//attention!!! must be float
  Random generator = new Random();
  float t1=random(1), t2=random(1);
  PVector selfPower = new PVector(0, 0);
  float rotateSpeed = PI/90;

  petal(PVector l, PVector v) {
    origin = l.get();
    loc = origin.get();
    vel = v.get();
    r = 0;
    theta = vel.heading()+random(-0.4*PI, 0.4*PI);
    lifeTime = 70;
    step = 0;
    maxStep = (int)random(50, 140);
  }


  void behavior1() {
    if (step<50) {
      loc = origin.get();
      for (int j=0; j<maxStep; j++) {//the num means the step/length of each line
        float num = (float) generator.nextGaussian();
        float sd = 0.002;
        vel.x = cos(theta+num*sd)*r;
        vel.y = sin(theta+num*sd)*r;
        loc.add(vel);
        //set the ratio of step of lifeTime, will generate differen t
        if (changeColor == false) {
          fill(220, 10, 30, 90);
        } else {
          fill(255, 90);
        }
        noStroke();
        ellipse(loc.x, loc.y, (1-j/lifeTime), (1-j/lifeTime));
        r= noise(loc.x, loc.y);
      }
      /////////////////////////////
      pushMatrix();
      translate(loc.x, loc.y);
      rotate(theta);
      theta += rotateSpeed;
      if (frameCount%60 ==0) {
        rotateSpeed *= -1;
      }
      popMatrix();
      //////////////////////////////
      step++;
    } else {
      if (start == true) {
        time = millis();
        start = false;
      }
      if (millis()-time>1800) {
        behavior2();
      }
    }
  }

  void behavior2() {
    vel.x = sin(noise(loc.x*.01, loc.y*.01)*TWO_PI);
    vel.y = cos(noise(loc.x*.01, loc.y*.01)*TWO_PI);
    loc.x += vel.x;
    loc.y += vel.y;
    if (changeColor == false) {
      fill(220, 10, 30, 90);
    } else {
      fill(255, 90);
    }
    noStroke();
    ellipse(loc.x, loc.y, 1, 1);
  }

  void boundry() {
    if (loc.x>width || loc.x<0) {
      isDead = true;
    } else if (loc.y>height || loc.y<0) {
      isDead = true;
    }
  }
}