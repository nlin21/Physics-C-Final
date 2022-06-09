import controlP5.*;

ControlP5 cp5;

boolean moving;

String Length = "Length of Pendulum:";
String Mass = "Mass of Pendulum:";
String Gravity = "Gravity:";

int LENGTH1, LENGTH2, MASS1, MASS2;
float GRAVITY;

Mass m0, m1, m2;

void setup() {
  size(1000, 900);
  cp5 = new ControlP5(this);
  
  LENGTH1 = 150;
  LENGTH2 = 150;
  MASS1 = 30;
  MASS2 = 30;
  GRAVITY = 0.5;
  
  theta1 = PI/2;
  omega1 = 0;
  alpha1 = 0;
  theta2 = PI/3;
  omega2 = 0;
  alpha2 = 0;
  
  m0 = new Mass(width/2, 50, MASS1);
  m1 = new Mass(width/2 + int(LENGTH1 * sin(theta1)), 
                50 + int(LENGTH1 * cos(theta1)), MASS1);
  m2 = new Mass(m1.x + int(LENGTH2 * sin(theta2)), 
                m1.y + int(LENGTH2 * cos(theta2)), MASS2);
  m0.next = m1;
  m1.previous = m0;
  m1.next = m2;
  m2.previous = m1;
  moving = false;
  addSliders();
}

void draw() {
  background(200);
  
  //Sliders
  textSize(18);
  text(Length, 100, 600);  
  text(Mass, 100, 700);
  text(Gravity, 100, 800);
  line(0, 550, 1000, 550);
  
  m1.x = int(m0.x + LENGTH1 * sin(theta1));
  m1.y = int(m0.y + LENGTH1 * cos(theta1));
  m2.x = int(m1.x + LENGTH2 * sin(theta2));
  m2.y = int(m1.y + LENGTH2 * cos(theta2));
  m1.mass = MASS1;
  m2.mass = MASS2;
  
  if (moving) {
    m1.calculatePosition1(m0);
    m2.calculatePosition2(m1);
  }
  m1.display();
  m2.display();
}

void addSliders() {
  cp5.addSlider("LENGTH1")
    .setBroadcast(false)
    .setPosition(100,610)
    .setSize(300,20)
    .setRange(25,200)
    .setValue(LENGTH1)
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true);
  
  cp5.addSlider("LENGTH2")
    .setBroadcast(false)
    .setPosition(100,640)
    .setSize(300,20)
    .setRange(25,200)
    .setValue(LENGTH2)
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true);

  cp5.addSlider("MASS1")
    .setBroadcast(false)
    .setPosition(100,710)
    .setSize(300,20)
    .setRange(10,50)
    .setValue(MASS1)
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true);

  cp5.addSlider("MASS2")
    .setBroadcast(false)
    .setPosition(100,740)
    .setSize(300,20)
    .setRange(10,50)
    .setValue(MASS2)
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true);

  cp5.addSlider("GRAVITY")
    .setBroadcast(false)
    .setPosition(100,810)
    .setSize(300,20)
    .setRange(0.25,1.00)
    .setValue(GRAVITY)
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true);
}

void keyPressed() {
  if (key == ' ') {
    moving = !moving;
  }
  if (key == 'r') {
    setup();
  }
}
