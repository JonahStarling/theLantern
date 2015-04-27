class Bullet {
    float x;
    float y;
    int direction;
    boolean active;
    Bullet(float x, float y, int direction) {
        this.x = x;
        this.y = y;
        this.direction = direction;
        this.active = true;
        rect(x,y,2,2);
    }   
    //The moveY Function - Moves the Y coordinate of the Bulelt
    //@param distToMove is how far the bullet will move
    void moveY(float distToMove) {
        this.y += distToMove;    
    }
    //The moveX Function - Moves the X coordinate of the Bullet
    //@param distToMove is how far the bullet will move
    void moveX(float distToMove) {
        this.x += distToMove;    
    }
    void redrawBullet() {
        fill(#00FF00);
        rect(this.x, this.y, 2, 2);   
    }
    void shootBullet() {
        if (this.direction == 1) {
            moveY(-10.0);
        } else if (this.direction == 2) {
            moveX(-10.0);
        } else if (this.direction == 3) {
            moveY(10.0);
        } else {
            moveX(10.0);
        }
        redrawBullet();
    }
    void checkActive() {
        if (this.x > 200 || this.x < 0 || this.y > 200 || this.y < 0) {
            this.active = false;
        }   
    }
    boolean getActive() {
        return this.active;   
    }
}
