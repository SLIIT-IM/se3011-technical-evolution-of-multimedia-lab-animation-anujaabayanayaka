//A.A.Abayanayaka
//IT23829374

//Game State
int state = 0; //0=start, 1=play, 2=end
int startTime;
int duration = 30;
int score = 0;

//Player
float px = 350, py = 175;
float pr = 20;
float step = 6;

//Helper Dot
float hx, hy;
float ease = 0.08;

//Orb
float ox = 200, oy = 150;
float or = 18;
float xs = 4;
float ys = 3;

//Trails
boolean trails = false;

void setup() {
  size(700, 350);
  hx = px;
  hy = py;
}

void draw() {

  //Trails System
  if (!trails) {
    background(245);
  } else {
    noStroke();
    fill(245, 40);
    rect(0, 0, width, height);
  }

  //Start Screen
  if (state == 0) {
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(28);
    text("Orb Hunter", width/2, height/2 - 20);

    textSize(18);
    text("Press ENTER to Start", width/2, height/2 + 20);
  }

  //Play State
  if (state == 1) {

    //Timer
    int elapsed = (millis() - startTime) / 1000;
    int left = duration - elapsed;

    if (left <= 0) {
      state = 2;
    }

    fill(0);
    textSize(16);
    textAlign(LEFT, TOP);
    text("Time: " + left, 20, 20);
    text("Score: " + score, 20, 40);
    text("Press T for Trails", 20, 60);

    //Player Movement
    if (keyPressed) {
      if (keyCode == RIGHT) px += step;
      if (keyCode == LEFT)  px -= step;
      if (keyCode == DOWN)  py += step;
      if (keyCode == UP)    py -= step;
    }

    //Keep player inside screen
    px = constrain(px, pr, width - pr);
    py = constrain(py, pr, height - pr);

    //Helper easing follow
    hx = hx + (px - hx) * ease;
    hy = hy + (py - hy) * ease;

    //Orb Movement
    ox += xs;
    oy += ys;

    //Bounce
    if (ox > width - or || ox < or) xs *= -1;
    if (oy > height - or || oy < or) ys *= -1;

    //Collision Detection
    float d = dist(px, py, ox, oy);

    if (d < pr + or) {
      score++;

      //Random reset orb
      ox = random(or, width - or);
      oy = random(or, height - or);

      //Increase speed slightly
      xs *= 1.1;
      ys *= 1.1;
    }

    //Draw Orb
    fill(255, 120, 80);
    ellipse(ox, oy, or*2, or*2);

    //Draw Player
    fill(60, 120, 220);
    ellipse(px, py, pr*2, pr*2);

    //Draw Helper
    fill(80, 200, 120);
    ellipse(hx, hy, 14, 14);
  }

  //End Screen
  if (state == 2) {
    background(245);
    textAlign(CENTER, CENTER);
    fill(0);

    textSize(28);
    text("Time Over!", width/2, height/2 - 30);

    textSize(20);
    text("Final Score: " + score, width/2, height/2);

    textSize(18);
    text("Press R to Restart", width/2, height/2 + 40);
  }
}

//Key Events
void keyPressed() {

  //Start Game
  if (state == 0 && keyCode == ENTER) {
    state = 1;
    startTime = millis();
    score = 0;

    //Reset Speeds
    xs = 4;
    ys = 3;
  }

  //Restart
  if (state == 2 && (key == 'r' || key == 'R')) {
    state = 0;
  }

  //Trails Toggle
  if (key == 't' || key == 'T') {
    trails = !trails;
  }
}
