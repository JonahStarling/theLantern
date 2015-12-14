import java.util.Random;

//Creating variables and objects to be used in game
int i, isGameOver, level, badDirection, k;
float x, y;
Coin coin001;
Enemy enemy001;
Player player001;
Lantern lantern;
Bullet bullet001;
PImage[] playerImages;
PImage fuelImage;
ArrayList<FuelBlock> fuels;
ArrayList<WallRect> walls;
ArrayList<Bullet> bullets;
ArrayList<Enemy> enemies;
ArrayList<Coin> coins;
ArrayList<int[]> vertices;

void setup() {
    //Setting up the settings
    size(800, 800);
    frameRate(60);
    noCursor();
    level = 1;
    //Drawing the Player
    player001 = new Player(0,0,20,20,0);
    lantern = new Lantern(player001.getX(), player001.getY(), 1, 6000);
    generateNewLevel(level);
    isGameOver = 0;
    x = player001.getX();
    bullets = new ArrayList<Bullet>();
    fuels = new ArrayList<FuelBlock>();
    fuelImage = loadImage("fuel.png");
    k = 0;
    playerImages = new PImage[12];
    playerImages[0] = loadImage("player001.png");
    playerImages[1] = loadImage("player002.png");
    playerImages[2] = loadImage("player003.png");
    playerImages[3] = loadImage("player004.png");
    playerImages[4] = loadImage("player005.png");
    playerImages[5] = loadImage("player006.png");
    playerImages[6] = loadImage("player007.png");
    playerImages[7] = loadImage("player008.png");
    playerImages[8] = loadImage("player009.png");
    playerImages[9] = loadImage("player010.png");
    playerImages[10] = loadImage("player011.png");
    playerImages[11] = loadImage("player012.png");
    badDirection = 0;
}


//The draw Function - This loop is like the main
//Built in with processing
//It is run however many times frames per second is set to
void draw() {
    System.out.print(frameRate + "\n");
    //Checks the status of the game
    if (isGameOver == 0) {
        //Gets location of player
        x = player001.getX();
        y = player001.getY();
        //Looks to see if a key is pressed then sees what key
        if (keyPressed) {
            //Normal key presses
            if (key == 'w') {
                if (badDirection != 1) {
                    player001.moveY(-2);
                } else if (checkBoundCollision(x,y,player001.getDirection(),0) == 0) {
                    player001.moveY(-.5);
                }
                player001.changeDirection(1);
                k++;
            } else if (key == 'a') {
                if (badDirection != 2) {
                    player001.moveX(-2);
                } else if (checkBoundCollision(x,y,player001.getDirection(),0) == 0) {
                    player001.moveX(-.5);  
                }
                player001.changeDirection(2);
                k++;
            } else if (key == 's') {
                if (badDirection != 3) {
                    player001.moveY(2);
                } else if (checkBoundCollision(x,y,player001.getDirection(),0) == 0) {
                    player001.moveY(.5);
                }
                player001.changeDirection(3);
                k++;
            } else if (key == 'd') {
                if (badDirection != 4) {
                    player001.moveX(2);
                } else if (checkBoundCollision(x,y,player001.getDirection(),0) == 0) {
                    player001.moveX(.5);
                }
                player001.changeDirection(4);
                k++;
            } else if (key == ' ') {
                if (i == 10) {
                    bullets.add(new Bullet(x+10,y+10,player001.getDirection()));
                }
            } else if (key == 'r') {
                //Pressing r will reset the game
                //Resetting the game causes you to lose all of your coins
                //It also will set you back a level
                if (level != 1) {
                    level--;
                }
                player001.subtractCoins(player001.getNumOfCoins());
                generateNewLevel(level);
            //Keys 1-5 change the size of the lantern
            } else if (key == '1') {
                lantern.setSize(1);   
            } else if (key == '2') {
                lantern.setSize(2);
            } else if (key == '3') {
                lantern.setSize(3);
            } else if (key == '4') {
                lantern.setSize(4);
            } else if (key == '5') {
                lantern.setSize(5);
            }
            //Checking if there is a collision and taking note of the current direction
            x = player001.getX();
            y = player001.getY();
            badDirection = checkAllCollisions(x, y, player001.getDirection(), 0);
        } 
        if (k > 20) {
            k = 0;   
        }
        //Refreshing the board
        fill(#0000FF);
        refreshBoard();
        //Redrawing the player
        player001.updatePlayerAnimation(k, playerImages);
        lantern.setX(player001.getX()+10);
        lantern.setY(player001.getY()+10);
        //This allows the Enemy to move only once every 4 frames (twice a second)
        for (int i = 0; i < enemies.size(); i++) {
            enemies.get(i).moveTowardsPlayer(x, y);   
        }
        for (int i = 0; i < enemies.size(); i++) {
            enemies.get(i).redrawEnemy();   
        }
    } else if (isGameOver == 1) {
        //The game has been won
        //This is a delay timer
        //It pauses for 3 seconds
        int m = millis();
        while(millis() < m+2000);
        lantern.setX(10);
        lantern.setY(10);
        //Generating a new level
        level++;
        generateNewLevel(level);
        //Reset the value
        isGameOver = 0;   
    }
    //Checks to make sure the game isn't already over
    if (isGameOver != 2) {
        //Checking on the coins
        for (int i = 0; i < coins.size(); i++) {
            //Checks if the coins have been picked up
            if (!coins.get(i).found && coins.get(i).pickedUp(x, y, 20, 20)) {
                player001.addCoins(1);
            }
        }
        //Check on the Fuel Blocks
        for (int i = 0; i < fuels.size(); i++) {
            //Checks if the fuels have been picked up
            if (fuels.get(i).pickedUp(x, y, 20, 20)) {
                lantern.addFuel(fuels.get(i).getFuel());
                fuels.remove(i);
            }
        }
        //Checks if the game is over and stores its value
        isGameOver = checkGameOver();   
    }
    //We check if the game is over so bullets only appear in game
    if (isGameOver == 0) {
        //Loops through the Bullets and moves them
        for (int i = 0; i < bullets.size(); i++) {
            for (int j = 0; j < walls.size(); j++) {
                if (!walls.get(j).checkCollision(bullets.get(i).getX(), bullets.get(i).getY(), 3, 3)) {
                    bullets.get(i).setActive(false);
                }
            }
            for (int j = 0; j < enemies.size(); j++) {
                if (!enemies.get(j).checkHit(bullets.get(i).getX(), bullets.get(i).getY(), 3, 3)) {
                    bullets.get(i).setActive(false);   
                    if (!enemies.get(j).checkAlive()) {
                        //The enemy has a 1 in 5 chance of dropping a fuel block
                        if (randInt(1,5) == 1) {
                            fuels.add(new FuelBlock(enemies.get(j).getX(), enemies.get(j).getY(), ((level*200)+600)));
                        }
                        //Player gets coins for killing an enemy
                        player001.addCoins(level);
                        enemies.remove(j);
                    }
                }
            }
            if (bullets.get(i).getActive()) {
                bullets.get(i).shootBullet();
            } else {
                bullets.remove(i);   
            }
        }
        lantern.redrawLantern();
    }
    if (i < 11) {
        i++;
    } else {
        i = 0;   
    }
}



//The keyPressed Function - Only called when a key is pressed
//We look at 'q' and 'e' in this function that way you only get called once per press
//This keeps the player from spinning out of control
void keyPressed() {
    if (key == 'q') {
        player001.rotatePlayerLeft(); 
    } else if (key == 'e') {
        player001.rotatePlayerRight();
    }
}



//The randInt Function - Gets a random int between max and min
//@param min is the smallest number that can be picked
//@param max is the largest number that can be picked
//@return randomNum is an integer between min and max
int randInt(int min, int max) {
    Random rand = new Random();
    int randomNum = rand.nextInt((max - min) + 1) + min;
    return randomNum;
}



//The randInt Function - Gets a random int between max and min on an interval
//Example: The parameters 11,49,10 could give you 10,20,30,40
//The bottom and top number are rounded down and inclusive of both ends
//It rounds down to the nearest number divisible by the interval
//@param min is the bottom number (may be rounded down)
//@param max is the top number (may be rounded down)
//@param interval is the number to skip by
//@return randomNum generated by the algorithm
int randInt(int min, int max, int interval) {
    Random rand = new Random();
    int randomNum = (rand.nextInt((max/interval - min/interval) + 1) + min/interval) * interval;
    return randomNum;
}



//The refreshBoard Function - Redraws the map
void refreshBoard() {
    //Redrawing the background
    fill(#888888);
    rect(0, 0, 800, 800);
    fill(#000000);
    //Redrawing the Walls
    for (int i = 0; i < walls.size (); i++) {
        walls.get(i).redrawWall();
    }
    //Redrawing the Coins
    for (int i = 0; i < coins.size(); i++) {
        coins.get(i).redrawCoin();   
    }
    //Redrawing the Fuel Blocks
    for (int i = 0; i < fuels.size(); i++) {
        fuels.get(i).redrawFuelBlock();   
    }
    fill(#0000FF);
}



//The checkAllCollisions Function - Checks collision with all walls and bounds
//@param x is the current x location of the player
//@param y is the current y location of the player
//@param direction is the way the player is trying to walk
//@param noCollision is the value to return if no collisions are detected
//@return collision is the direction of the collision or the noCollision default
int checkAllCollisions(float x, float y, int direction, int noCollision) {
    int collision = noCollision;
    //Updates the movement values to see whether the step you want to take is ok
    switch(direction) {
        //Normal stepping
        case 1: 
            y -= 2; 
            break;
        case 2: 
            x -= 2;
            break;
        case 3: 
            y += 2;
            break;
        case 4: 
            x += 2;
            break;
    }
    collision = checkBoundCollision(x,y,direction,noCollision);
    //Loops through the walls to get the collision
    for (int i = 0; i < walls.size (); i++) {
        if (!walls.get(i).checkCollision(x, y, player001.getSizeX(), player001.getSizeY())) {
            collision = direction;
        }
    }
    return collision;
}

//The checkBoundCollision Function - Checks for collisions with the boundaries
//@param x is the current x location of the player
//@param y is the current y location of the player
//@param direction is the way the player is trying to walk
//@param noCollision is the value to return if no collisions are detected
//@return collision is the direction of the collision or the noCollision default
int checkBoundCollision(float x, float y, int direction, int noCollision) {
    int collision = noCollision;
    //Checks collision with the boundaries
    if (x < 0) {
        collision = direction;
    } else if (y < 0) {
        collision = direction;
    } else if (x > 780) {
        collision = direction;
    } else if (y > 780) {
        collision = direction;
    }
    return collision;
}

//The checkGameOver Function - Checks if the user has the coin or has died
//@param player001 is the player object that the user controls
//@return isGameOver is a 0 if no, 1 if win, 2 if loss
int checkGameOver() {
    //This is the value we will return
    int isGameOver = 0;
    if (lantern.getFuelLevel() > 0) {
        //Checks to see if the user has the coin
        boolean allCoinsFound = true;
        for (int i = 0; i < coins.size(); i++) {
            if (!coins.get(i).getFound()) {
                allCoinsFound = false;   
            }
        }
        if (allCoinsFound) {
            //Level beaten
            isGameOver = 1;   
            //Draw the Game Won Screen
            fill(#00FF00);
            rect(0,0,800,800);
            fill(#000000);
            textSize(16);
            textAlign(CENTER);
            String levelString = "LEVEL " + level + " COMPLETE";
            text(levelString, 400, 400);
            String scoreString = "CURRENT SCORE: " + player001.getNumOfCoins();
            text(scoreString, 400, 420);
        }
        //Loops through enemies
        for (int i = 0; i < enemies.size(); i++) {
            //Checks if the player has lost
            if (x > (enemies.get(i).getX()-player001.getSizeX()) && x < (enemies.get(i).getX() + 20)) {
                if (y > (enemies.get(i).getY()-player001.getSizeY()) && y < (enemies.get(i).getY() + 20)) { 
                   //Game Loss
                   isGameOver = 2;
                   //Draw the Game Over Screen
                   fill(#FF0000);
                   rect(0,0,800,800);
                   fill(#000000);
                   textSize(16);
                   textAlign(CENTER);
                   text("GAME OVER - YOU DIED", 400, 400);
                   String scoreString = "SCORE: " + player001.getNumOfCoins();
                   text(scoreString, 400, 420);
                }
            }
        }
    } else {
        isGameOver = 2;
        //Draw the Game Over Screen
        fill(#FF0000);
        rect(0,0,800,800);
        fill(#000000);
        textSize(16);
        textAlign(CENTER);
        text("GAME OVER - NO FUEL", 400, 400);
        String scoreString = "SCORE: " + player001.getNumOfCoins();
        text(scoreString, 400, 420);
    }
    return isGameOver;
}

//The generateNewLevel function - Creates a new random level
//@param level is the current level the player is on
void generateNewLevel(int level) {
    //Drawing the background
    fill(#888888);
    rect(0, 0, 800, 800);
    //Creates grid lines for debugging and testing
    fill(#000000);
    //ArrayList of WallRect objects
    walls = new ArrayList<WallRect>();
    //Build the horizontal walls
    for (int i = 0; i != 5; i++) {
        walls.add(new WallRect(randInt(20, 760, 40), randInt(0, 760, 40), randInt(40, 760, 40), 40));
    }
    //Build the vertical walls
    for (int i = 0; i != 5; i++) {
        walls.add(new WallRect(randInt(0, 760, 40), randInt(20, 760, 40), 40, randInt(40, 760, 40)));
    }
    //Add vertices of the walls to the ArrayList of vertices
    vertices = new ArrayList<int[]>();
    //int[] mapTL = {0,0};
    //vertices.add(mapTL);
    //int[] mapTR = {800,0};
    //vertices.add(mapTR);
    //int[] mapBL = {0,800};
    //vertices.add(mapBL);
    //int[] mapBR = {800,800};
    //vertices.add(mapBR);
    for (int i = 0; i != 10; i++) {
        //Add vertices to arraylist 
        //Top left corner
        int[] topLeft = {walls.get(i).x,walls.get(i).y};
        vertices.add(topLeft);
        //Top right corner
        int[] topRight = {walls.get(i).x+walls.get(i).sizeX,walls.get(i).y};
        vertices.add(topRight);
        //Bottom left corner
        int[] botLeft = {walls.get(i).x,walls.get(i).y+walls.get(i).sizeY};
        vertices.add(botLeft);
        //Bottom right corner
        int[] botRight = {walls.get(i).x+walls.get(i).sizeX,walls.get(i).y+walls.get(i).sizeY};
        vertices.add(botRight);
    }
    //ArrayList of Coin Objects
    coins = new ArrayList<Coin>();
    //Creating the coins to populate the ArrayList
    for (int i = 0; i != level; i++) {
        coins.add(new Coin(randInt(0, 760, 40), randInt(0, 760, 40)));
    }
    //ArrayList of Enemy Objects
    enemies = new ArrayList<Enemy>();
    //Creating the enemies to populate the ArrayList
    for (int i = 0; i != level; i++) {
        enemies.add(new Enemy(randInt(80, 760, 40), randInt(80, 760, 40),level,level));
    }
    //Resetting the player back to the start
    player001.setX(0);
    player001.setY(0);
    player001.redrawPlayer();
    lantern.setFuelLevel(6000);
    lantern.setSize(1);
    lantern.setVertices(vertices);
    lantern.redrawLantern();
    i = 0;
}