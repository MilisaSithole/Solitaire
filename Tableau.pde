public class Tableau extends CardHolder {
    float hiddenHeight;

    public Tableau(float x, float y) {
        super(x, y);
    }

    @Override
    public void draw() {
        int numHiddenCards = cards.size() - 1;
        drawHidden(numHiddenCards);

        float offset = numHiddenCards < 1 ? 0 : hiddenHeight * (numHiddenCards + 1);
        cards.get(cards.size()-1).draw(pos.x, pos.y + offset);
    }

    @Override
    public void initCards(ArrayList<Card> cards) {
        super.initCards(cards);
        hiddenHeight = cardHeight * 0.05;
    }

    private void drawHidden(int numHiddenCards) {
        if (numHiddenCards < 1) return;

        fill(250, 50, 100);
        rectMode(CENTER);
        float y = pos.y - cardHeight/2 + hiddenHeight*numHiddenCards/2;
        rect(pos.x, y, cardWidth, hiddenHeight*numHiddenCards, 12);
    }
}
