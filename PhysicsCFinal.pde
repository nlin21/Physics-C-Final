import controlP5.*;
import grafica.*;

ControlP5 cp5;
RadioButton r;
float r_prev = 1.0;

GPlot plot;
GPointsArray points;
int nPoints = 100;

boolean moving;

String Number = "Number of Pendulum Bobs:";
String Length = "Length of Pendulum:";
String Mass = "Mass of Pendulum:";
String Gravity = "Gravity:";
String Damp = "Damp:";

int LENGTH1, LENGTH2, MASS1, MASS2;
float GRAVITY, DAMP;

Mass m0, m1, m2;

void setup() {
  size(1000, 920);
  cp5 = new ControlP5(this);
  plot = new GPlot(this);
  points = new GPointsArray(nPoints);
  plot.setPos(475,550);
  plot.setTitleText("Phase Space Diagram");
  plot.getXAxis().setAxisLabelText("Theta");
  plot.getYAxis().setAxisLabelText("Angular Momentum");

  LENGTH1 = 150;
  LENGTH2 = 150;
  MASS1 = 30;
  MASS2 = 30;
  GRAVITY = 0.5;
  DAMP = 1.00;
  theta0 = PI/2;
  omega0 = 0;
  alpha0 = 0;
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

  moving = false;
  addSliders();
  r.activate(0);
}

void draw() {
  background(200);
  
  //Sliders
  textSize(18);
  text(Number, 100, 530);
  text(Length, 100, 590);  
  text(Mass, 100, 690);
  text(Gravity, 100, 790);
  text(Damp, 100, 860);
  line(0, 500, 1000, 500);
  
  if (r_prev != r.getValue()) {
    theta0 = PI/2;
    omega0 = 0;
    alpha0 = 0;
    theta1 = PI/2;
    omega1 = 0;
    alpha1 = 0;
    theta2 = PI/3;
    omega2 = 0;
    alpha2 = 0;
    points = new GPointsArray(nPoints);
  }
  
  if (r.getValue() == 1.0) {
    points.add(theta0, MASS1 * LENGTH1 * LENGTH1 * omega0);
    plot.setPoints(points);
    plot.defaultDraw();
  }
  if (r.getValue() == 2.0) {
    points.add(theta2, MASS2 * LENGTH2 * LENGTH2 * omega2);
    plot.setPoints(points);
    plot.defaultDraw();
  }
  
  if (r.getValue() == 1.0) {
    m0.next = m1;
    m1.previous = m0;
    m1.next = null;
    m2.previous = null;
    m1.x = int(m0.x + LENGTH1 * sin(theta0));
    m1.y = int(m0.y + LENGTH1 * cos(theta0));
    if (moving) {
      m1.calculatePosition0(m0);
    }
    m1.display();
  }
  
  if (r.getValue() == 2.0) {
    m0.next = m1;
    m1.previous = m0;
    m1.next = m2;
    m2.previous = m1;
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
  
  r_prev = r.getValue();
}

void addSliders() {
  r = 
  cp5.addRadioButton("radioButton")
    .setPosition(100,540)
    .setSize(30,10)
    .setColorForeground(color(120))
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setItemsPerRow(2)
    .setSpacingColumn(50)
    .addItem("1 Bob",1)
    .addItem("2 Bobs",2);
         
  cp5.addSlider("LENGTH1")
    .setBroadcast(false)
    .setPosition(100,600)
    .setSize(300,20)
    .setRange(25,200)
    .setValue(LENGTH1)
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true);
  
  cp5.addSlider("LENGTH2")
    .setBroadcast(false)
    .setPosition(100,630)
    .setSize(300,20)
    .setRange(25,200)
    .setValue(LENGTH2)
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true);

  cp5.addSlider("MASS1")
    .setBroadcast(false)
    .setPosition(100,700)
    .setSize(300,20)
    .setRange(10,50)
    .setValue(MASS1)
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true);

  cp5.addSlider("MASS2")
    .setBroadcast(false)
    .setPosition(100,730)
    .setSize(300,20)
    .setRange(10,50)
    .setValue(MASS2)
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true);

  cp5.addSlider("GRAVITY")
    .setBroadcast(false)
    .setPosition(100,800)
    .setSize(300,20)
    .setRange(0.25,1.00)
    .setValue(GRAVITY)
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true);
  
  cp5.addSlider("DAMP")
    .setBroadcast(false)
    .setPosition(100,870)
    .setSize(300,20)
    .setRange(0.95,1.00)
    .setValue(DAMP)
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
