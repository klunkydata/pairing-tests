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
import java.util.Set;
import java.util.HashSet;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
//--------------------------------------------------------------------------------//

// Global variables
//--------------------------------------------------------------------------------//
int[] trsre1 = {4, 4, 4};
int[] trsre2 = {27, 7, 20};
int[] trsre3 = {6, 3, 2, 4, 1};
int[] trsre4 = {3, 2, 7, 7, 14, 5, 3, 4, 9, 2};
int[] trsre5 = {3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2};
int[] trsre6 = {1, 2, 3, 4, 5};

IntList trove = new IntList();  // for updtng
int troveSum;

int noVllns;  //  >1, <= noGems
int targetVal;  // val to target for ea vlln

HashSet<IntList> troveCombos = new HashSet<IntList>();
int[][] gemGrid = new int[trove.size()][trove.size()];
//--------------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//
//--------------------------------- Setup Start ----------------------------------//
//--------------------------------------------------------------------------------//

void setup() {

  // Decalre glbl vals.
  //--------------------------------------------------------------------------------//
  popGemLst(trsre6);  // for updtng, pop lst
  troveSum = sumLst();
  noVllns = 3;  // for updtng, >1, <= trove lngth
  // First, chck total val is discrete divisble by no vllns.
  targetVal = divDiscrete();
  //--------------------------------------------------------------------------------//

  // Local variables
  //--------------------------------------------------------------------------------//
  //--------------------------------------------------------------------------------//

  // Chck if any vals exceed pursed val,
  indvGemExcd();

  // Create 2d array of gem combinations.
  popTroveCombos();

  // Perform calculations to see if a pattern is possible
  //--------------------------------------------------------------------------------//
  // Loop thrgh ea arry.
  for (IntList row : troveCombos) {
    if (row.get(0) == targetVal) {
      IntList spoil = new IntList();
      spoil.append(row.get(0));
      addTrgt(spoil);
    } else if (row.get(0) < targetVal) {
      trvrse(row);  // launch mthd to itrte thrgh row pttrns
    }
  } // ea combo row enclsng brce  
  //--------------------------------------------------------------------------------//

  exit();
}  // setup enclsng brce
//--------------------------------------------------------------------------------//
//---------------------------------- Setup End -----------------------------------//
//--------------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//
//----------------------------- Functionality Start ------------------------------//
//--------------------------------------------------------------------------------//

// Loop thrgh pssble combntns of crrct trgt pttrns per row.
//--------------------------------------------------------------------------------//
void trvrse(IntList row) {
  boolean spaceRght;
  int noElmtns = row.size();
  int prtnrs = noVllns - 1;
  println(row);  // debug - delete
  
  // Frst chck there's initlly engh space.
  spaceRght = chckSpace(2, prtnrs, noElmtns);
  // Whlst there's space to accmdte new pttrn and prtnrs.
  int elmntI = 1;
  //while (spaceRght) {
    // Strtng at indx 1.
    for (int i = 1; i < row.size(); i++) {
      int pttrn = row.get(0) + row.get(i);  // accmltr
       if (pttrn == targetVal) {
         IntList spoil = new IntList();
              spoil.append(pttrn);
              addTrgt(spoil);
              println(i + " " + pttrn);  // debug - delete
              break;
       } else if (pttrn > targetVal) {
         //println(row.get(0) + " " + i + " " + pttrn + " " + targetVal);  // debug - delete
         break;
       }
       else {
         //println(i + " " + pttrn);  // debug - delete
       }
       //println(i + " " + pttrn);  // debug - delete
    }
   spaceRght = false;  // debug - safety hndle 
  //} // while enclsng brce  
}  // mthd enclsng brce
//--------------------------------------------------------------------------------//

  // Check there's space for trvrsng inx0 and room to the rght for prtnrs.
//--------------------------------------------------------------------------------//
  boolean chckSpace(int noElmntsTrvrsd, int prtnrs, int noElmnts) {
    boolean spaceRght;
    
    if (noElmntsTrvrsd + prtnrs <= noElmnts) {
    spaceRght = true;
  } else {
    spaceRght = false;
  }
  return spaceRght;
  }  // mthd enclsng brce
 //--------------------------------------------------------------------------------//
  
 // Add a combo of gems that matches target val to hshmp
//--------------------------------------------------------------------------------//
void addTrgt(IntList spoil) {
  HashMap<String, IntList> pttrns = new HashMap<String, IntList>();  // global
  //println(spoil.size() + "hey");  // debug - delete
}  // mthd enclsng brce
//--------------------------------------------------------------------------------//

// Create hsh of diff gem cmbntns.
//--------------------------------------------------------------------------------//
void popTroveCombos() {

  int[] crcle = trove.array();
  for (int i = 0; i < crcle.length; i++) {
    IntList comboRow = new IntList();
    for (int ii = 1; ii < crcle.length; ii++) {  // dont add frst elmnt  
      comboRow.append(crcle[ii]);
    }
    comboRow.append(crcle[0]);
    troveCombos.add(comboRow);
    crcle = comboRow.array();
  }
  //println(troveCombos.size());  // debug - delete
}  // mthd enclsng brce
//--------------------------------------------------------------------------------//

// Mthd to chceck total val is discrete divisble by no vllns.
//--------------------------------------------------------------------------------//
int divDiscrete() {
  int mdlo = troveSum % noVllns;
  if (mdlo !=0) {  // finish oprtn
    String mssge = "No vllns no discrete divisible with no of gems.";
    messageFlse(mssge);
  }

  int valPerVlln = troveSum / noVllns;  // val/ cmb of val to look for
  //println(valPerVlln);  // debug
  return valPerVlln;
}  // mthd enclsng brce
//--------------------------------------------------------------------------------//

// Mthd to chck if any single gem is greater than pursued val.
//--------------------------------------------------------------------------------/
// If so, end oprtn.
void indvGemExcd() {
  if (trove.max() > targetVal) {
    String reason = "Val of a sngl gem/ s exceeds vlln's target val (" + targetVal + ").";
    messageFlse(reason);
  }
}  // mthd enclsng brce
//--------------------------------------------------------------------------------/

// Write error message, vals aren't equally discrete divisble.
//--------------------------------------------------------------------------------//
void messageFlse(String errorMssge) {
  // refact
  println(errorMssge);
  println("Treasure can't be equally divided between " + noVllns + " villians.\nrrrr");
  println(trove);
  exit();
}  // mthd enclsng brce
//--------------------------------------------------------------------------------//

// Pop lst with ea gem val.
//--------------------------------------------------------------------------------//
void popGemLst(int[] trsreArry) {
  for (int i = 0; i < trsreArry.length; i++) {
    trove.append(trsreArry[i]);
    trove.sort();
  }
}
// mthd enclsng brce
//--------------------------------------------------------------------------------//

// Mthd to sum all gem vals in in a lst.
//--------------------------------------------------------------------------------//
int sumLst() {
  int total = 0;
  for (int no : trove) {
    total = total + no;
  }
  return total;
}  // mthd enclsng brce
//--------------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//
//------------------------------ Functionality End -------------------------------//
//--------------------------------------------------------------------------------//