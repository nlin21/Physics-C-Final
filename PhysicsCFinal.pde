int LENGTH = 100;
float MASS = 15;
float GRAVITY = 0.1;

boolean moving;

Mass m0, m1;

void setup() {
  size(600,400);
  m0 = new Mass(width/2, 50);
  m1 = new Mass(width/2 + LENGTH, 50);
  m0.next = m1;
  m1.previous = m0;
  moving = false;
}

void draw() {
  background(200);
  if (moving) {
    m1.calculateVector(m0);
    m1.run();
  }
  m0.display();
  m1.display();
}

void keyPressed() {
  if (key == ' ') {
    moving = !moving;
  }
  if (key == 'r') {
    setup();
  }
}
