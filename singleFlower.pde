class singleFlower {
  ArrayList<petal> singleFlower;
  PVector rootPoint;
  PVector vel;
  boolean finished = false;
  PVector selfPower = new PVector(0, 0);
  float t1 = random(1);
  float t2 = random(1);

  singleFlower(PVector location, PVector speed) {
    rootPoint = location.get();
    vel = speed.get();
    singleFlower = new ArrayList<petal>();
  }

  void addPetal() {
    int petalNum = (int) random(50,90);
    for (int i=0; i<petalNum; i++) {
      singleFlower.add(new petal(rootPoint, vel));
    }
  }

  //void update() {
  // t1 += 0.01;
  // t2 += 0.02;
  // float x= cos(t1)*100;
  // float y= sin(t2)*100;
  // selfPower = new PVector(10, 10);
  // rootPoint.add(selfPower);
  //}

  void run() {
    for (int i = singleFlower.size()-1; i>0; i--) {
      petal p = (petal) singleFlower.get(i);
      p.behavior1();
      p.boundry();
      if (p.isDead == true) {
        singleFlower.remove(i);
      }
    }
  }

  void check() {
    if (singleFlower.size() <= 50) {
      finished = true;
    }
  }
}