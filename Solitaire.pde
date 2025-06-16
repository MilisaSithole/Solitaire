float cardWidth, cardHeight;
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
    ArrayList<Card> cards = initCards();

    float margin = cardHeight * 0.1;
    initTableau(margin, cards);
    initStockAndWaste(margin, cards);
    initFoundations(margin);
}

ArrayList<Card> initCards() {
    ArrayList<Card> cards = new ArrayList<Card>();
    Suits[] suits = {Suits.SPADES, Suits.HEARTS, Suits.CLUBS, Suits.DIAMONDS};

    for (int rank = 1; rank <= 13; rank++) {
        for (Suits suit: suits) {
            cards.add(new Card(rank, suit));
        }
    }

    shuffleCards(cards);
    return cards;
}

void initStockAndWaste(float margin, ArrayList<Card> cards) {
    stock = new CardHolder(cardWidth/2 + margin, cardHeight/2 + margin, StackType.NUM);
    for (Card card: cards)
        stock.addCard(card);
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

void initTableau(float margin, ArrayList<Card> cards) {
    float start = cardWidth / 2 + margin;
    float end = width - (cardWidth / 2 + margin);

    for (int i = 0; i < tableau.length; i++) {
        tableau[i] = new CardHolder(lerpf(start, end, i, tableau.length-1), cardHeight * 1.5 + margin, StackType.VERT);
        for (int j = 0; j < i+1; j++) {
            tableau[i].addCard(cards.remove(0));
        }
        tableau[i].draw();
    }
}

private float lerpf(float start, float stop, float amt) {
    return start + (stop - start) * amt;
}

private float lerpf(float start, float stop, int step, int maxSteps) {
    return lerpf(start, stop, step / (float)maxSteps);
}

private void shuffleCards(ArrayList<Card> cards) {
    for (int i = 0; i < cards.size() * 3; i++) {
        int idx1 = (int) random(cards.size());
        int idx2 = (int) random(cards.size());
        
        Card temp = cards.get(idx1);
        cards.set(idx1, cards.get(idx2));
        cards.set(idx2, temp);
    }
}
