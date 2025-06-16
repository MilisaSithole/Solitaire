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
        cards.add(card);
    }

    public int getSize() {
        return cards.size();
    }
}