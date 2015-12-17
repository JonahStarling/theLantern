//The Lantern Class
//Only allows the player to see the area that the lantern lights up
//Functions include Constructors, accessors, and mutators
class Lantern {
    //Variables for the Lantern Object/Class
    private float x;
    private float y;
    private int size;
    private float fuelLevel;
    private ArrayList<int[]> vertices;
    
    //The Basic Lantern Constructor - Creates a Lantern with the default fuelLevel
    //@param x is the x location of the Lantern
    //@param y is the y location of the Lantern
    //@param size is the size of the Lantern's reach
    Lantern(float x, float y, int size) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.fuelLevel = 6000;
        vertices = new ArrayList();
        redrawLantern();
    }
    
    //The Advanced Lantern Constructor - Allows you to set a different fuelLevel
    //@param x is the x location of the Lantern
    //@param y is the y location of the Lantern
    //@param size is the size of the Lantern's reach
    //@param fuelLevel is the amount of fuel the player has
    Lantern(float x, float y, int size, float fuelLevel) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.fuelLevel = fuelLevel;
        vertices = new ArrayList();
        redrawLantern();
    }
    
    //The redrawLantern Function - Redraws the Lantern at its current location
    void redrawLantern() {
        //The stroke weight is set high so it covers the entire screen
        //strokeWeight(1400);
        //ellipse(this.x, this.y, 1200-((this.size-1)*100), 1200-((this.size-1)*100));
        for (int i = 0; i < this.vertices.size(); i++) {
            ArrayList<int[]> tempVals = new ArrayList();
            int[] temp1 = this.vertices.get(i); // Top Left Vertex
            tempVals.add(temp1);
            i++;
            int[] temp2 = this.vertices.get(i); // Top Right Vertex
            tempVals.add(temp2);
            i++;
            int[] temp3 = this.vertices.get(i); // Bottom Left Vertex
            tempVals.add(temp3);
            i++;
            int[] temp4 = this.vertices.get(i); // Bottom Right Vertex
            tempVals.add(temp4);
            noStroke();
            fill(0,0,0,200);
            //Create a normalization function
            quad(temp4[0],temp4[1],temp1[0],temp1[1],
                (((temp1[0]-this.x)*800)+temp1[0]),
                (((temp1[1]-this.y)*800)+temp1[1]),
                (((temp4[0]-this.x)*800)+temp4[0]),
                (((temp4[1]-this.y)*800)+temp4[1]));
            quad(temp3[0],temp3[1],temp2[0],temp2[1],
                (((temp2[0]-this.x)*800)+temp2[0]),
                (((temp2[1]-this.y)*800)+temp2[1]),
                (((temp3[0]-this.x)*800)+temp3[0]),
                (((temp3[1]-this.y)*800)+temp3[1]));
            stroke(0);
        }
        fill(0,0,0,0);
        //The stroke weight is set high so it covers the entire screen
        strokeWeight(50);
        stroke(0,0,0,50);
        ellipse(this.x, this.y, 250+((this.size-1)*100), 250+((this.size-1)*100));
        stroke(0,0,0,100);
        ellipse(this.x, this.y, 350+((this.size-1)*100), 350+((this.size-1)*100));
        //This sets the inner part of the circle clear so you can see
        if (this.fuelLevel <= 2000) {
            fill(#000000, 200 - (this.fuelLevel / 10));
        } else {
            fill(#000000, 0);
        }
        strokeWeight(1400);
        stroke(0,0,0,255);
        ellipse(this.x, this.y, 1000-((this.size-1)*100), 1000-((this.size-1)*100));
        //Reset the stroke weight
        strokeWeight(1);
        updateFuelLevel();
        updateFuelBar();
    }
    
    void increaseSize() {
        if (this.size != 3) {
            this.size++;
        } else {
            this.size = 1;   
        }
    }
    
    void setVertices(ArrayList<int[]> vertices) {
        this.vertices = vertices;
    }
    
    //The getX Function - Gives the X coordinate of the Lantern
    //@returns the X location of the Lantern
    float getX() {
        return this.x;
    }
    
    //The getY Function - Gives the Y coordinate of the Lantern
    //@returns the Y location of the Lantern
    float getY() {
        return this.y;
    }
    
    //The getSize Function - Gives the size of the Lantern
    //@returns the size of the Lantern
    int getSize() {
        return this.size;
    }
    
    //The getFuelLevel Function - Gives the fuelLevel of the Lantern
    //@returns the fuelLevel of the Lantern
    float getFuelLevel() {
        return this.fuelLevel;
    }

    //The setX Function - Sets the X coordinate of the Lantern
    //@param x is the new x location of the Lantern
    void setX(float x) {
        this.x = x;
    }
    
    //The setY Function - Sets the Y coordinate of the Lantern
    //@param y is the new y location of the Lantern    
    void setY(float y) {
        this.y = y;
    }
    
    //The setSize Function - Sets the size of the Lantern
    //@param size is the new size of the Lantern
    void setSize(int size) {
        this.size = size;
    }
    
    //The setFuelLevel Function - Sets the fuelLevel of the Lantern
    //@param fuelLevel is the new fuelLevel of the Lantern
    void setFuelLevel(float fuelLevel) {
        this.fuelLevel = fuelLevel;   
    }
    
    //The addFuel Function - Adds fuel to the Lantern
    //@param fuel is how much fuel to add to the fuelLevel
    void addFuel(float fuel) {
        this.fuelLevel += fuel;   
    }
    
    //The updateFuelLevel Function - Diminshes the fuel overtime based on size
    void updateFuelLevel() {
        this.fuelLevel -= pow(2, this.size - 1);
    }
    
    //The updateFuelBar Function - Creates a bar that indicates the current Fuel Level
    void updateFuelBar() {
        //This creates the outline for the Fuel Bar
        stroke(#FFFFFF);
        rect(650,10,100,10);
        //This creates the Fuel Bar indicator
        fill(#FFFFFF);
        rect(650,10,((this.fuelLevel/6000)*100),10);
        stroke(#000000);
    }
}