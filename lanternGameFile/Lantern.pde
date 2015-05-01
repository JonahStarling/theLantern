class Lantern {
    private float x;
    private float y;
    private int size;
    private float fuelLevel;
    
    Lantern(float x, float y, int size) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.fuelLevel = 6000;
        redrawLantern();
    }
    
    Lantern(float x, float y, int size, float fuelLevel) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.fuelLevel = fuelLevel;
        redrawLantern();
    }
    
    void redrawLantern() {
        //Thickness very large - stroke
        fill(#FFFFFF, 0);
        strokeWeight(300);
        ellipse(this.x, this.y, this.size+225, this.size+225);
        strokeWeight(1);
    }
    
    //Accessor Functions
    float getX() {
        return this.x;
    }
    
    float getY() {
        return this.y;
    }
    
    int getSize() {
        return this.size;
    }
    
    float getFuelLevel() {
        return this.fuelLevel;   
    }

    //Mutator Functions
    void setX(float x) {
        this.x = x;
    }
    
    void setY(float y) {
        this.y = y;
    }
    
    public void setSize(int size) {
        this.size = size;
    }
    
    public void setFuelLevel(float fuelLevel) {
        this.fuelLevel = fuelLevel;   
    }

}
