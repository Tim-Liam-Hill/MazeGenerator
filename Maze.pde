import java.util.Stack;
import java.util.concurrent.ThreadLocalRandom;
import java.util.Arrays;

class Maze{
  
   int rows;
   int cols;
   int xOff, yOff;
   Cell startCell;  
   Cell [] [] cells;
   final int cellSize = 20;
   final color pathColor = color(255, 255, 255);
   final color wallColor = color(90, 90, 10);
   final color currentCell = color(255,102, 153);
   final color visitedCell = color(204, 255, 153);
   boolean stepOnce;
   boolean completed;
   Integer [] currentCellPos;
   Integer [] startCellPos;
   Stack<Integer[]> cellStack;
  
  Maze(int r, int c, int xOffset,int yOffset)
  {
    xOff = xOffset;
    yOff = yOffset;
    rows = r;
    cols = c;
    this.initializeMaze();
    
  }
  
  //initialise maze------------------------------------------------------------------------------------------------------------------------------------------------
  
  void initializeMaze()
  {
      cellStack = new Stack<Integer[]>();  //moved from constructor so that we can reuse this function for resetting
      stepOnce = false;
      completed = false;
      cells = new Cell[2*rows - 1][];
      for(int i=0; i< 2*rows-1; ++i)
      {
          cells[i] = new Cell[2*cols - 1];
         for(int j=0; j< 2 * cols - 1; ++j)
         {
             if((i + j) % 2 ==0 && i % 2 == 0) //path
               cells[i][j] = new Cell(i, j, Type.PATH);
             else cells[i][j] = new Cell(i, j, Type.WALL);   
         }
      }
      currentCellPos = this.chooseStartCell();
      startCellPos = currentCellPos;
      cells[startCellPos[0]][startCellPos[1]].visited = true;
      cellStack.push(startCellPos);
  }
  
  Integer [] chooseStartCell()
  {
    int x = ThreadLocalRandom.current().nextInt(0, rows);
    int y = ThreadLocalRandom.current().nextInt(0, cols);
    Integer [] ans = new Integer[2];
    
    
    if(x % 2 != 0)
    {  //move up or down since we cant be in this row
          if(ThreadLocalRandom.current().nextInt(0,1 + 1) == 1)
            x ++;
          else x--;
    }
    if( (x+y) % 2 != 0 )  //y should have an open spot on either side
    {
       if(ThreadLocalRandom.current().nextInt(0,1 + 1) == 1)
            y ++;
          else y--;
    }
    
    ans[0] = x;
    ans[1] = y;
    
    return ans;
  }
  

  //Maze Creation----------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  void generate()
  {
    if(!completed)
    {
        if(choice == Choice.RUN)
          this.iterateOnce();
        else if(stepOnce)
        {
           stepOnce = false;
           this.iterateOnce();
        }
    }
  }
  
  void iterateOnce()    //take average of adjacent cell and current cell to get wall cell
  {
      //System.out.println(cellStack.size());            //Debugging porpoises
      if(cellStack.size() == 0)
      {
          choice = Choice.FINISHED;
          completed = true;
      }
      else
      {
          Integer [] adjacentCell = this.getAdjacentCell(cellStack.peek());
          //System.out.println(adjacentCell[0] + " " + adjacentCell[1]);        //debugging
          //System.out.println(pathCell[0] + " " + pathCell[1]);                //debugging
          
          if(adjacentCell != null)
          {
              Integer [] pathCell = this.getPathCell(cellStack.peek(), adjacentCell);
              cellStack.push(adjacentCell);
              cells[adjacentCell[0]][adjacentCell[1]].visited = true;
              cells[pathCell[0]][pathCell[1]].type =Type.PATH;
          }
          else
          {
              cellStack.pop();
          }
          if(!cellStack.empty())
            currentCellPos = cellStack.peek();
          
      }
  }
  
  Integer [] getAdjacentCell(Integer [] pos) //returns null if there is no adjacent unvisited cell
  {
    //we only ever iterate by two so there is no chance of the 'off' rows becoming part of the selection algorithm process
     ArrayList<Integer> indices = new ArrayList<Integer>(Arrays.asList(0,1,2,3));
     Integer [] ans = null;    
     //System.out.println("Finding adjacent cell--------------------------------------------");      //Debugging porpoises
     
     
      while(ans == null && indices.size() >0)
      {
          int index;
          if(indices.size() != 0)
             index =ThreadLocalRandom.current().nextInt(0,indices.size());  //will cry if told to generate a value between 0 and 0
          else index = 0;
          int temp = indices.get(index);
          int newX = -1, newY = -1;
          
          switch(temp)
          {
              case 0:  newX = pos[0] + 2;      //go right
                       newY = pos[1];
                break;
              case 1:  newX = pos[0] - 2;     //left
                       newY = pos[1];
                break;
              case 2:  newX = pos[0];        //up
                       newY = pos[1] -2;
                break;
              case 3:  newX = pos[0];      //down
                       newY = pos[1] + 2;
                break;
          }
            
          if(newX >= 0 && newX < 2*rows - 1 && newY >=0 && newY < 2*cols - 1)
          {
            if(cells[newX][newY].visited != true)  //only return if visited
            {
              ans = new Integer[2];
              ans[0] = newX;
              ans[1] = newY;
            }
            else
            {
               indices.remove(index);
            }
          }
          else indices.remove(index);
      }
     
    return ans;
  }
  
  Integer [] getPathCell(Integer [] curr, Integer [] adjacentCell)
  {
    Integer [] pathCell = new Integer[2];
    pathCell[0] = (curr[0] + adjacentCell[0])/2;
     pathCell[1] = (curr[1] + adjacentCell[1])/2;
     return pathCell;
  }
  
  //Printing maze--------------------------------------------------------------------------------------------------------------------------------------------------
  
  void print()
  {
    for(int i=0; i<cells.length; ++i)
    {
      for(int j=0; j<cells[i].length; ++j)
      {
         stroke(wallColor);
         if(cells[i][j].type == Type.PATH && !cells[i][j].visited)    //make visited ones look different
           fill(pathColor);
         else if(cells[i][j].type == Type.PATH)
           fill(pathColor);    //visited cell for clearer nonsesne
         else  fill(wallColor);
          
          rect(xOff + i * cellSize, yOff + j*cellSize, cellSize, cellSize);
      }
    }
    
    fill(currentCell);
    rect(xOff + currentCellPos[0] * cellSize, yOff + currentCellPos[1] * cellSize, cellSize, cellSize);
  }
  
  //Export Maze to a file-------------------------------------------------------------------------------------------------------------------------------------------
  
}
