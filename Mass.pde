class Mass {

  PVector position, velocity, acceleration;
  
  float theta;
  float mgcos, mgsin, mg;
  
  Mass next, previous;
  
  Mass(int x, int y) {
    position = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mg = MASS * GRAVITY;
    next = null;
    previous = null;
  }
  
  void display() {
    circle(position.x, position.y, MASS);
    stroke(0);
    if (next != null) {
      line(position.x, position.y, next.position.x, next.position.y);
    }
    if (previous != null) {
      line(position.x, position.y, previous.position.x, previous.position.y);
    }
  }
  
  void run() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.set(0,0);
  }
  
  void applyVector(PVector vector) {
    acceleration.add(vector);
  }
  
  void calculateVectors(Mass other) {
    theta = HALF_PI - PVector.sub(position, other.position).heading();
    mgcos = mg * cos(theta);
    mgsin = mg * sin(theta);
    
    //applyVector(new PVector(mgcos * sin(theta), mgcos * cos(theta)));
    applyVector(new PVector(-mgcos * sin(theta), -mgcos * cos(theta)));
    
    applyVector(new PVector(-mgsin, mgcos));
  }
 
}
