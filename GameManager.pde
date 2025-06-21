public class GameManager {
    Stock stock;
    Waste waste;
    Foundation foundations[] = new Foundation[4];
    Tableau tableau[] = new Tableau[7];
    float cardWidth, cardHeight;

    Card selectedCard;
    Integer selectedCardFrom; // 0: waste, 1-4: foundations, 5-11: tableau
    Integer selectedTableau, selectedFoundation;

    public GameManager() {
        initGame();
    }

    public void draw() {
        stock.draw();
        waste.draw();
        for (Foundation foundation: foundations) {
            foundation.draw();
        }
        for (Tableau t: tableau) {
            t.draw();
        }
    }

    public void handleClick(float x, float y) {
        if (stock.isClicked(x, y)){
            println("Stock clicked at: " + x + ", " + y);

            clearHighlight();
            selectedCard = stock.handleClick();

            if (selectedCard != null) {
                waste.addCard(selectedCard);
                selectedCard = null;
            }
            else
                stock.initCards(waste.popAll());
        }
        else if (waste.isClicked(x, y)) {
            println("Waste clicked at: " + x + ", " + y);

            if (selectedCard != null && selectedCardFrom != 0) {
                returnSelectedCard();
                clearHighlight();
            }

            selectedCard = waste.handleClick();
            handleSetSelectedCardFrom(0);
        }
        else if (tableauIsClicked(x, y)) {
            println("Tableau clicked at: " + x + ", " + y);

            if (selectedCard != null) {
                tableau[selectedTableau].addCard(selectedCard);
                popSelectedCard();
            }
            else {
                selectedCard = tableau[selectedTableau].handleClick();
                handleSetSelectedCardFrom(5 + selectedTableau);
            }
        }
        else if (foundationIsClicked(x, y)) {
            println("Foundation clicked at: " + x + ", " + y);
            
            if (selectedCard != null) {
                foundations[selectedFoundation].addCard(selectedCard);
                popSelectedCard();
            }
            else {
                selectedCard = foundations[selectedFoundation].handleClick();
                handleSetSelectedCardFrom(1 + selectedFoundation);
            }
        }

        println("Selected Card: " + selectedCard);
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
        float startX = cardWidth / 2 + margin;
        float endX = width - (cardWidth / 2 + margin);

        for (int i = 0; i < foundations.length; i++){
            foundations[i] = new Foundation(lerpf(startX, endX, i + 3, tableau.length-1), 
                cardHeight/2 + margin,
                cardWidth, 
                cardHeight);
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

    private boolean tableauIsClicked(float x, float y) {
        for (int i = 0; i < tableau.length; i++) {
            boolean isClicked = tableau[i].isClicked(x, y);
            if (isClicked) {
                selectedTableau = i;
                return isClicked;
            }
        }

        return false;
    }

    private boolean foundationIsClicked(float x, float y) {
        for (int i = 0; i < foundations.length; i++) {
            boolean isClicked = foundations[i].isClicked(x, y);
            if (isClicked) {
                selectedFoundation = i;
                return isClicked;
            }
        }

        return false;
    }

    private void returnSelectedCard() {
        if (selectedCard != null) {
            if (selectedCardFrom == 0) {
                waste.addCard(selectedCard);
            } else if (selectedCardFrom >= 1 && selectedCardFrom <= 4) {
                foundations[selectedCardFrom - 1].addCard(selectedCard);
            } else if (selectedCardFrom >= 5 && selectedCardFrom <= 11) {
                tableau[selectedCardFrom - 5].addCard(selectedCard);
            }
            clearSelected();
        }
    }

    private void popSelectedCard() {
        if (selectedCard != null) {
            if (selectedCardFrom == 0) {
                waste.popCard();
            } else if (selectedCardFrom >= 1 && selectedCardFrom <= 4) {
                foundations[selectedCardFrom - 1].popCard();
            } else if (selectedCardFrom >= 5 && selectedCardFrom <= 11) {
                tableau[selectedCardFrom - 5].popCard();
            }
            clearSelected();
        }
    }

    private void clearHighlight() {
        waste.unselect();
        for (Foundation foundation: foundations) {
            foundation.unselect();
        }
        for (Tableau t: tableau) {
            t.unselect();
        }
    }

    private void handleSetSelectedCardFrom(int from) {
        if (selectedCard != null) {
            selectedCardFrom = from;
        } else {
            selectedCardFrom = null;
        }
    }

    private void clearSelected() {
        selectedCard = null;
        selectedCardFrom = null;
        clearHighlight();
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