import java.util.*;

List<LineSeg> lineList;
color RED = color(255, 0, 0);
color GREEN = color(0, 255, 0);
color BLUE = color(0, 0, 255);
Random randInst = new Random();
boolean settingLine = false;
double settingLineX0 = 0;
double settingLineY0 = 0;

Point examplePt;

public void setup()
{
  size(640, 480);
  lineList = new ArrayList<LineSeg>();
  lineList.add(new LineSeg(100, 100, 150, 25, BLUE));
  strokeWeight(5);
  
  
}

public void draw()
{
  background(200);
  examplePt = new Point(mouseX,mouseY);
  point(examplePt);
  println(mouseX + ", " + mouseY);
  println(inFrontOf(examplePt, lineList.get(0)));
  for (LineSeg curr : lineList)
  {
    stroke(curr.getColor());
    line(curr);
    stroke(RED);
    line(curr.getPerp());
  }
  if (settingLine)
  {
    stroke(GREEN);
    line(settingLineX0, settingLineY0, mouseX, mouseY);
  }
}

public boolean inFrontOf(Point toEval, LineSeg line)
{
  Point perpVec = line.getPerp();
  Point toEvalVec = new Point(toEval.x-line.x0,toEval.y-line.y0);

  /*The angle between two vectors equation is:
   cos(theta) = dot(u,v) / (length(u) * length(v))
   */

  double angleBetween = acos((float)(dot(toEvalVec, perpVec) / (toEvalVec.length() * perpVec.length())));
  return (angleBetween < PI / 2);
}

public void mousePressed()
{
  if (!settingLine) //start a new line
  {
    settingLine = true;
    settingLineX0 = mouseX;
    settingLineY0 = mouseY;
  } else  //finish this line
  {
    color newLineColor = color(randInst.nextInt(255), randInst.nextInt(255), randInst.nextInt(255));
    lineList.add(new LineSeg(settingLineX0, settingLineY0, mouseX, mouseY, newLineColor));
    settingLine = false;
  }
}

public void line(LineSeg curr)
{
  line(curr.x0, curr.y0, curr.x1, curr.y1);
}

public void line(Point p)
{
  line(width/2, height/2, width/2+p.x, height/2+p.y);
}

public void point(Point p)
{
  point((float)(p.x), (float)p.y);
}

public void line(double x0, double y0, double x1, double y1)
{
  line((float)x0, (float)y0, (float)x1, (float)y1);
}