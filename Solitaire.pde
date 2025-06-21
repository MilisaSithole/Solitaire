GameManager gameManager;

void setup() {
    size(1080, 720);
    background(51);

    gameManager = new GameManager();
}

void draw() {
    background(51);
    gameManager.draw();
}

void mousePressed() {
    gameManager.handleClick(mouseX, mouseY);
}

void keyPressed() {
    if (key == 'r') {
        gameManager = new GameManager();
    }
}