int LENGTH1 = 200;
int LENGTH2 = 200;
int MASS1 = 40;
int MASS2 = 40;
float GRAVITY = 0.5;
float DAMP = 0.995;

boolean moving;

Mass m0, m1, m2;

void setup() {
  size(800, 600);
  frameRate(60);
  m0 = new Mass(width/2, 50, MASS1);
  m1 = new Mass(width/2 + (int)(LENGTH1 * sin(PI/2)), 50 + (int)(LENGTH1 * cos(PI/2)), MASS1);
  m2 = new Mass(m1.x + (int)(LENGTH2 * sin(PI/3)), m1.y + (int)(LENGTH2 * cos(PI/3)), MASS2);
  m0.next = m1;
  m1.previous = m0;
  m1.next = m2;
  m2.previous = m1;
  moving = false;
}

void draw() {
  background(200);
  if (moving) {
    m1.calculatePosition1(m0);
    m2.calculatePosition2(m1);
  }
  m1.display();
  m2.display();
}

void keyPressed() {
  if (key == ' ') {
    moving = !moving;
  }
  if (key == 'r') {
    setup();
  }
}
