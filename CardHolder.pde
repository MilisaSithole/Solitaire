import java.util.ArrayList;

public abstract class CardHolder {
    PVector pos;
    ArrayList<Card> cards = new ArrayList();

    float cardWidth = width / 7 * 0.9;
    float cardHeight = cardWidth / 2.5 * 3.5;
    float fontSize = cardWidth * 0.3;

    float hiddenHeight = cardHeight * 0.1;

    public CardHolder(float x, float y) {
        pos = new PVector(x, y);
    }

    public abstract void draw();

    public PVector getPos() {
        return pos;
    }

    public void addCard(Card card) {
        card.setPosition(pos);
        cards.add(card);
    }

    public int getSize() {
        return cards.size();
    }

    private void drawVert() {
        int numCards = cards.size() - 1;
        drawHidden(numCards);

        float offset = numCards < 1 ? 0 : hiddenHeight * (numCards + 1);
        cards.get(cards.size()-1).draw(pos.x, pos.y + offset);
    }

    private void drawHidden(int numCards) {
        if (numCards < 1) return;

        fill(250, 50, 100);
        rectMode(CENTER);
        rect(pos.x, pos.y - cardHeight/2 + hiddenHeight*numCards/2, cardWidth, hiddenHeight*numCards, 12);

        textAlign(CENTER, CENTER);
        textSize(hiddenHeight * 0.8);
        fill(51);
        text(numCards, pos.x, pos.y - cardHeight/2 + hiddenHeight*numCards/2);
    }
}