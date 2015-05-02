//The Lantern Class
//Only allows the player to see the area that the lantern lights up
//Functions include Constructors, accessors, and mutators
class Lantern {
    //Variables for the Lantern Object/Class
    private float x;
    private float y;
    private int size;
    private float fuelLevel;
    
    //The Basic Lantern Constructor - Creates a Lantern with the default fuelLevel
    //@param x is the x location of the Lantern
    //@param y is the y location of the Lantern
    //@param size is the size of the Lantern's reach
    Lantern(float x, float y, int size) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.fuelLevel = 6000;
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
        redrawLantern();
    }
    
    //The redrawLantern Function - Redraws the Lantern at its current location
    void redrawLantern() {
        //This sets the inner part of the circle clear so you can see
        if (this.fuelLevel <= 2000) {
            fill(#000000, 200 - (this.fuelLevel / 10));
        } else {
            fill(#000000, 0);
        }
        //The stroke weight is set high so it covers the entire screen
        strokeWeight(350);
        ellipse(this.x, this.y, 300-((this.size-1)*25), 300-((this.size-1)*25));
        //Reset the stroke weight
        strokeWeight(1);
        updateFuelLevel();
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
    
    //The updateFuelLevel Function - Diminshes the fuel overtime based on size
    void updateFuelLevel() {
        this.fuelLevel -= pow(2, this.size - 1);
    }
}
