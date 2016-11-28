import java.util.*;

List<LineSeg> lineList;
color RED = color(255, 0, 0);
color GREEN = color(0, 255, 0);
color BLUE = color(0, 0, 255);
color BLACK = color(0);
Random randInst = new Random();
boolean settingLine = false;
double settingLineX0 = 0;
double settingLineY0 = 0;

BSPTree renderPriorityTree = null;
Point perspectivePt = null;

public void setup()
{
  size(640, 480);
  lineList = new ArrayList<LineSeg>();
  lineList.add(new LineSeg(100, 100, 175, 100, BLUE));
  lineList.add(new LineSeg(100,75,100,125,GREEN));
  lineList.add(new LineSeg(50,70,110,200,RED));
  lineList.add(new LineSeg(170,140,200,80,BLACK));
  strokeWeight(5);
  
  renderPriorityTree = new BSPTree(lineList);
  println("RED : "+RED);
  println("GREEN : "+GREEN);
  println("BLUE : "+BLUE);
  println("BLACK : "+BLACK);
  renderPriorityTree.printTree();
}

public void draw()
{
  background(200);
  
  perspectivePt = new Point(200,200);
  List<LineSeg> renderList = renderPriorityTree.getRenderList(perspectivePt);
  
  for (LineSeg curr : lineList)
  {
    stroke(curr.getColor());
    line(curr);
  }
  if (settingLine)
  {
    stroke(GREEN);
    line(settingLineX0, settingLineY0, mouseX, mouseY);
  }
}

public Point findIntersection(LineSeg lineA, LineSeg lineB)
{
  /*For an explanation on how this works see this StackOverflow question
    http://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect*/
  
  Point basePtA = lineA.getPts().get(0);
  Point diffPtA = this.pointDiff(lineA.getPts().get(1), basePtA);
  Point basePtB = lineB.getPts().get(0);
  Point diffPtB = this.pointDiff(lineB.getPts().get(1), basePtB);
  
  //t = (q − p) × s / (r × s)
  Point QdiffP = this.pointDiff(basePtB, basePtA);
  double t = this.twoDCrossProd(QdiffP, diffPtB);
  double RcrossS = this.twoDCrossProd(diffPtA, diffPtB);
  t /= RcrossS;
  
  Point scaledDiff = diffPtA.scale(t);
  
  return new Point(basePtA.x + scaledDiff.x,basePtA.y + scaledDiff.y);
}

public double twoDCrossProd(Point a, Point b)
{
  return a.x * b.y - b.x * a.y;
}

public Point pointDiff(Point a, Point b)
{
  return new Point(a.x - b.x, a.y - b.y);
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