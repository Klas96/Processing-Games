// Player variables
float playerX, playerY;
float playerSpeed = 4; // Slightly reduced speed for better collision handling
int playerSize = 20;
color playerColor;

// Canvas size
int canvasWidth = 600;
int canvasHeight = 400;

// Obstacles
class Obstacle {
  float x, y, w, h;
  Obstacle(float _x, float _y, float _w, float _h) {
    x = _x; y = _y; w = _w; h = _h;
  }
  void display() {
    fill(100); // Gray
    rectMode(CORNER);
    rect(x, y, w, h);
  }
}
ArrayList<Obstacle> obstacles;

// Coins
class Coin {
  float x, y;
  int size = 10;
  boolean collected = false;
  Coin(float _x, float _y) {
    x = _x; y = _y;
  }
  void display() {
    if (!collected) {
      fill(255, 223, 0); // Yellow
      ellipseMode(CENTER);
      ellipse(x, y, size, size);
    }
  }
}
ArrayList<Coin> coins;

// Game State & UI
int coinsCollected = 0;
int totalCoins;
boolean gameOver = false;

void setup() {
  size(canvasWidth, canvasHeight);
  playerX = width / 2;
  playerY = height / 2;
  playerColor = color(255, 0, 0); // Red

  obstacles = new ArrayList<Obstacle>();
  // Add some obstacles
  obstacles.add(new Obstacle(100, 100, 80, 20));
  obstacles.add(new Obstacle(300, 200, 20, 100));
  obstacles.add(new Obstacle(450, 50, 100, 30));
  obstacles.add(new Obstacle(50, 300, 150, 20));


  coins = new ArrayList<Coin>();
  // Add some coins (ensure they are not inside obstacles)
  coins.add(new Coin(50, 50));
  coins.add(new Coin(550, 350));
  coins.add(new Coin(300, 150));
  coins.add(new Coin(150, 250));
  coins.add(new Coin(500, 150));

  totalCoins = coins.size();
}

void draw() {
  background(200); // Light gray background

  if (gameOver) {
    fill(0, 150, 0); // Green text
    textSize(64);
    textAlign(CENTER, CENTER);
    text("You Win!", width / 2, height / 2);
    textSize(20);
    text("Coins collected: " + coinsCollected + "/" + totalCoins, width / 2, height / 2 + 50);
    return; // Stop further game updates
  }

  // --- Player Movement and Collision Handling ---
  float prevX = playerX;
  float prevY = playerY;

  // Tentative movement
  float targetX = playerX;
  float targetY = playerY;

  if (keyPressed) {
    if (keyCode == UP) {
      targetY -= playerSpeed;
    }
    if (keyCode == DOWN) {
      targetY += playerSpeed;
    }
    if (keyCode == LEFT) {
      targetX -= playerSpeed;
    }
    if (keyCode == RIGHT) {
      targetX += playerSpeed;
    }
  }

  // Constrain to canvas boundaries first
  targetX = constrain(targetX, playerSize / 2, width - playerSize / 2);
  targetY = constrain(targetY, playerSize / 2, height - playerSize / 2);

  // Check collision with obstacles for X movement
  playerX = targetX;
  for (Obstacle obs : obstacles) {
    if (checkPlayerObstacleCollision(obs)) {
      playerX = prevX; // Revert X if collision
      break;
    }
  }

  // Check collision with obstacles for Y movement
  playerY = targetY;
  for (Obstacle obs : obstacles) {
    // Important: use current playerX (which might have been reverted or not)
    // and the new targetY to check this potential Y move.
    // However, if playerX was reverted, we are checking collision as if playerX didn't change,
    // and playerY is changing. If playerX was NOT reverted, we are checking the new X and new Y.
    // A more precise way is to check collision against the new playerX and prevY, then prevX and new playerY.
    // For simplicity, let's check the final targetX and targetY step-by-step.
    // The current playerX is already set to its new valid or reverted state.
    // Now we check if the new playerY combined with the current playerX causes a collision.
    if (checkPlayerObstacleCollision(obs)) {
      playerY = prevY; // Revert Y if collision
      break;
    }
  }

  // --- Coin Collection ---
  for (int i = coins.size() - 1; i >= 0; i--) {
    Coin coin = coins.get(i);
    if (!coin.collected) {
      float d = dist(playerX, playerY, coin.x, coin.y);
      if (d < playerSize / 2 + coin.size / 2) {
        coin.collected = true;
        coinsCollected++;
        // Optional: coins.remove(i); if not using collected flag and want to actually remove
      }
    }
  }

  // --- Draw everything ---
  // Draw obstacles
  for (Obstacle obs : obstacles) {
    obs.display();
  }

  // Draw coins
  for (Coin coin : coins) {
    coin.display();
  }

  // Draw player
  fill(playerColor);
  ellipseMode(CENTER);
  ellipse(playerX, playerY, playerSize, playerSize);

  // --- UI ---
  fill(0); // Black text
  textSize(20);
  textAlign(LEFT, TOP);
  text("Coins left: " + (totalCoins - coinsCollected), 10, 10);

  // --- Check Win Condition ---
  if (coinsCollected == totalCoins) {
    gameOver = true;
  }
}

// Player-Obstacle collision check (player as a square for simplicity here)
boolean checkPlayerObstacleCollision(Obstacle obstacle) {
  // Player's bounding box
  float playerLeft = playerX - playerSize / 2;
  float playerRight = playerX + playerSize / 2;
  float playerTop = playerY - playerSize / 2;
  float playerBottom = playerY + playerSize / 2;

  // Obstacle's bounding box
  float obstacleLeft = obstacle.x;
  float obstacleRight = obstacle.x + obstacle.w;
  float obstacleTop = obstacle.y;
  float obstacleBottom = obstacle.y + obstacle.h;

  // Check for collision
  return (playerRight > obstacleLeft &&
          playerLeft < obstacleRight &&
          playerBottom > obstacleTop &&
          playerTop < obstacleBottom);
}
