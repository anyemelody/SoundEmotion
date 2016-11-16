class Point {
  float maxSpeed = 0;
  Boolean finished = false;
  float r = 0;
  float theta = random(PI*2);
  float noiseFloat, lifeTime, age;
  PVector vel, loc, noiseVec;
  float saturation, brightness;
  float noiseX, noiseY;
  Point(float x, float y) {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    noiseVec = new PVector(0, 0);
    age = 0;
    lifeTime = int(random(900, 2700));
  }

  void update() {
    noiseFloat = noise(loc.x * 0.0003, loc.y * 0.0003);//decrease, the value will be smooth
    noiseVec.x = cos(((noiseFloat -0.9) * TWO_PI) * 10);
    noiseVec.y = sin(((noiseFloat - 0.1) * TWO_PI) * 10);
    age ++;
    vel.add(noiseVec);
    vel.div(2);
    loc.add(vel);
  }

  void display() {  
    colorMode(HSB, 360, 100, 100);
    brightness = noise(loc.x*.01, loc.y*.01)*30+70;
    saturation = noise(loc.x*.005, loc.y*.005)*120;
    fill(240, saturation, brightness, 90);
    colorMode(RGB, 255);
    noStroke();
    ellipse(loc.x, loc.y, 1.5-(age/lifeTime), 1.5-(age/lifeTime));
  }


  void boundry() {
    if (2.0-(age/lifeTime) <= 0) {
      this.finished = true;
    }
    if (loc.x >= width) {
      this.finished = true;
    } else if (loc.x<0) {
      this.finished = true;
    }
    if (loc.y>= height) {
      this.finished = true;
    } else if (loc.y<0) {
      this.finished = true;
    }

    if (vel.x>maxSpeed) {
      vel.x = maxSpeed;
    } else if (vel.x<-maxSpeed) {
      vel.x = -maxSpeed;
    }
    if (vel.y>maxSpeed) {
      vel.y = maxSpeed;
    } else if (vel.y<-maxSpeed) {
      vel.y = -maxSpeed;
    }
  }
}