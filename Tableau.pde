public class Tableau extends CardHolder {
    float hiddenHeight, hiddenOffset, cardOffset;
    ArrayList<Card> hiddenCards = new ArrayList<>();

    public Tableau(float x, float y) {
        super(x, y);
    }

    @Override
    public void draw() {
        drawHidden();

        drawVisible();
        // cards.get(cards.size()-1).draw(pos.x, pos.y + hiddenOffset);
    }

    @Override
    public void initCards(ArrayList<Card> cards) {
        super.initCards(cards);
        hiddenHeight = cardHeight * 0.05;

        for (int i = 0; i < cards.size() - 1; i++) {
            hiddenCards.add(super.cards.remove(0));
        }
    }

    @Override
    public Card popCard() {
        println();

        if (cards.size() > 1) {
            return cards.remove(cards.size() - 1);
        }
        else if (cards.size() == 1 && hiddenCards.size() > 0) {
            Card lastCard = cards.remove(0);
            addCard(hiddenCards.remove(hiddenCards.size() - 1));
            return lastCard;
        }
        else if (cards.size() == 1 && hiddenCards.size() == 0) {
            return cards.remove(0);
        }
        return null;
    }

    private void drawHidden() {
        hiddenOffset = hiddenCards.size() < 1 ? 0 : hiddenHeight * (hiddenCards.size() + 1);
        if (hiddenCards.size() < 1) return;

        noStroke();
        fill(250, 50, 100);
        rectMode(CENTER);
        float y = pos.y - cardHeight/2 + hiddenHeight*hiddenCards.size()/2;
        rect(pos.x, y, cardWidth, hiddenHeight*hiddenCards.size(), 12);
    }

    private void drawVisible() {
        if (cards.size() < 1) return;

        cardOffset = cardHeight * 0.25;
        for (int i = 0; i < cards.size(); i++) {
            cards.get(i).draw(pos.x, pos.y + hiddenOffset + (i * cardOffset));
        }
    }

    public void printSummary() {
        println("Tableau at " + pos.x + ", " + pos.y);
        println("Visible cards: " + cards.size());
        println("Hidden cards: " + hiddenCards.size());
        println();
    }
}