//The FuelBlock Class
//Creates a object that the player can pick up to get more fuel
//Functions include Constructors, Accessors, Mutators, and Colliders
class FuelBlock {
    //Variables for the FuelBlock Object/Class
    private float x;
    private float y;
    private int fuel;
    
    //The Basic FuelBlock Constructor - Creates a fuel block that has 600 fuel
    //@param x is the x location of the FuelBlock Object
    //@param y is the y location of the FuelBlock Object
    FuelBlock(float x, float y) {
        this.x = x;
        this.y = y;
        this.fuel = 600;  
        redrawFuelBlock(); 
    }
    
    //The Custom FuelBlock Constructor - Creates a fuel block that has a set fuel
    //@param x is the x location of the FuelBlock Object
    //@param y is the y location of the FuelBlock Object
    //@param fuel is the amount of fuel in the FuelBlock Object
    FuelBlock(float x, float y, int fuel) {
        this.x = x;
        this.y = y;
        this.fuel = fuel;  
        redrawFuelBlock(); 
    }
    
    //The redrawFuelBlock Function - Redraws the fuel block where it is
    void redrawFuelBlock() {
        fill(#FFA500);
        rect(this.x, this.y, 5, 5);   
    }
    
    //The pickedUp Function - Sees if the player has picked up the Fuel Block yet
    //@param playerX is the x coordinate of the top left corner of the player
    //@param playerY is the y coordinate of the top left corner of the player
    //@param playerWidthX is the length of the player on the x coordinate
    //@param playerWidthY is the length of the player on the y coordinate
    //@return boolean that is true when the player picks up the Fuel Block
    boolean pickedUp(float playerX, float playerY, int playerWidthX, int playerWidthY) {
        //Checks the X coordinate first then the Y coordinate for speed and readability
        if (playerX > (this.x-playerWidthX) && playerX < (this.x + 5)) {
            if (playerY > (this.y-playerWidthY) && playerY < (this.y + 5)) {
                return true;
            }
        } 
        return false;
    }
    
    //The getX Function - Gives the X coordinate of the FuelBlock
    //@returns the X location of the FuelBlock
    float getX() {
        return this.x;   
    }
    
    //The getY Function - Gives the Y coordinate of the FuelBlock
    //@returns the Y location of the FuelBlock
    float getY() {
        return this.y;   
    }
    
    //The getFuel Function - Gives the amount of fuel in the object
    //@returns the amount of fuel in the FuelBlock Object
    int getFuel() {
        return this.fuel;   
    }
}
