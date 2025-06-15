float cardWidth, cardHeight;
Card cards[] = new Card[52];
CardHolder stock, waste;
CardHolder foundations[] = new CardHolder[4];
CardHolder tableau[] = new CardHolder[7];

void setup() {
    size(1080, 720);
    background(51);

    cardWidth = width / 7 * 0.9;
    cardHeight = cardWidth / 2.5 * 3.5;

    initGame();
}

void draw() {
    
}

void initGame() {
    float margin = cardHeight * 0.1;
    initStockAndWate(margin);
    initFoundations(margin);
    initTableau(margin);

    initCards();
}

void initCards() {
    Suits[] suits = {Suits.SPADES, Suits.HEARTS, Suits.CLUBS, Suits.DIAMONDS};

    int idx = 0;
    for (int rank = 1; rank <= 13; rank++) {
        for (Suits suit: suits) {
            cards[idx++] = new Card(stock.getPos(), rank, suit);
            cards[idx-1].draw();
        }
    }
}

void initStockAndWate(float margin) {
    stock = new CardHolder(cardWidth/2 + margin, cardHeight/2 + margin, StackType.NUM);
    waste = new CardHolder(cardWidth/2 + (margin + cardWidth), cardHeight/2 + margin, StackType.NONE);

    stock.draw();
    waste.draw();
}

void initFoundations(float margin) {
    for (int i = 0; i < foundations.length; i++){
        foundations[i] = new CardHolder(width - (margin + cardWidth * (3 - i)) - (cardWidth/2), cardHeight/2 + margin, StackType.NONE);
        foundations[i].draw();
    }
}

void initTableau(float margin) {
    float start = cardWidth / 2 + margin;
    float end = width - (cardWidth / 2 + margin);

    for (int i = 0; i < tableau.length; i++) {
        tableau[i] = new CardHolder(lerpf(start, end, i, tableau.length-1), cardHeight * 1.5 + margin, StackType.VERT);
        tableau[i].draw();
    }
}

private float lerpf(float start, float stop, float amt) {
    return start + (stop - start) * amt;
}

private float lerpf(float start, float stop, int step, int maxSteps) {
    return lerpf(start, stop, step / (float)maxSteps);
}