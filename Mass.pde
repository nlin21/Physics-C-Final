class Mass {

  int x, y;
  float theta, alpha, omega;
  
  Mass next, previous;

  Mass(int x, int y) {
    this.x = x;
    this.y = y;
    theta = PI/3;
    alpha = 0;
    omega = 0;
    next = null;
    previous = null;
  }

  void display() {
    circle(x, y, MASS);
    stroke(0);
    if (next != null) {
      line(x, y, next.x, next.y);
    } 
    if (previous != null) {
      line(x, y, previous.x, previous.y);
    }
  }

  void calculatePosition(Mass origin) {
    alpha = -1 * GRAVITY / LENGTH * sin(theta);
    omega += alpha;
    theta += omega;
    
    x = (int)(LENGTH * cos(theta * -1 + PI/2)) + origin.x;
    y = (int)(LENGTH * sin(theta * -1 + PI/2)) + origin.y;
  }
  
}
