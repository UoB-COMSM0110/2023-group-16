Platform[] platform;
int platformNumber = 50;
int platformGap = 50;
Doodle doodle;
int r = 0;

void setup() {
  size(800, 500);
  //angleMode(DEGREES);

  //create platforms
  platform = new Platform[platformNumber];
  for (int i = 0; i < platformNumber; i++) {
    platform[i] = new Platform();
    platform[i].x = random(0, 700);
    platform[i].y = 500 + i * platformGap;
  }

  //set the starting status of the doodle and platform
  platform[0].x = 0;
  doodle = new Doodle();
  doodle.x = platform[0].x + 50;
  doodle.y = platform[0].y - 5;
}

void draw() {
  background(220);
  drawPlatform();
  drawDoodle();

  //make the doodle move with mouse and stay on the platform/ drop
  doodle.x = mouseX;
  if (mouseX < platform[r].x || mouseX > platform[r].x + 100) {
    doodle.y = doodle.y + 5;

    if (doodle.y > platform[r].y + 10) {
      r++;
    }
  } else {
    doodle.y = platform[r].y - 5;
  }
}

void drawPlatform() {
  fill(50, 205, 50);
  for (int i = 0; i < platformNumber; i++) {
    rect(platform[i].x, platform[i].y, 100, platform[i].height, 10);
    platform[i].y = 500 + i * platformGap - (frameCount / 0.7 % (500 + i * platformGap));

    //score
    textSize(20);
    text("SCORE:", 625, 30);
    int score = int(frameCount / 42) + 1;
    text(score, 715, 30);
  }
}

void drawDoodle() {
  pushMatrix();
  translate(doodle.x, doodle.y);

  //doodle head
  strokeWeight(1);
  //noStroke();
  point(19, -9);
  point(13, -34);
  point(-11, -34);
  point(-17, -9);
  //strokeWeight(1);

  fill(204, 245, 7);
  beginShape();
  curveVertex(19, -9);
  curveVertex(19, -9);
  curveVertex(13, -34);
  curveVertex(-11, -34);
  curveVertex(-17, -9);
  curveVertex(-17, -9);
  endShape();
  fill(204, 245, 7, 100);
  //noStroke();
  ellipse(6, -24, 1, 1);
  ellipse(12, -24, 1, 1);
  line(18, -24, 25, -25);
  line(19, -18, 25, -17);
  line(25, -25, 25, -17);
  ellipse(25, -21, 3, 7);
  noFill();

  popMatrix();
}

class Doodle {
  float x;
  float y;
}

class Platform {
  float x;
  float y;
  float height = 10;
}
