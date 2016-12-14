<<<<<<< HEAD
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
  
  public Point scale(double scalar)
  {
    return new Point(x * scalar, y * scalar);
  }
  
  public String toString()
  {
    return "("+this.x+", "+this.y+")";
  }
}

public double dot(Point u, Point v)
{
  return u.x * v.x + u.y * v.y;
=======
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
  
  public Point scale(double scalar)
  {
    return new Point(x * scalar, y * scalar);
  }
  
  public String toString()
  {
    return "("+this.x+", "+this.y+")";
  }
}

public double dot(Point u, Point v)
{
  return u.x * v.x + u.y * v.y;
>>>>>>> bc6188aba9256671c33ab849afb51fd8fe1c0e40
}