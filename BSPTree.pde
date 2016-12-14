<<<<<<< HEAD
public class BSPTree
{
  private BSPTreeNode root;
  
  public BSPTree(List<LineSeg> localLineList)
  {
    localLineList = new ArrayList<LineSeg>(localLineList);
    this.root = new BSPTreeNode(localLineList.remove(0));
    List<LineSeg> linesInFront = new ArrayList<LineSeg>();
    List<LineSeg> linesBehind = new ArrayList<LineSeg>();
    
    for(LineSeg currLine : localLineList)
      {
        List<Point> currPts = currLine.getPts();
        boolean pt0InFront = inFrontOf(currPts.get(0), this.root.getLine());
        boolean pt1InFront = inFrontOf(currPts.get(1), this.root.getLine());
        
        if(pt0InFront && pt1InFront)
        {
          linesInFront.add(currLine);
        }
        else
        if(!pt0InFront && !pt1InFront)
        {
          linesBehind.add(currLine);
        }
        else
        {
          /*in this case currLine is only partially in front of the reference line
            this means that we will have to split the line into two different lines:
            one in front of the reference line, and one behind it to add to each list*/
          LineSeg linePartInFront;
          LineSeg linePartBehind;
          Point intersectPt = findIntersection(currLine, this.root.getLine());
          
          if(pt0InFront)
          {
            linePartInFront = new LineSeg(currPts.get(0), intersectPt, currLine.getColor());
            linePartBehind = new LineSeg(intersectPt, currPts.get(1), currLine.getColor());
          }
          else
          {
            linePartInFront = new LineSeg(currPts.get(1), intersectPt, currLine.getColor());
            linePartBehind = new LineSeg(intersectPt, currPts.get(0), currLine.getColor());
          }
          linesInFront.add(linePartInFront);
          linesBehind.add(linePartBehind);
        }
      }
    
    this.root.setInFront( this.recurConstrPri(linesInFront, this.root.getLine()));
    this.root.setBehind( this.recurConstrPri(linesBehind, this.root.getLine()));
  }
  
  private BSPTreeNode recurConstrPri(List<LineSeg> remainingLines, LineSeg referenceLine)
  {
    if(remainingLines.size() < 1)
    {
      return null;
    }
    else
    if(remainingLines.size() == 1)
    {
      return new BSPTreeNode(remainingLines.remove(0));
    } 
    else 
    {
      BSPTreeNode current = new BSPTreeNode(remainingLines.remove(0));
      List<LineSeg> linesInFront = new ArrayList<LineSeg>();
      List<LineSeg> linesBehind = new ArrayList<LineSeg>();
      
      for(LineSeg currLine : remainingLines)
      {
        List<Point> currPts = currLine.getPts();
        boolean pt0InFront = inFrontOf(currPts.get(0), referenceLine);
        boolean pt1InFront = inFrontOf(currPts.get(1), referenceLine);
        
        if(pt0InFront && pt1InFront)
        {
          linesInFront.add(currLine);
        }
        else
        if(!pt0InFront && !pt1InFront)
        {
          linesBehind.add(currLine);
        }
        else
        {
          /*in this case currLine is only partially in front of the reference line
            this means that we will have to split the line into two different lines:
            one in front of the reference line, and one behind it to add to each list*/
          LineSeg linePartInFront;
          LineSeg linePartBehind;
          Point intersectPt = findIntersection(currLine, referenceLine);
          
          if(pt0InFront)
          {
            linePartInFront = new LineSeg(currPts.get(0), intersectPt, currLine.getColor());
            linePartBehind = new LineSeg(intersectPt, currPts.get(1), currLine.getColor());
          }
          else
          {
            linePartInFront = new LineSeg(currPts.get(1), intersectPt, currLine.getColor());
            linePartBehind = new LineSeg(intersectPt, currPts.get(0), currLine.getColor());
          }
          linesInFront.add(linePartInFront);
          linesBehind.add(linePartBehind);
        }
      }
      
      current.setInFront( this.recurConstrPri(linesInFront, current.getLine()));
      current.setBehind( this.recurConstrPri(linesBehind, current.getLine()));
      
      return current;
    }
  }
  
  public List<LineSeg> getRenderList(Point perspect)
  {
    List<LineSeg> renderList = new ArrayList<LineSeg>();
    this.RLPri(perspect, this.root, renderList);
    return renderList;
  }
  
  public void RLPri(Point perspect, BSPTreeNode current, List<LineSeg> renderList)
  {
    if(current == null)
    {
      return;
    }
    else
    if(current.isLeaf())
    {
      renderList.add(current.getLine());
      return;
    }
    else
    {
      boolean isInFrontOf = inFrontOf(perspect, current.getLine());
      if(isInFrontOf)
      {
        this.RLPri(perspect, current.getBehind(), renderList);
        renderList.add(current.getLine());
        this.RLPri(perspect, current.getInFront(), renderList);
      }
      else
      {
        this.RLPri(perspect, current.getInFront(), renderList);
        renderList.add(current.getLine());
        this.RLPri(perspect, current.getBehind(), renderList);
      }
    }
  }
  
  public void printTree()
  {
    this.TSPri(this.root);
  }
  
  private void TSPri(BSPTreeNode node)
  {
    if(node == null)
    {
      return;
    }
    else
    {
      this.TSPri(node.getBehind());
      println(node.getLine().toString());
      this.TSPri(node.getInFront());
    }
  }
  
  private class BSPTreeNode
  {
    private LineSeg line;
    private BSPTreeNode inFront;
    private BSPTreeNode behind;
    
    public BSPTreeNode(LineSeg line)
    {
      this.line = line;
    }
    
    public void setInFront(BSPTreeNode node)
    {
      this.inFront = node;
    }
    
    public void setBehind(BSPTreeNode node)
    {
      this.behind = node;
    }
    
    public BSPTreeNode getInFront()
    {
      return this.inFront;
    }
    
    public BSPTreeNode getBehind()
    {
      return this.behind;
    }
    
    public LineSeg getLine()
    {
      return this.line;
    }
    
    public boolean isLeaf()
    {
      return this.inFront == null && this.behind == null;
    }
  }
=======
public class BSPTree
{
  private BSPTreeNode root;
  
  public BSPTree(List<LineSeg> localLineList)
  {
    localLineList = new ArrayList<LineSeg>(localLineList);
    this.root = new BSPTreeNode(localLineList.remove(0));
    List<LineSeg> linesInFront = new ArrayList<LineSeg>();
    List<LineSeg> linesBehind = new ArrayList<LineSeg>();
    
    for(LineSeg currLine : localLineList)
      {
        List<Point> currPts = currLine.getPts();
        boolean pt0InFront = inFrontOf(currPts.get(0), this.root.getLine());
        boolean pt1InFront = inFrontOf(currPts.get(1), this.root.getLine());
        
        if(pt0InFront && pt1InFront)
        {
          linesInFront.add(currLine);
        }
        else
        if(!pt0InFront && !pt1InFront)
        {
          linesBehind.add(currLine);
        }
        else
        {
          /*in this case currLine is only partially in front of the reference line
            this means that we will have to split the line into two different lines:
            one in front of the reference line, and one behind it to add to each list*/
          LineSeg linePartInFront;
          LineSeg linePartBehind;
          Point intersectPt = findIntersection(currLine, this.root.getLine());
          
          if(pt0InFront)
          {
            linePartInFront = new LineSeg(currPts.get(0), intersectPt, currLine.getColor());
            linePartBehind = new LineSeg(intersectPt, currPts.get(1), currLine.getColor());
          }
          else
          {
            linePartInFront = new LineSeg(currPts.get(1), intersectPt, currLine.getColor());
            linePartBehind = new LineSeg(intersectPt, currPts.get(0), currLine.getColor());
          }
          linesInFront.add(linePartInFront);
          linesBehind.add(linePartBehind);
        }
      }
    
    this.root.setInFront( this.recurConstrPri(linesInFront, this.root.getLine()));
    this.root.setBehind( this.recurConstrPri(linesBehind, this.root.getLine()));
  }
  
  private BSPTreeNode recurConstrPri(List<LineSeg> remainingLines, LineSeg referenceLine)
  {
    if(remainingLines.size() < 1)
    {
      return null;
    }
    else
    if(remainingLines.size() == 1)
    {
      return new BSPTreeNode(remainingLines.remove(0));
    } 
    else 
    {
      BSPTreeNode current = new BSPTreeNode(remainingLines.remove(0));
      List<LineSeg> linesInFront = new ArrayList<LineSeg>();
      List<LineSeg> linesBehind = new ArrayList<LineSeg>();
      
      for(LineSeg currLine : remainingLines)
      {
        List<Point> currPts = currLine.getPts();
        boolean pt0InFront = inFrontOf(currPts.get(0), referenceLine);
        boolean pt1InFront = inFrontOf(currPts.get(1), referenceLine);
        
        if(pt0InFront && pt1InFront)
        {
          linesInFront.add(currLine);
        }
        else
        if(!pt0InFront && !pt1InFront)
        {
          linesBehind.add(currLine);
        }
        else
        {
          /*in this case currLine is only partially in front of the reference line
            this means that we will have to split the line into two different lines:
            one in front of the reference line, and one behind it to add to each list*/
          LineSeg linePartInFront;
          LineSeg linePartBehind;
          Point intersectPt = findIntersection(currLine, referenceLine);
          
          if(pt0InFront)
          {
            linePartInFront = new LineSeg(currPts.get(0), intersectPt, currLine.getColor());
            linePartBehind = new LineSeg(intersectPt, currPts.get(1), currLine.getColor());
          }
          else
          {
            linePartInFront = new LineSeg(currPts.get(1), intersectPt, currLine.getColor());
            linePartBehind = new LineSeg(intersectPt, currPts.get(0), currLine.getColor());
          }
          linesInFront.add(linePartInFront);
          linesBehind.add(linePartBehind);
        }
      }
      
      current.setInFront( this.recurConstrPri(linesInFront, current.getLine()));
      current.setBehind( this.recurConstrPri(linesBehind, current.getLine()));
      
      return current;
    }
  }
  
  public List<LineSeg> getRenderList(Point perspect)
  {
    List<LineSeg> renderList = new ArrayList<LineSeg>();
    this.RLPri(perspect, this.root, renderList);
    return renderList;
  }
  
  public void RLPri(Point perspect, BSPTreeNode current, List<LineSeg> renderList)
  {
    if(current == null)
    {
      return;
    }
    else
    if(current.isLeaf())
    {
      renderList.add(current.getLine());
      return;
    }
    else
    {
      boolean isInFrontOf = inFrontOf(perspect, current.getLine());
      if(isInFrontOf)
      {
        this.RLPri(perspect, current.getBehind(), renderList);
        renderList.add(current.getLine());
        this.RLPri(perspect, current.getInFront(), renderList);
      }
      else
      {
        this.RLPri(perspect, current.getInFront(), renderList);
        renderList.add(current.getLine());
        this.RLPri(perspect, current.getBehind(), renderList);
      }
    }
  }
  
  public void printTree()
  {
    this.TSPri(this.root);
  }
  
  private void TSPri(BSPTreeNode node)
  {
    if(node == null)
    {
      return;
    }
    else
    {
      this.TSPri(node.getBehind());
      println(node.getLine().toString());
      this.TSPri(node.getInFront());
    }
  }
  
  private class BSPTreeNode
  {
    private LineSeg line;
    private BSPTreeNode inFront;
    private BSPTreeNode behind;
    
    public BSPTreeNode(LineSeg line)
    {
      this.line = line;
    }
    
    public void setInFront(BSPTreeNode node)
    {
      this.inFront = node;
    }
    
    public void setBehind(BSPTreeNode node)
    {
      this.behind = node;
    }
    
    public BSPTreeNode getInFront()
    {
      return this.inFront;
    }
    
    public BSPTreeNode getBehind()
    {
      return this.behind;
    }
    
    public LineSeg getLine()
    {
      return this.line;
    }
    
    public boolean isLeaf()
    {
      return this.inFront == null && this.behind == null;
    }
  }
>>>>>>> bc6188aba9256671c33ab849afb51fd8fe1c0e40
}