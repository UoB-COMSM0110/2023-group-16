ArrayList<Platform> platform;
//int platformNumber = 50;
int platformGap = 50;
Doodle doodle;
//int r = 0;
boolean addNew = false;//是否添加新的
boolean inPlatform = false;// 是否到平台上

void setup() {
  size(800, 500);
  //angleMode(DEGREES);
  //create platforms
  platform = new ArrayList();
  
  //初始化
  int y = height;
  while(y<height*2){
    float x = random(-width,0);
    while(x<width){
      if(x>0){
        platform.add(new Platform(x,y));
      }
      x+=random(width/4,width/2);
    }
    y+=platformGap; 
  }
  //println(platform.size());
  doodle = new Doodle();//初始化人
  //set the starting status of the doodle and platform
  
  doodle.x = platform.get(0).x+50;//开始人的位置
  doodle.y = 0;
}

void draw() {
  background(220);
  drawDoodle();
  inPlatform =false;
  
  for(int i=0;i<platform.size();i++){//遍历所有平台
    platform.get(i).update();//更新平台位置
    if(doodle.x>platform.get(i).x-20 && doodle.x<platform.get(i).x+110 && (abs(doodle.y-platform.get(i).y)<7) && inPlatform==false){
        doodle.y = platform.get(i).y;//匹配到平台上
        inPlatform = true;//确认在平台
    }
    
    //drawPlatform
    fill(50, 205, 50);
    rect(platform.get(i).x, platform.get(i).y, 100, 10, 10);
    if(platform.get(i).y<0){//如果出画面
      platform.remove(i);//删除
      i--;
      addNew = true;//确认添加新的
    }  
  }
  if(addNew){//添加新的平台
    float x = random(-width,0);
    while(x<width){
      if(x>0){
        platform.add(new Platform(x,height));
      }
      x+=random(width/4,width/2);
    }
    addNew = false;
  }
  if(inPlatform==false){//如果不在平台上，人会下落
    doodle.y+=5;
  }
  
    textSize(20);
    text("SCORE:", 625, 30);
    int score = int(frameCount / 42) + 1;
    text(score, 715, 30);
  if(doodle.y<0 || doodle.y>height){
    background(0);
    textAlign(CENTER);
    text("game over",width/2,height/2);
    noLoop();   
  }
  
}

//void drawPlatform() {
  
  //for (int i = 0; i < platformNumber; i++) {
    //rect(platform[i].x, platform[i].y, 100, platform[i].height, 10);
    //platform[i].y = 500 + i * platformGap - (frameCount / 0.7 % (500 + i * platformGap));
    //- (frameCount / 0.7 % (500 + i * platformGap));
    // frameCount = 501*0.7 /
    //  501 % (500) = 1
    
    //score
    
  //}
//}
void keyPressed(){
  if(key=='a'){
    doodle.x-=10;
  }
  if(key=='d'){
    doodle.x+=10;
  }
}

void drawDoodle() {
  pushMatrix();
  translate(doodle.x, doodle.y+10);
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
  int y;
}

class Platform {
  float x;
  int y;
  float height = 10;
  Platform(float x_, int y_){
    x = x_;
    y = y_;
  }
  void update(){//更新位置
    y = y - 1;
  }
  
  
}
