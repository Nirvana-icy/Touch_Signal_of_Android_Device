/**
 * Mouse Signals. 
 * 
 * Move and click the mouse to generate signals. 
 * The top row is the signal from "mouseX", 
 * the middle row is the signal from "mouseY",
 * and the bottom row is the signal from "mousePressed". 
 */
 
int[] xvals;
int[] yvals;
int[] bvals;
float mx[];
float my[];

int num = 30;

void setup() 
{
  //size(640,960);
  xvals = new int[width];  //This array contain all the x value(screen width)
  yvals = new int[width];
  bvals = new int[width];  //bvals means touch pressed
  mx = new float[num];
  my = new float[num];
  frameRate(30);           //Set the frameRate match with the gesture engine
}

void draw()
{
  background(51);
  //Everyframe we move all the element right and add the new value to the array
  for(int i=1; i<width; i++) { 
    xvals[i-1] = xvals[i]; 
    yvals[i-1] = yvals[i];
    bvals[i-1] = bvals[i]; 
  } 
  // Add the new values to the end of the array 
  xvals[width-1] = mouseX; 
  yvals[width-1] = mouseY;
  //Draw the x&y value to the screen
  textSize(18);
  text("X:" + mouseX,6,6,0.3*width,20);
  text("Y:" + mouseY,6,0.5*height+6,0.3*width,3*height/7+20);
  //When the Touch happened,set to draw the line 
  if(mousePressed) {
    bvals[width-1] = height/7;
  } else {
    bvals[width-1] = 0;
  }
  //Every frame draw all the points in the array. 
  for(int i=1; i<width; i++) {
    //Draw the point which indicator the X value
    stroke(255,0,0);
    ellipse(i, 0.3*xvals[i],2,2);
    //Draw the point which indicator the Y value
    stroke(0,255,0);
    ellipse(i, 0.5*height+yvals[i]/3,2,2);
    //Draw the lines when Touch Pressed happen
    stroke(10,0,225);
    line(i, 6*height/7, i, (6*height/7+bvals[i]));
  }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // Cycle through the array, using a different entry on each frame. 
  // Using modulo (%) like this is faster than moving all the values over.
  int which = frameCount % num;
  
  mx[which] = mouseX;
  my[which] = mouseY;

  noStroke();
  
  for (int i = 0; i < num; i++) {
    // which+1 is the smallest (the oldest in the array)
    int index = (which+1 + i) % num;
    ellipse(mx[index], my[index], i, i);
  }
}
