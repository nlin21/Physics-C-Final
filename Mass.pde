float theta0, omega0, alpha0;
float theta1, omega1, alpha1;
float theta2, omega2, alpha2;
  
class Mass {

  int x, y, mass;
  
  Mass next, previous;

  Mass(int x, int y, int mass) {
    this.x = x;
    this.y = y;
    this.mass = mass;
    next = null;
    previous = null;
  }

  void display() {
    stroke(0);
    if (next != null) {
      line(x, y, next.x, next.y);
    }
    if (previous != null) {
      line(x, y, previous.x, previous.y);
    }
    circle(x, y, mass);
  }
  
  void calculatePosition0(Mass origin) {
    alpha0 = - GRAVITY / LENGTH1 * sin(theta0);
    omega0 += alpha0;
    omega0 *= DAMP;
    theta0 += omega0;
    
    x = int(origin.x + LENGTH1 * sin(theta0));
    y = int(origin.y + LENGTH1 * cos(theta0));
  }

  void calculatePosition1(Mass origin) {
    float term1 = - GRAVITY * (2 * MASS1 + MASS2) * sin(theta1);
    float term2 = - MASS2 * GRAVITY * sin(theta1 - 2 * theta2);
    float term3 = - 2 * sin(theta1 - theta2) * MASS2;
    float term4 = omega2 * omega2 * LENGTH2 + omega1 * omega1 * LENGTH1 * cos(theta1 - theta2);
    float term5 = LENGTH1 * (2 * MASS1 + MASS2 - MASS2 * cos(2 * theta1 - 2 * theta2));
    alpha1 = (term1 + term2 + term3 * term4) / term5;
    omega1 += alpha1;
    omega1 *= DAMP;
    theta1 += omega1;
    
    x = int(origin.x + LENGTH1 * sin(theta1));
    y = int(origin.y + LENGTH1 * cos(theta1));
  }

  void calculatePosition2(Mass m1) {
    float term1 = 2 * sin(theta1 - theta2);
    float term2 = omega1 * omega1 * LENGTH1 * (MASS1 + MASS2);
    float term3 = GRAVITY * (MASS1 + MASS2) * cos(theta1);
    float term4 = omega2 * omega2 * LENGTH2 * MASS2 * cos(theta1 - theta2);
    float term5 = LENGTH2 * (2 * MASS1 + MASS2 - MASS2 * cos(2 * theta1 - 2 * theta2));
    alpha2 = (term1 * (term2 + term3 + term4)) / term5;
    omega2 += alpha2;
    omega2 *= DAMP;
    theta2 += omega2;
    
    x = int(m1.x + LENGTH2 * sin(theta2));
    y = int(m1.y + LENGTH2 * cos(theta2));
  }
  
}
