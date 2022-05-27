int LENGTH = 200;
int MASS = 25;
float GRAVITY = 0.3;
float DAMP = 0.995;

boolean moving;

Mass m0, m1;

void setup() {
  size(800, 400);
  frameRate(60);
  m0 = new Mass(width/2, 50);
  m1 = new Mass(width/2 + (int)(LENGTH * cos(PI/2 - PI/3)), 50 + (int)(LENGTH * sin(PI/2 - PI/3)));
  m0.next = m1;
  m1.previous = m0;
  moving = false;
}

void draw() {
  background(200);
  if (moving) {
    m1.calculatePosition(m0);
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
