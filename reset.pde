void reset() {
  md = false;
  points = new ArrayList();
  fs = new ArrayList();

  num = 0;
  test = false;
  state = false;
  record = false;
  switch3 = false;
  timer3 = 0.0;
  interval = 500.0;
  acc = 1;
  changeColor = false;
  fillcolor = 255;
  background(0);
}