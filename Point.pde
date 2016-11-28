public class Point
{
  public double x;
  public double y;
  
  public Point(double x, double y)
  {
    this.x = x;
    this.y = y;
  }
  
  public double length()
  {
    return sqrt((float)(x * x + y * y));
  }
  
  public String toString()
  {
    return "("+this.x+", "+this.y+")";
  }
}

public double dot(Point u, Point v)
{
  return u.x * v.x + u.y * v.y;
}