import java.util.*;

List<LineSeg> lineList;
color RED = color(255,0,0);
color GREEN = color(0,255,0);
color BLUE = color(0,0,255);
Random randInst = new Random();
boolean settingLine = false;
double settingLineX0 = 0;
double settingLineY0 = 0;

public void setup()
{
  size(640,480);
  lineList = new ArrayList<LineSeg>();
  lineList.add(new LineSeg(100,75,50,50,BLUE));
  strokeWeight(5);
  println(lineList.get(0).getPerp());
}

public void draw()
{
  background(200);
  for(LineSeg curr : lineList)
  {
    stroke(curr.getColor());
    line(curr.x0,curr.y0,curr.x1,curr.y1);
  }
  if(settingLine)
  {
    stroke(GREEN);
    line(settingLineX0, settingLineY0, mouseX, mouseY);
  }
}

public boolean inFront()
{
  return true;
}

public void mousePressed()
{
  if(!settingLine) //start a new line
  {
    settingLine = true;
    settingLineX0 = mouseX;
    settingLineY0 = mouseY;
  }
  else  //finish this line
  {
    color newLineColor = color(randInst.nextInt(255),randInst.nextInt(255),randInst.nextInt(255));
    lineList.add(new LineSeg(settingLineX0, settingLineY0, mouseX, mouseY, newLineColor));
    settingLine = false;
  }
}

public void line(double x0, double y0, double x1, double y1)
{
  line((float)x0,(float)y0,(float)x1,(float)y1);
}