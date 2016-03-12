/* Sketch to attempt to write an algorithm that says whether the treasure
 can be split or not and how the treasure needs to be split.
 Assumption is made that ea individual treasure element and villian element
 are discrete values.*/

// Tristan Skinner
// 09/03/2016

// Attributes
//--------------------------------------------------------------------------------//
// https://github.com/guardian/pairing-tests/tree/master/split-the-treasure
// Professor David Scott, Cambridge University
//--------------------------------------------------------------------------------//

// Import libraries
//--------------------------------------------------------------------------------//
import java.util.HashSet;
//--------------------------------------------------------------------------------//

// Global variables
//--------------------------------------------------------------------------------//
HashSet<int[]> spoils = new HashSet<int[]>();  

int[] trsre1 = {4, 4, 4};
int[] trsre2 = {27, 7, 20};
int[] trsre3 = {6, 3, 2, 4, 1};
int[] trsre4 = {3, 2, 7, 7, 14, 5, 3, 4, 9, 2};
int[] trsre5 = {3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2};
int[] trsre6 = {1, 2, 3, 4, 5};

int[] trove;  // for updtng

int noVllns;
//--------------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//
//--------------------------------- Setup Start ----------------------------------//
//--------------------------------------------------------------------------------//

void setup() {

  // Decalre glbl vals.
  //--------------------------------------------------------------------------------//
  trove = trsre6;  // for updtng  
  noVllns = 3;  // for updtng, >1, <= trove lngth
  //--------------------------------------------------------------------------------//

  // Local variables
  //--------------------------------------------------------------------------------//
  HashSet<int[]> troveCmbntns = new HashSet<int[]>();
  int[][] gemGrid = new int[trove.length][trove.length];
  //--------------------------------------------------------------------------------//

  // Frst chck if no vllns eqls no gems.
  //--------------------------------------------------------------------------------//
  if (noVllns == trove.length) {
    eqlValCHckr();
  }
  //--------------------------------------------------------------------------------//

  // Secondly create hsh of all gem cmbntns
  //--------------------------------------------------------------------------------//
  int[] crcle = trove;
  for (int i = 0; i < crcle.length; i++) {
    if (i !=0) {  // dont's excte frst time
      IntList loopLst = new IntList();
      for (int indx = 1; indx < crcle.length; indx++) {
        loopLst.append(crcle[indx]);
      }
      loopLst.append(crcle[0]);
      crcle = loopLst.array();
    }  // not frst time

    for (int ii = 0; ii < crcle.length; ii++) {
      gemGrid[i][ii] = crcle[ii];
    }
  }
  // Push into hsh of uniq combntns.
  for (int i = 0; i < crcle.length; i++) {
    IntList gridRow = new IntList();
    for (int ii = 0; ii < crcle.length; ii++) {
      gridRow.append(gemGrid[i][ii]);  // debug - delete
    }
    int[] row = gridRow.array();
    troveCmbntns.add(row);
  }
  // Debug - delete
  /*for (int[] i : troveCmbntns) {
   println(i);
   }*/
  //println(troveCmbntns.size());  // debug - delete
  //--------------------------------------------------------------------------------//

  // Nxt, loop thrgh pssble gem allctns for ea cmbntn.
  //--------------------------------------------------------------------------------//
  for (int[] cmboRow : troveCmbntns) {
    //println(cmboRow);  // debug - delete    
    int[] vllnPos = new int[noVllns];  // trck srt and end elmnt nos
    for (int i = 0; i < vllnPos.length; i++) {
      vllnPos[i] = i;
    }

    // Calculate v1's frst strt and end elmnt indxs.
    int maxFrstElmnts = cmboRow.length - (noVllns - 1);
    
    for (int i = 0; i < vllnPos.length; i++) {
      if (i == 0) {  // frst vlln
        IntList v1Lst = new IntList();
        for (int ii = 0; ii < maxFrstElmnts; ii++) {
          v1Lst.append(cmboRow[ii]);
        }
        int xElmnt = maxFrstElmnts;
        println(v1Lst);  // debug - delete
      } else {  // rest of vllns
      IntList vXlst = new IntList();
      vXlst.append(cmboRow[xElmnt]);
      println(vXlst);  // debug - delete
      }
      maxFrstElmnts--;
    }
  }  
  //--------------------------------------------------------------------------------//

  // Finally, print results empty or othrwse of the spoils hsh.
  //--------------------------------------------------------------------------------//
  //printResult();
  //--------------------------------------------------------------------------------//

  exit();
}  // setup enclsng brce
//--------------------------------------------------------------------------------//
//---------------------------------- Setup End -----------------------------------//
//--------------------------------------------------------------------------------//

// Mthd to add an equal share to the spoils.
//--------------------------------------------------------------------------------//
void addAspoil(int[] trove) {
  // Always sort array to avoid duplicates.
  trove = sort(trove);
  spoils.add(trove);
}
//--------------------------------------------------------------------------------//

// Mthd to print results of spoils hsh once comparisons exhstd and exit.
//--------------------------------------------------------------------------------//
void printResult() {
  // todo: Refact!
  if (spoils.isEmpty()) {
    println("Not possible to equally divide between " + noVllns + " villians.");
  } else {
    println("Yes, possible to split between no of villians: " + noVllns);
    for (int[] i : spoils) {
      println(i);
    }
  }
  exit();  // end oprtn
}
//--------------------------------------------------------------------------------//

// Mthd to chck whther gems hold eql vals.
//--------------------------------------------------------------------------------//
void eqlValCHckr() {
  boolean same = false;  // dflt flse
  int prevInt = trove[0];
  for (int i = 1; i < trove.length; i++) {
    if (prevInt != trove[i]) {
      println("Not possible to equally divide between " + noVllns + " villians.");
      exit();
    } else {
      prevInt = trove[i];
    }
  }
  // No break so add a spoil, print result and exit.
  addAspoil(trove);
  printResult();
}
//--------------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//
//------------------------------ Functionality End -------------------------------//
//--------------------------------------------------------------------------------//