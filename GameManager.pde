public class GameManager {
    Stock stock;
    Waste waste;
    Waste foundations[] = new Waste[4];
    Tableau tableau[] = new Tableau[7];
    float cardWidth, cardHeight;

    public GameManager() {
        initGame();
    }

    public void draw() {
        stock.draw();
        waste.draw();
        for (Waste foundation : foundations) {
            foundation.draw();
        }
        for (Tableau t : tableau) {
            t.draw();
        }
    }

    public void handleClick(float x, float y) {
        if (stock.isClicked(x, y)){
            Card drawnCard = stock.handleClick();
            println("Card drawn from stock: " + drawnCard);

            if (drawnCard != null)
                waste.addCard(drawnCard);
            else
                stock.initCards(waste.popAll());
        }
    }

    private void initGame() {
        ArrayList<Card> cards = initCards();
        cardWidth = cards.get(0).getWidth();
        cardHeight = cards.get(0).getHeight();

        float margin = cardHeight * 0.1;
        initTableau(margin, cards);
        initStockAndWaste(margin, cards);
        initFoundations(margin);
    }

    private ArrayList<Card> initCards() {
        ArrayList<Card> cards = new ArrayList<>();
        Suits[] suits = {Suits.SPADES, Suits.HEARTS, Suits.CLUBS, Suits.DIAMONDS};

        for (int rank = 1; rank <= 13; rank++) {
            for (Suits suit: suits) {
                cards.add(new Card(rank, suit));
            }
        }

        shuffleCards(cards);
        return cards;
    }

    private void initStockAndWaste(float margin, ArrayList<Card> cards) {
        float startX = cardWidth / 2 + margin;
        float endX = width - (cardWidth / 2 + margin);

        stock = new Stock(lerpf(startX, endX, 0, tableau.length-1), cardHeight/2 + margin);
        stock.initCards(cards);
        waste = new Waste(lerpf(startX, endX, 1, tableau.length-1), cardHeight/2 + margin);

        stock.draw();
        waste.draw();
    }

    private void initFoundations(float margin) {
        for (int i = 0; i < foundations.length; i++){
            foundations[i] = new Waste(width - (margin + cardWidth * (3 - i)) - (cardWidth/2), cardHeight/2 + margin);
            foundations[i].draw();
        }
    }

    private void initTableau(float margin, ArrayList<Card> cards) {
        float startX = cardWidth / 2 + margin;
        float endX = width - (cardWidth / 2 + margin);

        for (int i = 0; i < tableau.length; i++) {
            tableau[i] = new Tableau(lerpf(startX, endX, i, tableau.length-1), cardHeight * 1.5 + margin * 2);
            ArrayList<Card> tableauCards = new ArrayList<>();
            for (int j = 0; j < i+1; j++) {
                tableauCards.add(cards.remove(0));
            }
            tableau[i].initCards(tableauCards);
            tableau[i].draw();
        }
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

    private float lerpf(float start, float stop, float amt) {
        return start + (stop - start) * amt;
    }

    private float lerpf(float start, float stop, int step, int maxSteps) {
        return lerpf(start, stop, step / (float)maxSteps);
    }
}